#! /usr/bin/env python3
# Copyright © 2023 Dan Zeman <zeman@ufal.mff.cuni.cz>
import fileinput
import sys
import io
import os.path
import argparse
import logging
import traceback
# According to https://stackoverflow.com/questions/1832893/python-regex-matching-unicode-properties,
# the regex module has the same API as re but it can check Unicode character properties using \p{}
# as in Perl.
#import re
import regex as re
import unicodedata
import json


THISDIR=os.path.dirname(os.path.realpath(os.path.abspath(__file__))) # The folder where this script resides.

# Global variables:
curr_fname = None # Current input file
curr_line = 0 # Current line in the input file
sentence_line = 0 # The line in the input file on which the current sentence starts
sentence_id = None # The most recently read sentence id
error_counter = {} # key: error type value: error count
warn_on_missing_files = set() # langspec files which you should warn about in case they are missing (can be deprel, edeprel, feat_val, tokens_w_space)

def warn(msg, testclass, testlevel, testid, lineno=0, explanation=None):
    """
    Print the error/warning message.
    If lineno is 0, print the number of the current line (most recently read from input).
    If lineno is < 0, print the number of the first line of the current sentence.
    If lineno is > 0, print lineno (probably pointing somewhere in the current sentence).
    If explanation contains a string and this is the first time we are reporting
    an error of this type, the string will be appended to the main message. It
    can be used as an extended explanation of the situation.
    """
    global curr_fname, curr_line, sentence_line, sentence_id, error_counter, args
    error_counter[testclass] = error_counter.get(testclass, 0)+1
    if not args.quiet:
        if args.max_err > 0 and error_counter[testclass] == args.max_err:
            print(('...suppressing further errors regarding ' + testclass), file=sys.stderr)
        elif args.max_err > 0 and error_counter[testclass] > args.max_err:
            pass # suppressed
        else:
            if explanation and error_counter[testclass] == 1:
                msg += ' ' + explanation
            if len(args.input) > 1: # several files, should report which one
                if curr_fname=='-':
                    fn = '(in STDIN) '
                else:
                    fn = '(in '+os.path.basename(curr_fname)+') '
            else:
                fn = ''
            sent = ''
            node = ''
            # Global variable (last read sentence id): sentence_id
            if sentence_id:
                sent = ' Sent ' + sentence_id
            if lineno > 0:
                print("[%sLine %d%s%s]: [L%d %s %s] %s" % (fn, lineno, sent, node, testlevel, testclass, testid, msg), file=sys.stderr)
            elif lineno < 0:
                print("[%sLine %d%s%s]: [L%d %s %s] %s" % (fn, sentence_line, sent, node, testlevel, testclass, testid, msg), file=sys.stderr)
            else:
                print("[%sLine %d%s%s]: [L%d %s %s] %s" % (fn, curr_line, sent, node, testlevel, testclass, testid, msg), file=sys.stderr)

#------------------------------------------------------------------------------
# Support functions.
#------------------------------------------------------------------------------

ws_re = re.compile(r"^\s+$")
def is_whitespace(line):
    return ws_re.match(line)

tws_re = re.compile(r"\s+$")
def has_trailing_whitespace(line):
    return tws_re.search(line)
def remove_trailing_whitespace(line):
    return tws_re.sub('', line)

lws_re = re.compile(r"^\s+")
def remove_leading_whitespace(line):
    return lws_re.sub('', line)

root_re = re.compile(r"^\(")
def is_root(line):
    return root_re.match(line)

attr_re = re.compile(r"^:[A-Za-z][-A-Za-z0-9]+")
def is_attribute(line):
    return attr_re.match(line)

align_re = re.compile(r"^s[0-9]+[a-z0-9]+:")
def is_alignment(line):
    return align_re.match(line)

def shorten(string):
    return string if len(string) < 25 else string[:20]+'[...]'



#==============================================================================
# Level 1 tests. Only technical format backbone.
#==============================================================================

sentid_re = re.compile(r"^#\s*::\s*(snt[0-9]+)\s")
sentid_tokens_re = re.compile(r"^# :: (snt[0-9]+)\s+(.+)")

def sentences(inp, args):
    """
    `inp` a file-like object yielding lines as unicode
    `args` are needed for choosing the tests

    This function does elementary checking of the input and yields one
    sentence at a time from the input stream.

    This function is a generator. The caller can call it in a 'for x in ...'
    loop. In each iteration of the caller's loop, the generator will generate
    the next sentence, that is, it will read the next sentence from the input
    stream. (Technically, the function returns an object, and the object will
    then read the sentences within the caller's loop.)

    A sentence in a UMR file consists of:
    - Comment lines. Their first character is '#'. Some of them may contain
      machine-readable metadata. Others can be ignored.
    - Empty lines. An empty line separates two annotation blocks of the same
      sentence (e.g., document level graph from sentence level graph). Two empty
      lines separate sentences. Empty lines must not occur inside annotation
      blocks, e.g., inside the sentence level graph.
    - Graph lines (either sentence level graph, or document level annotation).
      They may start with whitespace (' ', "\t") and they typically do, except
      for the first line of the graph. Whitespace can be ignored (but we may
      want to report trailing whitespace, just to tidy up). After whitespace,
      there must be either the opening bracket ('(') or a colon (':'). One or
      more closing brackets may occur at the end of the line; they are never
      put on a line of their own.
    - Every opening bracket must be immediately followed by a variable id (e.g.,
      's1p'), a slash ('/'), and a concept string.
    - Every colon must be immediately followed by a relation/attribute label,
      then whitespace and either an atomic value, or a string in double quotes,
      or the opening bracket of a child node.
    - The alignment block has its own type of lines. It starts with a variable
      id of a concept node in the sentence graph, followed by a colon and
      a space, followed by an integer range (e.g. '2-2'). These are 1-based
      indices of tokens that represent the concept node on the surface. '0-0'
      means that the concept is not overtly represented on the surface.
    """
    # global curr_line ... holds the 1-based number of the last read line; used in error messages
    # global sentence_line ... holds the 1-based number of the first line of the current sentence; used in error messages
    # global sentence_id ... holds the id of the current sentence (or better: the most recently seen sentence id); used in error messages
    global curr_line, sentence_line, sentence_id
    blocks = [] # List of the annotation blocks (sentence annotation, document level annotation) of the current sentence.
    bline0 = None # Number of the line where the current block starts.
    comments = [] # List of the comment lines at the beginning of the current block.
    lines = [] # List of the non-comment lines of the current block.
    corrupt = False # In case of spurious line check the remaining lines of the sentence but do not yield the sentence for further processing.
    testlevel = 1
    testclass = 'Format'
    for line_counter, line in enumerate(inp):
        curr_line = line_counter + 1
        if not sentence_line:
            sentence_line = curr_line
        if not bline0:
            bline0 = curr_line
        line = line.rstrip("\n")
        if has_trailing_whitespace(line):
            if args.check_trailing_whitespace:
                testid = 'trailing-whitespace'
                testmessage = 'Trailing whitespace should be removed.'
                warn(testmessage, testclass, testlevel, testid)
            line = remove_trailing_whitespace(line)
        validate_unicode_normalization(line)
        # Unlike trailing whitespace, leading whitespace is legitimate (indentation) but we ignore it anyway.
        line = remove_leading_whitespace(line)
        if not line: # empty line means end of block (and possibly end of sentence)
            if comments or lines: # end of an annotation block
                blocks.append({'line0': bline0, 'comments': comments, 'lines': lines})
                bline0 = None
                comments = []
                lines = []
                ###!!! Sentences typically have 4 annotation blocks: 1. intro; 2. sentence level; 3. alignment; 4. document level.
                ###!!! If we see more blocks, maybe someone forgot to add a second empty line between sentences.
                if len(blocks) > 4:
                    testid = 'too-many-blocks'
                    testmessage = 'Too many annotation blocks within one sentence. There should be two empty lines after each sentence.'
                    warn(testmessage, testclass, testlevel, testid)
                    corrupt = True
            else: # two consecutive empty lines = end of sentence
                if blocks:
                    if len(blocks) < 4:
                        testid = 'too-few-blocks'
                        testmessage = 'Too few annotation blocks in the sentence. Expected introduction, sentence level graph, alignment, and document level annotation.'
                        warn(testmessage, testclass, testlevel, testid)
                        corrupt = True
                    if not corrupt:
                        yield blocks
                    blocks = []
                    bline0 = None
                    comments = []
                    lines = []
                    corrupt = False
                else:
                    testid = 'extra-empty-line'
                    testmessage = 'Spurious empty line. One empty line is expected after every annotation block and two after every sentence.'
                    warn(testmessage, testclass, testlevel=testlevel, testid=testid)
        elif line[0] == '#':
            # We will really validate sentence ids later. But now we want to remember
            # everything that looks like a sentence id and use it in the error messages.
            # Line numbers themselves may not be sufficient if we are reading multiple
            # files from a pipe.
            match = sentid_re.match(line)
            if match:
                sentence_id = match.group(1)
            if not lines: # before sentence
                comments.append(line)
            else:
                testid = 'misplaced-comment'
                testmessage = 'Spurious comment line. Comments are only allowed before a sentence.'
                warn(testmessage, testclass, testlevel, testid)
                corrupt = True
        elif is_root(line) or is_attribute(line) or is_alignment(line):
            lines.append(line)
        else: # A line which is neither a comment nor a token/word, nor empty. That's bad!
            testid = 'invalid-line'
            testmessage = "Spurious line: '%s'. All non-empty lines should start with the '#' character, opening bracket, colon, or node variable id. Leading whitespace is permitted." % (line)
            warn(testmessage, testclass, testlevel, testid)
            corrupt = True
    else: # end of file
        if blocks: # These should have been yielded on an empty line!
            testid = 'missing-empty-line'
            testmessage = 'Missing empty line after the last sentence.'
            warn(testmessage, testclass, testlevel, testid)
            if not corrupt:
                yield blocks

#------------------------------------------------------------------------------
# Low-level tests: character encoding, line break format etc.
#------------------------------------------------------------------------------

def validate_unicode_normalization(text):
    """
    Tests that letters composed of multiple Unicode characters (such as a base
    letter plus combining diacritics) conform to NFC normalization (canonical
    decomposition followed by canonical composition).
    """
    normalized_text = unicodedata.normalize('NFC', text)
    if text != normalized_text:
        # Find the first unmatched character and include it in the report.
        firsti = -1
        firstj = -1
        inpfirst = ''
        nfcfirst = ''
        tcols = text.split("\t")
        ncols = normalized_text.split("\t")
        for i in range(len(tcols)):
            for j in range(len(tcols[i])):
                if tcols[i][j] != ncols[i][j]:
                    firsti = i
                    firstj = j
                    inpfirst = unicodedata.name(tcols[i][j])
                    nfcfirst = unicodedata.name(ncols[i][j])
                    break
            if firsti >= 0:
                break
        testlevel = 1
        testclass = 'Unicode'
        testid = 'unicode-normalization'
        testmessage = "Unicode not normalized: %s.character[%d] is %s, should be %s." % (COLNAMES[firsti], firstj, inpfirst, nfcfirst)
        warn(testmessage, testclass, testlevel, testid)

def validate_newlines(inp):
    """
    To be called after the input has been read. If the input uses '\r\n' as
    line breaks, inp.newlines will have been set to '\r\n'. For Unix-style
    line breaks, it should be empty. (Not sure what happens if the file is
    inconsistent and line breaks are mixed.)
    """
    if inp.newlines and inp.newlines != '\n':
        testlevel = 1
        testclass = 'Format'
        testid = 'non-unix-newline'
        testmessage = 'Only the unix-style LF line terminator is allowed.'
        warn(testmessage, testclass, testlevel, testid)



#==============================================================================
# Level 2 tests. ###!!! HOW DO WE DEFINE THEM?
#==============================================================================

###### Metadata tests #########

def validate_sentence_metadata(sentence, known_ids):
    testlevel = 2
    testclass = 'Metadata'
    matched=[]
    # The sentence should contain 4 annotation blocks. The first block should
    # contain the comment line with the sentence id and the space-separated
    # tokens. Thanks to previous tests, we can be sure that there is at least
    # one annotation block. However, we cannot be sure that it has comments.
    if not 'comments' in sentence[0]:
        testid = 'missing-sent-id'
        testmessage = 'Missing sentence id.'
        warn(testmessage, testclass, testlevel, testid, lineno=-1)
        return
    comments = sentence[0]['comments']
    cline = 0
    for c in comments:
        match = sentid_tokens_re.match(c)
        if match:
            matched.append(match)
        else:
            match = sentid_re.match(c)
            if match:
                testid = 'invalid-sent-id'
                testmessage = "Spurious sentence metadata line: '%s' Should look like '# :: sntN token token ...' where N is the sentence number; the id is followed by token sequence." % c
                warn(testmessage, testclass, testlevel, testid, lineno=sentence[0]['line0']+cline)
        cline += 1
    if not matched:
        testid = 'missing-sent-id'
        testmessage = 'Missing sentence id.'
        warn(testmessage, testclass, testlevel, testid, lineno=-1)
    elif len(matched)>1:
        testid = 'multiple-sent-id'
        testmessage = 'Multiple sentence ids.'
        warn(testmessage, testclass, testlevel, testid, lineno=-1)
    else:
        # Uniqueness of sentence ids should be tested treebank-wide, not just file-wide.
        # For that to happen, all three files should be tested at once.
        sid = matched[0].group(1)
        if sid in known_ids:
            testid = 'non-unique-sent-id'
            testmessage = "Non-unique sentence id '%s'." % sid
            warn(testmessage, testclass, testlevel, testid, lineno=-1)
        known_ids.add(sid)
        # Save the tokens so we can access them later.
        tokens = matched[0].group(2).split(' ')
        empty_tokens = [x for x in tokens if x == '' or ws_re.match(x)]
        if empty_tokens:
            testid = 'empty-token'
            testmessage = "Empty token (i.e., two consecutive whitespace characters) in '%s'" % matched[0].group(2)
            warn(testmessage, testclass, testlevel, testid, lineno=-1)
        sentence[0]['tokens'] = tokens

variable_re = re.compile(r"^s[0-9]+[a-z]+[0-9]*")
concept_re = re.compile(r"^\S+")
relation_re = re.compile(r"^:[-A-Za-z0-9]+")
string_re = re.compile(r'^"[^"\s]+"')
number_re = re.compile(r"^([0-9]+(?:\.[0-9]+)?)(\s|\)|$)") # we need to recognize following closing bracket but we must not consume it
atom_re = re.compile(r"^([-+a-z0-9]+)(\s|\)|$)") # enumerated values of some attributes, including integers (but also '3rd'), polarity values ('+', '-'), or node references ('s5p')

def validate_sentence_graph(sentence, node_dict):
    testlevel = 2
    testclass = 'Sentence'
    # Does the comment confirm that we are processing the sentence level graph?
    heading_found = False
    if 'comments' in sentence[1]:
        for c in sentence[1]['comments']:
            if c == '# sentence level graph:':
                heading_found = True
                break
    if not heading_found:
        testid = 'missing-heading-sentence-level'
        testmessage = "Missing heading comment '# sentence level graph:'."
        warn(testmessage, testclass, testlevel, testid, lineno=sentence[1]['line0'])
    # Besides the global node dictionary, we also need a temporary one for the
    # current sentence because node references in the sentence level graph
    # cannot lead to other sentences.
    sentence[1]['nodes'] = set()
    node_references = []
    stack = []
    # expecting_node_definition means we either just read ':something', which is
    # a relation or an attribute, and we did not see a value (atom / number /
    # string / node reference), or it is the beginning of the sentence. In both
    # cases we are expecting a full node definition.
    expecting_node_definition = True
    iline = sentence[1]['line0'] + len(sentence[1]['comments']) - 1
    for l in sentence[1]['lines']:
        iline += 1
        pline = l # processed line: we will remove stuff from pline but not from l
        while pline:
            # Remove leading whitespace.
            pline = remove_leading_whitespace(pline)
            if pline.startswith('('):
                if not expecting_node_definition:
                    testid = 'extra-opening-bracket'
                    testmessage = "Not expecting full node definition (opening bracket), found '%s'." % pline
                    warn(testmessage, testclass, testlevel, testid, lineno=iline)
                pline = remove_leading_whitespace(pline[1:])
                # Now expecting variable identifier, e.g., 's15p'.
                if variable_re.match(pline):
                    match = variable_re.match(pline)
                    variable = match.group(0)
                    pline = remove_leading_whitespace(variable_re.sub('', pline, 1))
                    # The variable serves as node id. It must be unique.
                    if variable in node_dict:
                        testid = 'non-unique-node-id'
                        testmessage = "The node id (variable) '%s' is not unique. It was previously used on line %d." % (variable, node_dict[variable]['line0'])
                        warn(testmessage, testclass, testlevel, testid, lineno=iline)
                    else:
                        node_dict[variable] = {'line0': iline}
                        sentence[1]['nodes'].add(variable)
                    # Now expecting the slash ('/').
                    if pline.startswith('/'):
                        pline = remove_leading_whitespace(pline[1:])
                        # Now expecting the concept string, e.g., 'have-quant-91'.
                        if concept_re.match(pline):
                            # OK, we have read the beginning of a node, including its variable and concept.
                            # Now store it somewhere. ###!!! Not only to the stack!
                            stack.append(variable)
                            pline = remove_leading_whitespace(concept_re.sub('', pline, 1))
                            pass
                        else:
                            testid = 'missing-concept-string'
                            testmessage = "Expected concept string, found '%s'." % pline
                            warn(testmessage, testclass, testlevel, testid, lineno=iline)
                    else:
                        testid = 'missing-slash'
                        testmessage = "Expected slash and concept string, found '%s'." % pline
                        warn(testmessage, testclass, testlevel, testid, lineno=iline)
                else:
                    testid = 'missing-variable'
                    testmessage = "Expected node variable id, found '%s'." % pline
                    warn(testmessage, testclass, testlevel, testid, lineno=iline)
                expecting_node_definition = False
            elif relation_re.match(pline):
                if expecting_node_definition:
                    testid = 'missing-node-definition'
                    testmessage = "Expecting full node definition (opening bracket), found '%s'." % pline
                    warn(testmessage, testclass, testlevel, testid, lineno=iline)
                pline = remove_leading_whitespace(relation_re.sub('', pline, 1))
                # Besides a child node, there may be a numeric or string value.
                expecting_node_definition = False
                if string_re.match(pline):
                    pline = remove_leading_whitespace(string_re.sub('', pline, 1))
                elif variable_re.match(pline):
                    match = variable_re.match(pline)
                    variable = match.group(0)
                    node_references.append({'variable': variable, 'line0': iline})
                    if args.check_forward_references and not variable in sentence[1]['nodes']:
                        if variable in node_dict:
                            testid = 'cross-sentence-reference'
                            testmessage = "Sentence level graph cannot contain nodes from other sentences: '%s' was defined on line %d." % (variable, node_dict[variable]['line0'])
                            warn(testmessage, testclass, testlevel, testid, lineno=iline)
                        else:
                            testid = 'unknown-node-id'
                            testmessage = "The node id (variable) '%s' is unknown. No such node has been defined so far." % variable
                            warn(testmessage, testclass, testlevel, testid, lineno=iline)
                    pline = remove_leading_whitespace(variable_re.sub('', pline, 1))
                elif atom_re.match(pline):
                    match = atom_re.match(pline)
                    atom = match.group(1)
                    pline = remove_leading_whitespace(match.group(2)+atom_re.sub('', pline, 1))
                # Integer numbers would be consumed as atoms. This is here because of decimal numbers.
                elif number_re.match(pline):
                    match = number_re.match(pline)
                    number = match.group(1)
                    pline = remove_leading_whitespace(match.group(2)+number_re.sub('', pline, 1))
                else:
                    expecting_node_definition = True
            elif pline.startswith(')'):
                if expecting_node_definition:
                    testid = 'missing-node-definition'
                    testmessage = "Expecting full node definition (opening bracket), found '%s'." % pline
                    warn(testmessage, testclass, testlevel, testid, lineno=iline)
                # Check for the matching opening bracket and remove it from the stack.
                if not stack:
                    testid = 'extra-closing-bracket'
                    testmessage = "Found closing bracket but there was no matching opening bracket: '%s'." % pline
                    warn(testmessage, testclass, testlevel, testid, lineno=iline)
                else:
                    stack.pop()
                pline = remove_leading_whitespace(pline[1:])
                expecting_node_definition = False
            else:
                if expecting_node_definition:
                    testid = 'missing-node-definition'
                    testmessage = "Expecting full node definition (opening bracket), found '%s'." % pline
                    warn(testmessage, testclass, testlevel, testid, lineno=iline)
                else:
                    testid = 'invalid-sentence-level'
                    testmessage = "Expecting colon or closing bracket, found '%s'." % pline
                    warn(testmessage, testclass, testlevel, testid, lineno=iline)
                pline = ''
    # If checking forward references is on, we know that all node references
    # either lead to defined nodes or have been reported as errors. But if it is
    # off, we must check for undefined nodes now.
    if not args.check_forward_references:
        for r in node_references:
            # If the node exists elsewhere in the
            if not r['variable'] in sentence[1]['nodes']:
                if r['variable'] in node_dict:
                    testid = 'cross-sentence-reference'
                    testmessage = "Sentence level graph cannot contain nodes from other sentences: '%s' was defined on line %d." % (r['variable'], node_dict[r['variable']]['line0'])
                    warn(testmessage, testclass, testlevel, testid, lineno=r['line0'])
                else:
                    testid = 'unknown-node-id'
                    testmessage = "The node id (variable) '%s' is unknown. No such node is defined in this sentence." % r['variable']
                    warn(testmessage, testclass, testlevel, testid, lineno=r['line0'])

tokrng_re = re.compile(r"^0-0|([1-9][0-9]*)-([1-9][0-9]*)$")

def validate_alignment(sentence, node_dict):
    testlevel = 2
    testclass = 'Alignment'
    # Does the comment confirm that we are processing the concept-token alignment?
    heading_found = False
    if 'comments' in sentence[2]:
        for c in sentence[2]['comments']:
            if c == '# alignment:':
                heading_found = True
                break
    if not heading_found:
        testid = 'missing-heading-alignment'
        testmessage = "Missing heading comment '# alignment:'."
        warn(testmessage, testclass, testlevel, testid, lineno=sentence[2]['line0'])
    iline = sentence[2]['line0'] + len(sentence[2]['comments']) - 1
    for l in sentence[2]['lines']:
        iline += 1
        pline = l # processed line: we will remove stuff from pline but not from l
        if variable_re.match(pline):
            match = variable_re.match(pline)
            variable = match.group(0)
            if not variable in sentence[1]['nodes']:
                testid = 'unknown-node-id'
                testmessage = "The node id (variable) '%s' is unknown. No such node is defined in this sentence." % variable
                warn(testmessage, testclass, testlevel, testid, lineno=iline)
            pline = remove_leading_whitespace(variable_re.sub('', pline, 1))
            if pline.startswith(':'):
                pline = remove_leading_whitespace(pline[1:])
                if tokrng_re.match(pline):
                    match = tokrng_re.match(pline)
                    if match.group(0) == '0-0':
                        t0 = 0
                        t1 = 0
                    else:
                        t0 = int(match.group(1))
                        t1 = int(match.group(2))
                        if t1 < t0:
                            testid = 'invalid-token-range'
                            testmessage = "Index of the first token '%d' is greater than the index of the second token '%d'." % (t0, t1)
                            warn(testmessage, testclass, testlevel, testid, lineno=iline)
                        tmax = len(sentence[0]['tokens'])
                        if t0 > tmax:
                            testid = 'invalid-token-index'
                            testmessage = "Index of the first token '%d' is out of range: there are %d tokens." % (t0, tmax)
                            warn(testmessage, testclass, testlevel, testid, lineno=iline)
                        if t1 > tmax:
                            testid = 'invalid-token-index'
                            testmessage = "Index of the second token '%d' is out of range: there are %d tokens." % (t1, tmax)
                            warn(testmessage, testclass, testlevel, testid, lineno=iline)
                    # The variable should be in node_dict. If it is not there,
                    # it has been already reported as error; but we must survive it here.
                    if variable in node_dict:
                        if 'alignment' in node_dict[variable]:
                            testid = 'duplicate-alignment'
                            testmessage = "Repeated alignment of node '%s'. It was already specified as %d-%d on line %d." % (variable, node_dict[variable]['alignment']['t0'], node_dict[variable]['alignment']['t1'], node_dict[variable]['alignment']['line0'])
                            warn(testmessage, testclass, testlevel, testid, lineno=iline)
                        else:
                            node_dict[variable]['alignment'] = {'t0': t0, 't1': t1, 'line0': iline}
                else:
                    testid = 'invalid-token-range'
                    testmessage = "Expecting 1-based token index range or '0-0', found '%s'." % pline
                    warn(testmessage, testclass, testlevel, testid, lineno=iline)
            else:
                testid = 'invalid-alignment'
                testmessage = "Expecting colon, found '%s'." % pline
                warn(testmessage, testclass, testlevel, testid, lineno=iline)
        else:
            testid = 'missing-variable'
            testmessage = "Expected node variable id, found '%s'." % pline
            warn(testmessage, testclass, testlevel, testid, lineno=iline)
    # Check that all nodes in this sentence have an alignment.
    # Even unaligned nodes should have alignment 0-0.
    for n in sentence[1]['nodes']:
        if not 'alignment' in node_dict[n]:
            testid = 'missing-alignment'
            testmessage = "Missing alignment of node '%s'. Even unaligned nodes should be explicitly marked with '0-0'." % n
            warn(testmessage, testclass, testlevel, testid, lineno=iline+1) # iline is now at the end of the alignment block

svariable_re = re.compile(r"^s[0-9]+s0")
dvariable_re = re.compile(r"^([a-z]+(?:-[a-z]+)*|s[0-9]+[a-z]+[0-9]*)(\s|\)|$)") # constant or concept node id; we need to recognize following closing bracket but we must not consume it
constant_re = re.compile(r"^[a-z]+(?:-[a-z]+)*") ###!!! document-creation-time|author|root|null-conceiver; valid constants should be tested on level 3

def validate_document_level(sentence, node_dict):
    testlevel = 2
    testclass = 'Document'
    # Does the comment confirm that we are processing the document level annotation?
    heading_found = False
    if 'comments' in sentence[3]:
        for c in sentence[3]['comments']:
            if c == '# document level annotation:':
                heading_found = True
                break
    if not heading_found:
        testid = 'missing-heading-alignment'
        testmessage = "Missing heading comment '# document level annotation:'."
        warn(testmessage, testclass, testlevel, testid, lineno=sentence[3]['line0'])
    expecting = 'initial opening bracket'
    iline = sentence[3]['line0'] + len(sentence[3]['comments']) - 1
    for l in sentence[3]['lines']:
        iline += 1
        pline = l # processed line: we will remove stuff from pline but not from l
        while pline:
            # Remove leading whitespace.
            pline = remove_leading_whitespace(pline)
            if pline.startswith('('):
                if expecting == 'initial opening bracket':
                    expecting = 'sentence variable id'
                elif expecting == 'group opening bracket':
                    expecting = 'relation opening bracket'
                elif expecting == 'relation opening bracket' or expecting == 'relation opening bracket or group closing bracket':
                    expecting = 'the first node of a relation'
                else:
                    testid = 'invalid-document-level'
                    testmessage = "Expecting %s, found '%s'." % (expecting, pline)
                    warn(testmessage, testclass, testlevel, testid, lineno=iline)
                pline = remove_leading_whitespace(pline[1:])
            elif svariable_re.match(pline):
                match = svariable_re.match(pline)
                variable = match.group(0)
                if expecting != 'sentence variable id':
                    testid = 'invalid-document-level'
                    testmessage = "Expecting %s, found '%s'." % (expecting, pline)
                    warn(testmessage, testclass, testlevel, testid, lineno=iline)
                    pline = ''
                    break
                pline = remove_leading_whitespace(svariable_re.sub('', pline, 1))
                # The variable serves as node id. It must be unique.
                if variable in node_dict:
                    testid = 'non-unique-node-id'
                    testmessage = "The node id (variable) '%s' is not unique. It was previously used on line %d." % (variable, node_dict[variable]['line0'])
                    warn(testmessage, testclass, testlevel, testid, lineno=iline)
                else:
                    node_dict[variable] = {'line0': iline}
                # Now expecting the slash ('/') and the concept 'sentence'.
                if pline.startswith('/ sentence'):
                    pline = remove_leading_whitespace(pline[10:])
                else:
                    testid = 'missing-sentence-concept'
                    testmessage = "Expected '/ sentence', found '%s'." % pline
                    warn(testmessage, testclass, testlevel, testid, lineno=iline)
                expecting = 'relation group or final closing bracket'
            elif dvariable_re.match(pline):
                match = dvariable_re.match(pline)
                variable = match.group(1)
                if expecting == 'the first node of a relation':
                    expecting = 'relation'
                elif expecting == 'the second node of the relation':
                    expecting = 'relation closing bracket'
                else:
                    testid = 'invalid-document-level'
                    testmessage = "Expecting %s, found '%s'." % (expecting, pline)
                    warn(testmessage, testclass, testlevel, testid, lineno=iline)
                    pline = ''
                    break
                pline = remove_leading_whitespace(match.group(2) + dvariable_re.sub('', pline, 1))
                # The variable must be either a known node from this or previous sentences, or it must be a constant (such as 'document-creation-time').
                if not variable in node_dict and not constant_re.match(variable):
                    testid = 'unknown-node-id'
                    testmessage = "The node id (variable) '%s' is unknown. No such node has been defined so far." % variable
                    warn(testmessage, testclass, testlevel, testid, lineno=iline)
            elif relation_re.match(pline):
                if expecting == 'relation group' or expecting == 'relation group or final closing bracket':
                    expecting = 'group opening bracket'
                elif expecting == 'relation':
                    expecting = 'the second node of the relation'
                else:
                    testid = 'invalid-document-level'
                    testmessage = "Expecting %s, found '%s'." % (expecting, pline)
                    warn(testmessage, testclass, testlevel, testid, lineno=iline)
                match = relation_re.match(pline)
                relation = match.group(0)
                pline = remove_leading_whitespace(relation_re.sub('', pline, 1))
            elif pline.startswith(')'):
                if expecting == 'relation closing bracket':
                    expecting = 'relation opening bracket or group closing bracket'
                elif expecting == 'relation opening bracket or group closing bracket':
                    expecting = 'relation group or final closing bracket'
                elif expecting == 'relation group or final closing bracket':
                    expecting = 'end of document level annotation'
                else:
                    testid = 'invalid-document-level'
                    testmessage = "Expecting %s, found '%s'." % (expecting, pline)
                    warn(testmessage, testclass, testlevel, testid, lineno=iline)
                pline = remove_leading_whitespace(pline[1:])
            else:
                testid = 'invalid-document-level'
                testmessage = "Not expecting this: '%s'." % pline
                warn(testmessage, testclass, testlevel, testid, lineno=iline)
                pline = ''



#==============================================================================
# Main part.
#==============================================================================

def validate(inp, out, args, known_sent_ids):
    global sentence_line, sentence_id
    # Dictionary of all concept nodes in the document.
    node_dict = {}
    for sentence in sentences(inp, args):
        # If fundamental errors were found already in sentences(), the function
        # will skip the current sentence and go to the next one. So if we are
        # here, we have a sentence with the expected set of annotation blocks
        # and with lines that at least superficially look acceptable.
        if args.level > 1:
            validate_sentence_metadata(sentence, known_sent_ids) # level 2?
            validate_sentence_graph(sentence, node_dict)
            validate_alignment(sentence, node_dict)
            validate_document_level(sentence, node_dict)
        # Before we read the next sentence, clear the current sentence variables
        # so that sentences() knows they should be reset to new values.
        sentence_line = None
        sentence_id = None
    # After we have read the input, we can ask about the line breaks observed.
    validate_newlines(inp) # level 1

if __name__=="__main__":
    opt_parser = argparse.ArgumentParser(description="UMR validation script. Python 3 is needed to run it!")

    io_group = opt_parser.add_argument_group('Input / output options')
    io_group.add_argument('--quiet', dest="quiet", action="store_true", default=False, help='Do not print any error messages. Exit with 0 on pass, non-zero on fail.')
    io_group.add_argument('--max-err', action="store", type=int, default=20, help='How many errors to output before exiting? 0 for all. Default: %(default)d.')
    io_group.add_argument('input', nargs='*', help='Input file name(s), or "-" or nothing for standard input.')

    list_group = opt_parser.add_argument_group('Label sets', 'Options relevant to checking label sets.')
    list_group.add_argument('--lang', action="store", default=None, help="Which langauge are we checking? If you specify this (as a two-letter code), the validator will use language-specific guidelines.")
    list_group.add_argument('--level', action="store", type=int, default=5, dest="level", help="Level 1: Test only the technical format backbone. Level 2: UMR format. Level 3: UMR contents. Level 4: Language-specific labels. Level 5: Language-specific contents.")

    meta_group = opt_parser.add_argument_group('Strictness', 'Options for relaxing selected tests.')
    meta_group.add_argument('--allow-trailing-whitespace', dest='check_trailing_whitespace', action='store_false', default=True, help='Do not report trailing whitespace.')
    meta_group.add_argument('--allow-forward-references', dest='check_forward_references', action='store_false', default=True, help='Do not report forward node references within a sentence level graph.')

    args = opt_parser.parse_args() # Parsed command-line arguments
    error_counter={} # Incremented by warn()  {key: error type value: its count}

    # Level of validation
    if args.level < 1:
        print('Option --level must not be less than 1; changing from %d to 1' % args.level, file=sys.stderr)
        args.level = 1

    out = sys.stdout # Does this ever need to be anything else?

    try:
        known_sent_ids = set()
        open_files = []
        if args.input == []:
            args.input.append('-')
        for fname in args.input:
            if fname == '-':
                # Set PYTHONIOENCODING=utf-8 before starting Python. See https://docs.python.org/3/using/cmdline.html#envvar-PYTHONIOENCODING
                # Otherwise ANSI will be read in Windows and locale-dependent encoding will be used elsewhere.
                open_files.append(sys.stdin)
            else:
                open_files.append(io.open(fname, 'r', encoding='utf-8'))
        for curr_fname, inp in zip(args.input, open_files):
            validate(inp, out, args, known_sent_ids)
    except:
        warn('Exception caught!', 'Internal', 0, 'internal-error')
        # If the output is used in an HTML page, it must be properly escaped
        # because the traceback can contain e.g. "<module>". However, escaping
        # is beyond the goal of validation, which can be also run in a console.
        traceback.print_exc()
    # Summarize the warnings and errors.
    passed = True
    nerror = 0
    if error_counter:
        for k, v in sorted(error_counter.items()):
            if k == 'Warning':
                errors = 'Warnings'
            else:
                errors = k+' errors'
                nerror += v
                passed = False
            if not args.quiet:
                print('%s: %d' % (errors, v), file=sys.stderr)
    # Print the final verdict and exit.
    if passed:
        if not args.quiet:
            print('*** PASSED ***', file=sys.stderr)
        sys.exit(0)
    else:
        if not args.quiet:
            print('*** FAILED *** with %d errors' % nerror, file=sys.stderr)
        for f_name in sorted(warn_on_missing_files):
            filepath = os.path.join(THISDIR, 'data', f_name+'.'+args.lang)
            if not os.path.exists(filepath):
                print('The language-specific file %s does not exist.' % filepath, file=sys.stderr)
        sys.exit(1)
