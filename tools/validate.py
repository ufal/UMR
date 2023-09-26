#! /usr/bin/env python3
# Copyright (c) 2023 Dan Zeman <zeman@ufal.mff.cuni.cz>
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

###### Support functions
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

sentid_re=re.compile('^# :: (snt[0-9]+)\s')
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
                comments = []
                lines = []
                line0 = None
                ###!!! Sentences typically have 4 annotation blocks: 1. intro; 2. sentence level; 3. alignment; 4. document level.
                ###!!! If we see more blocks, maybe someone forgot to add a second empty line between sentences.
                if len(blocks) > 4:
                    testid = 'too-many-blocks'
                    testmessage = 'Too many annotation blocks within one sentence. There should be two empty lines after each sentence.'
                    warn(testmessage, testclass, testlevel, testid)
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
        elif is_root(line) or is_attribute(line) or is_alignment(line):
            lines.append(line)
        else: # A line which is neither a comment nor a token/word, nor empty. That's bad!
            testid = 'invalid-line'
            testmessage = "Spurious line: '%s'. All non-empty lines should start with a digit or the # character." % (line)
            warn(testmessage, testclass, testlevel, testid)
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
# Level 2 tests. Tree structure, universal tags and deprels. Note that any
# well-formed Feature=Valid pair is allowed (because it could be language-
# specific) and any word form or lemma can contain spaces (because language-
# specific guidelines may permit it).
#==============================================================================

###### Metadata tests #########

def validate_sent_id(sentence, known_ids, lcode):
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
        match=sentid_re.match(c)
        if match:
            matched.append(match)
        else:
            ###!!! This is a remnant from UD validation. We have yet to see if there are repeated error patterns around sentence id syntax.
            if c.startswith('# sent_id') or c.startswith('#sent_id'):
                testid = 'invalid-sent-id'
                testmessage = "Spurious sent_id line: '%s' Should look like '# sent_id = xxxxx' where xxxxx is not whitespace. Forward slash reserved for special purposes." % c
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

text_re = re.compile('^#\s*text\s*=\s*(.+)$')
def validate_text_meta(comments, tree):
    # Remember if SpaceAfter=No applies to the last word of the sentence.
    # This is not prohibited in general but it is prohibited at the end of a paragraph or document.
    global spaceafterno_in_effect
    testlevel = 2
    testclass = 'Metadata'
    text_matched = []
    if not text_matched:
        testid = 'missing-text'
        testmessage = 'Missing the text attribute.'
        warn(testmessage, testclass, testlevel, testid)
    elif len(text_matched) > 1:
        testid = 'multiple-text'
        testmessage = 'Multiple text attributes.'
        warn(testmessage, testclass, testlevel, testid)
    else:
        stext = text_matched[0].group(1)
        # Validate the text against the SpaceAfter attribute in MISC.
        skip_words = set()
        mismatch_reported = 0 # do not report multiple mismatches in the same sentence; they usually have the same cause

##### Tests applicable to the whole sentence

def build_tree(sentence):
    """
    Takes the list of non-comment lines (line = list of columns) describing
    a sentence. Returns a dictionary with items providing easier access to the
    tree structure. In case of fatal problems (missing HEAD etc.) returns None
    but does not report the error (presumably it has already been reported).

    tree ... dictionary:
      nodes ... array of word lines, i.e., lists of columns;
          mwt and empty nodes are skipped, indices equal to ids (nodes[0] is empty)
      children ... array of sets of children indices (numbers, not strings);
          indices to this array equal to ids (children[0] are the children of the root)
      linenos ... array of line numbers in the file, corresponding to nodes
          (needed in error messages)
    """
    testlevel = 2
    testclass = 'Syntax'
    global sentence_line # the line of the first line of the current sentence
    node_line = sentence_line - 1
    children = {} # node -> set of children
    tree = {
        'nodes':    [['0', '_', '_', '_', '_', '_', '_', '_', '_', '_']], # add artificial node 0
        'children': [],
        'linenos':  [sentence_line] # for node 0
    }
    for cols in sentence:
        node_line += 1
        if not is_word(cols):
            continue
        # Even MISC may be needed when checking the annotation guidelines
        # (for instance, SpaceAfter=No must not occur inside a goeswith span).
        if MISC >= len(cols):
            # This error has been reported on lower levels, do not report it here.
            # Do not continue to check annotation if there are elementary flaws.
            return None
        try:
            id_ = int(cols[ID])
        except ValueError:
            # This error has been reported on lower levels, do not report it here.
            # Do not continue to check annotation if there are elementary flaws.
            return None
        try:
            head = int(cols[HEAD])
        except ValueError:
            # This error has been reported on lower levels, do not report it here.
            # Do not continue to check annotation if there are elementary flaws.
            return None
        if head == id_:
            testid = 'head-self-loop'
            testmessage = 'HEAD == ID for %s' % cols[ID]
            warn(testmessage, testclass, testlevel, testid, lineno=node_line)
            return None
        tree['nodes'].append(cols)
        tree['linenos'].append(node_line)
        # Incrementally build the set of children of every node.
        children.setdefault(cols[HEAD], set()).add(id_)
    for cols in tree['nodes']:
        tree['children'].append(sorted(children.get(cols[ID], [])))
    # Check that there is just one node with the root relation.
    if len(tree['children'][0]) > 1 and args.single_root:
        testid = 'multiple-roots'
        testmessage = "Multiple root words: %s" % tree['children'][0]
        warn(testmessage, testclass, testlevel, testid, lineno=-1)
        return None
    # Return None if there are any cycles. Avoid surprises when working with the graph.
    # Presence of cycles is equivalent to presence of unreachable nodes.
    projection = set()
    get_projection(0, tree, projection)
    unreachable = set(range(1, len(tree['nodes']) - 1)) - projection
    if unreachable:
        testid = 'non-tree'
        testmessage = 'Non-tree structure. Words %s are not reachable from the root 0.' % (','.join(str(w) for w in sorted(unreachable)))
        warn(testmessage, testclass, testlevel, testid, lineno=-1)
        return None
    return tree



#==============================================================================
# Main part.
#==============================================================================

def validate(inp, out, args, known_sent_ids):
    global sentence_line, sentence_id
    for sentence in sentences(inp, args):
        if args.level > 1:
            validate_sent_id(sentence, known_sent_ids, args.lang) # level 2
            ###!!! if args.check_tree_text:
                ###!!! validate_text_meta(comments, sentence) # level 2
            # Avoid building tree structure if the sequence of node ids is corrupted.
            ###!!! tree = build_tree(sentence) # level 2 test: tree is single-rooted, connected, cycle-free
            tree = None ###!!!
            if tree:
                if args.level > 2:
                    validate_annotation(tree) # level 3
            else:
                testlevel = 2
                testclass = 'Format'
                testid = 'skipped-corrupt-tree'
                testmessage = "Skipping annotation tests because of corrupt tree structure."
                ###!!! warn(testmessage, testclass, testlevel=testlevel, testid=testid, lineno=False)
        # Before we read the next sentence, clear the current sentence variables
        # so that sentences() knows they should be reset to new values.
        sentence_line = None
        sentence_id = None
    # After we have read the input, we can ask about the line breaks observed.
    validate_newlines(inp) # level 1

if __name__=="__main__":
    opt_parser = argparse.ArgumentParser(description="UMR validation script. Python 3 is needed to run it!")

    io_group = opt_parser.add_argument_group("Input / output options")
    io_group.add_argument('--quiet', dest="quiet", action="store_true", default=False, help='Do not print any error messages. Exit with 0 on pass, non-zero on fail.')
    io_group.add_argument('--max-err', action="store", type=int, default=20, help='How many errors to output before exiting? 0 for all. Default: %(default)d.')
    io_group.add_argument('input', nargs='*', help='Input file name(s), or "-" or nothing for standard input.')

    list_group = opt_parser.add_argument_group("Label sets", "Options relevant to checking label sets.")
    list_group.add_argument('--lang', action="store", required=True, default=None, help="Which langauge are we checking? If you specify this (as a two-letter code), the validator will use language-specific guidelines.")
    list_group.add_argument('--level', action="store", type=int, default=5, dest="level", help="Level 1: Test only the technical format backbone. Level 2: UMR format. Level 3: UMR contents. Level 4: Language-specific labels. Level 5: Language-specific contents.")

    meta_group = opt_parser.add_argument_group("Metadata constraints", "Options for checking the validity of tree metadata.")
    meta_group.add_argument('--no-tree-text', action="store_false", default=True, dest="check_tree_text", help="Do not test tree text. For internal use only, this test is required and on by default.")
    meta_group.add_argument('--allow-trailing-whitespace', action='store_false', default=True, dest='check_trailing_whitespace', help='Do not report trailing whitespace.')

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
        warn('Exception caught!', 'Format')
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
