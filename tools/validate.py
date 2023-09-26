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
curr_line = 0 # Current line in the input file
comment_start_line = 0 # The line in the input file on which the current sentence starts, including sentence-level comments.
sentence_line = 0 # The line in the input file on which the current sentence starts (the first node/token line, skipping comments)
sentence_id = None # The most recently read sentence id
line_of_first_morpho_feature = None # features are optional, but if the treebank has features, then some become required
delayed_feature_errors = {}
line_of_first_enhanced_graph = None
line_of_first_tree_without_enhanced_graph = None
line_of_first_enhancement = None # any difference between non-empty DEPS and HEAD:DEPREL
line_of_first_empty_node = None
line_of_first_enhanced_orphan = None
line_of_global_entity = None
global_entity_attribute_string = None # to be able to check that repeated declarations are identical
entity_attribute_number = 0 # to be able to check that an entity does not have extra attributes
entity_attribute_index = {} # key: entity attribute name; value: the index of the attribute in the entity attribute list
entity_types = {} # key: entity (cluster) id; value: tuple: (type of the entity, identity (Wikipedia etc.), line of the first mention)
open_entity_mentions = [] # items are dictionaries with entity mention information
open_discontinuous_mentions = {} # key: entity id; describes last part of a discontinuous mention of that entity; item is dict, its keys: last_ipart, npart, line
error_counter = {} # key: error type value: error count
warn_on_missing_files = set() # langspec files which you should warn about in case they are missing (can be deprel, edeprel, feat_val, tokens_w_space)
warn_on_undoc_feats = '' # filled after reading docfeats.json; printed when an unknown feature is encountered in the data
warn_on_undoc_deps = '' # filled after reading docdeps.json; printed when an unknown relation is encountered in the data
warn_on_undoc_edeps = '' # filled after reading edeprels.json; printed when an unknown enhanced relation is encountered in the data
mwt_typo_span_end = None # if Typo=Yes at multiword token, what is the end of the multiword span?
spaceafterno_in_effect = False # needed to check that no space after last word of sentence does not co-occur with new paragraph or document

def warn(msg, error_type, testlevel=0, testid='some-test', lineno=True, nodelineno=0, nodeid=0, explanation=None):
    """
    Print the error/warning message.
    If lineno is True, print the number of the line last read from input. Note
    that once we have read a sentence, this is the number of the empty line
    after the sentence, hence we probably do not want to print it.
    If we still have an error that pertains to an individual node, and we know
    the number of the line where the node appears, we can supply it via
    nodelineno. Nonzero nodelineno means that lineno value is ignored.
    If lineno is False, print the number and starting line of the current tree.
    If explanation contains a string and this is the first time we are reporting
    an error of this type, the string will be appended to the main message. It
    can be used as an extended explanation of the situation.
    """
    global curr_fname, curr_line, sentence_line, sentence_id, error_counter, tree_counter, args
    error_counter[error_type] = error_counter.get(error_type, 0)+1
    if not args.quiet:
        if args.max_err > 0 and error_counter[error_type] == args.max_err:
            print(('...suppressing further errors regarding ' + error_type), file=sys.stderr)
        elif args.max_err > 0 and error_counter[error_type] > args.max_err:
            pass # suppressed
        else:
            if explanation and error_counter[error_type] == 1:
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
            # Originally we used a parameter sid but we probably do not need to override the global value.
            if sentence_id:
                sent = ' Sent ' + sentence_id
            if nodeid:
                node = ' Node ' + str(nodeid)
            if nodelineno:
                print("[%sLine %d%s%s]: [L%d %s %s] %s" % (fn, nodelineno, sent, node, testlevel, error_type, testid, msg), file=sys.stderr)
            elif lineno:
                print("[%sLine %d%s%s]: [L%d %s %s] %s" % (fn, curr_line, sent, node, testlevel, error_type, testid, msg), file=sys.stderr)
            else:
                print("[%sTree number %d on line %d%s%s]: [L%d %s %s] %s" % (fn, tree_counter, sentence_line, sent, node, testlevel, error_type, testid, msg), file=sys.stderr)

###### Support functions
ws_re = re.compile(r"^\s+$")
def is_whitespace(line):
    return ws_re.match(line)

word_re = re.compile(r"^[1-9][0-9]*$")
def is_word(cols):
    return word_re.match(cols[ID])

mwt_re = re.compile(r"^[1-9][0-9]*-[1-9][0-9]*$")
def is_multiword_token(cols):
    return mwt_re.match(cols[ID])

empty_node_re = re.compile(r"^[0-9]+\.[1-9][0-9]*$")
def is_empty_node(cols):
    return empty_node_re.match(cols[ID])

def parse_empty_node_id(cols):
    m = re.match(r"^([0-9]+)\.([0-9]+)$", cols[ID])
    assert m, 'parse_empty_node_id with non-empty node'
    return m.groups()

def shorten(string):
    return string if len(string) < 25 else string[:20]+'[...]'

def lspec2ud(deprel):
    return deprel.split(':', 1)[0]



#==============================================================================
# Level 1 tests. Only CoNLL-U backbone. Values can be empty or non-UD.
#==============================================================================

sentid_re=re.compile('^# sent_id\s*=\s*(\S+)$')
def trees(inp, tag_sets, args):
    """
    `inp` a file-like object yielding lines as unicode
    `tag_sets` and `args` are needed for choosing the tests

    This function does elementary checking of the input and yields one
    sentence at a time from the input stream.

    This function is a generator. The caller can call it in a 'for x in ...'
    loop. In each iteration of the caller's loop, the generator will generate
    the next sentence, that is, it will read the next sentence from the input
    stream. (Technically, the function returns an object, and the object will
    then read the sentences within the caller's loop.)
    """
    global curr_line, comment_start_line, sentence_line, sentence_id
    comments = [] # List of comment lines to go with the current sentence
    lines = [] # List of token/word lines of the current sentence
    corrupted = False # In case of wrong number of columns check the remaining lines of the sentence but do not yield the sentence for further processing.
    comment_start_line = None
    testlevel = 1
    testclass = 'Format'
    for line_counter, line in enumerate(inp):
        curr_line = line_counter+1
        if not comment_start_line:
            comment_start_line = curr_line
        line = line.rstrip(u"\n")
        if is_whitespace(line):
            testid = 'pseudo-empty-line'
            testmessage = 'Spurious line that appears empty but is not; there are whitespace characters.'
            warn(testmessage, testclass, testlevel=testlevel, testid=testid)
            # We will pretend that the line terminates a sentence in order to avoid subsequent misleading error messages.
            if lines:
                if not corrupted:
                    yield comments, lines
                comments = []
                lines = []
                corrupted = False
                comment_start_line = None
        elif not line: # empty line
            if lines: # sentence done
                if not corrupted:
                    yield comments, lines
                comments=[]
                lines=[]
                corrupted = False
                comment_start_line = None
            else:
                testid = 'extra-empty-line'
                testmessage = 'Spurious empty line. Only one empty line is expected after every sentence.'
                warn(testmessage, testclass, testlevel=testlevel, testid=testid)
        elif line[0]=='#':
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
                warn(testmessage, testclass, testlevel=testlevel, testid=testid)
        elif line[0].isdigit():
            validate_unicode_normalization(line)
            if not lines: # new sentence
                sentence_line=curr_line
            cols=line.split(u"\t")
            if len(cols)!=COLCOUNT:
                testid = 'number-of-columns'
                testmessage = 'The line has %d columns but %d are expected. The contents of the columns will not be checked.' % (len(cols), COLCOUNT)
                warn(testmessage, testclass, testlevel=testlevel, testid=testid)
                corrupted = True
            # If there is an unexpected number of columns, do not test their contents.
            # Maybe the contents belongs to a different column. And we could see
            # an exception if a column value is missing.
            else:
                lines.append(cols)
                validate_cols_level1(cols)
                if args.level > 1:
                    validate_cols(cols, tag_sets, args)
        else: # A line which is neither a comment nor a token/word, nor empty. That's bad!
            testid = 'invalid-line'
            testmessage = "Spurious line: '%s'. All non-empty lines should start with a digit or the # character." % (line)
            warn(testmessage, testclass, testlevel=testlevel, testid=testid)
    else: # end of file
        if comments or lines: # These should have been yielded on an empty line!
            testid = 'missing-empty-line'
            testmessage = 'Missing empty line after the last sentence.'
            warn(testmessage, testclass, testlevel=testlevel, testid=testid)
            if not corrupted:
                yield comments, lines

###### Tests applicable to a single row indpendently of the others

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
        warn(testmessage, testclass, testlevel=testlevel, testid=testid)

whitespace_re = re.compile('.*\s', re.U)
whitespace2_re = re.compile('.*\s\s', re.U)
def validate_cols_level1(cols):
    """
    Tests that can run on a single line and pertain only to the CoNLL-U file
    format, not to predefined sets of UD tags.
    """
    testlevel = 1
    testclass = 'Format'
    # Some whitespace may be permitted in FORM, LEMMA and MISC but not elsewhere.
    for col_idx in range(MISC+1):
        if col_idx >= len(cols):
            break # this has been already reported in trees()
        # Must never be empty
        if not cols[col_idx]:
            testid = 'empty-column'
            testmessage = 'Empty value in column %s.' % (COLNAMES[col_idx])
            warn(testmessage, testclass, testlevel=testlevel, testid=testid)
        else:
            # Must never have leading/trailing whitespace
            if cols[col_idx][0].isspace():
                testid = 'leading-whitespace'
                testmessage = 'Leading whitespace not allowed in column %s.' % (COLNAMES[col_idx])
                warn(testmessage, testclass, testlevel=testlevel, testid=testid)
            if cols[col_idx][-1].isspace():
                testid = 'trailing-whitespace'
                testmessage = 'Trailing whitespace not allowed in column %s.' % (COLNAMES[col_idx])
                warn(testmessage, testclass, testlevel=testlevel, testid=testid)
            # Must never contain two consecutive whitespace characters
            if whitespace2_re.match(cols[col_idx]):
                testid = 'repeated-whitespace'
                testmessage = 'Two or more consecutive whitespace characters not allowed in column %s.' % (COLNAMES[col_idx])
                warn(testmessage, testclass, testlevel=testlevel, testid=testid)
    # Multi-word tokens may have whitespaces in MISC but not in FORM or LEMMA.
    # If it contains a space, it does not make sense to treat it as a MWT.
    if is_multiword_token(cols):
        for col_idx in (FORM, LEMMA):
            if col_idx >= len(cols):
                break # this has been already reported in trees()
            if whitespace_re.match(cols[col_idx]):
                testid = 'invalid-whitespace-mwt'
                testmessage = "White space not allowed in multi-word token '%s'. If it contains a space, it is not one surface token." % (cols[col_idx])
                warn(testmessage, testclass, testlevel=testlevel, testid=testid)
    # These columns must not have whitespace.
    for col_idx in (ID, UPOS, XPOS, FEATS, HEAD, DEPREL, DEPS):
        if col_idx >= len(cols):
            break # this has been already reported in trees()
        if whitespace_re.match(cols[col_idx]):
            testid = 'invalid-whitespace'
            testmessage = "White space not allowed in column %s: '%s'." % (COLNAMES[col_idx], cols[col_idx])
            warn(testmessage, testclass, testlevel=testlevel, testid=testid)
    # Check for the format of the ID value. (ID must not be empty.)
    if not (is_word(cols) or is_empty_node(cols) or is_multiword_token(cols)):
        testid = 'invalid-word-id'
        testmessage = "Unexpected ID format '%s'." % cols[ID]
        warn(testmessage, testclass, testlevel=testlevel, testid=testid)

##### Tests applicable to the whole tree

def validate_newlines(inp):
    if inp.newlines and inp.newlines != '\n':
        testlevel = 1
        testclass = 'Format'
        testid = 'non-unix-newline'
        testmessage = 'Only the unix-style LF line terminator is allowed.'
        warn(testmessage, testclass, testlevel=testlevel, testid=testid)



#==============================================================================
# Level 2 tests. Tree structure, universal tags and deprels. Note that any
# well-formed Feature=Valid pair is allowed (because it could be language-
# specific) and any word form or lemma can contain spaces (because language-
# specific guidelines may permit it).
#==============================================================================

###### Metadata tests #########

def validate_sent_id(comments, known_ids, lcode):
    testlevel = 2
    testclass = 'Metadata'
    matched=[]
    for c in comments:
        match=sentid_re.match(c)
        if match:
            matched.append(match)
        else:
            if c.startswith('# sent_id') or c.startswith('#sent_id'):
                testid = 'invalid-sent-id'
                testmessage = "Spurious sent_id line: '%s' Should look like '# sent_id = xxxxx' where xxxxx is not whitespace. Forward slash reserved for special purposes." % c
                warn(testmessage, testclass, testlevel=testlevel, testid=testid)
    if not matched:
        testid = 'missing-sent-id'
        testmessage = 'Missing the sent_id attribute.'
        warn(testmessage, testclass, testlevel=testlevel, testid=testid)
    elif len(matched)>1:
        testid = 'multiple-sent-id'
        testmessage = 'Multiple sent_id attributes.'
        warn(testmessage, testclass, testlevel=testlevel, testid=testid)
    else:
        # Uniqueness of sentence ids should be tested treebank-wide, not just file-wide.
        # For that to happen, all three files should be tested at once.
        sid=matched[0].group(1)
        if sid in known_ids:
            testid = 'non-unique-sent-id'
            testmessage = "Non-unique sent_id attribute '%s'." % sid
            warn(testmessage, testclass, testlevel=testlevel, testid=testid)
        if sid.count(u"/")>1 or (sid.count(u"/")==1 and lcode!=u"ud" and lcode!=u"shopen"):
            testid = 'slash-in-sent-id'
            testmessage = "The forward slash is reserved for special use in parallel treebanks: '%s'" % sid
            warn(testmessage, testclass, testlevel=testlevel, testid=testid)
        known_ids.add(sid)

newdoc_re = re.compile('^#\s*newdoc(\s|$)')
newpar_re = re.compile('^#\s*newpar(\s|$)')
text_re = re.compile('^#\s*text\s*=\s*(.+)$')
def validate_text_meta(comments, tree):
    # Remember if SpaceAfter=No applies to the last word of the sentence.
    # This is not prohibited in general but it is prohibited at the end of a paragraph or document.
    global spaceafterno_in_effect
    # In trees(), sentence_line was already moved to the first token/node line
    # after the sentence comment lines. While this is useful in most validation
    # functions, it complicates things here where we also work with the comments.
    global sentence_line
    testlevel = 2
    testclass = 'Metadata'
    newdoc_matched = []
    newpar_matched = []
    text_matched = []
    for c in comments:
        newdoc_match = newdoc_re.match(c)
        if newdoc_match:
            newdoc_matched.append(newdoc_match)
        newpar_match = newpar_re.match(c)
        if newpar_match:
            newpar_matched.append(newpar_match)
        text_match = text_re.match(c)
        if text_match:
            text_matched.append(text_match)
    if len(newdoc_matched) > 1:
        testid = 'multiple-newdoc'
        testmessage = 'Multiple newdoc attributes.'
        warn(testmessage, testclass, testlevel=testlevel, testid=testid)
    if len(newpar_matched) > 1:
        testid = 'multiple-newpar'
        testmessage = 'Multiple newpar attributes.'
        warn(testmessage, testclass, testlevel=testlevel, testid=testid)
    if (newdoc_matched or newpar_matched) and spaceafterno_in_effect:
        testid = 'spaceafter-newdocpar'
        testmessage = 'New document or paragraph starts when the last token of the previous sentence says SpaceAfter=No.'
        warn(testmessage, testclass, testlevel=testlevel, testid=testid)
    if not text_matched:
        testid = 'missing-text'
        testmessage = 'Missing the text attribute.'
        warn(testmessage, testclass, testlevel=testlevel, testid=testid)
    elif len(text_matched) > 1:
        testid = 'multiple-text'
        testmessage = 'Multiple text attributes.'
        warn(testmessage, testclass, testlevel=testlevel, testid=testid)
    else:
        stext = text_matched[0].group(1)
        if stext[-1].isspace():
            testid = 'text-trailing-whitespace'
            testmessage = 'The text attribute must not end with whitespace.'
            warn(testmessage, testclass, testlevel=testlevel, testid=testid)
        # Validate the text against the SpaceAfter attribute in MISC.
        skip_words = set()
        mismatch_reported = 0 # do not report multiple mismatches in the same sentence; they usually have the same cause
        # We will sum sentence_line + iline, and sentence_line already points at
        # the first token/node line after the sentence comments. Hence iline shall
        # be 0 once we enter the cycle.
        iline = -1
        for cols in tree:
            iline += 1
            if MISC >= len(cols):
                # This error has been reported elsewhere but we cannot check MISC now.
                continue
            if 'NoSpaceAfter=Yes' in cols[MISC]: # I leave this without the split("|") to catch all
                testid = 'nospaceafter-yes'
                testmessage = "'NoSpaceAfter=Yes' should be replaced with 'SpaceAfter=No'."
                warn(testmessage, testclass, testlevel=testlevel, testid=testid, nodelineno=sentence_line+iline)
            if len([x for x in cols[MISC].split('|') if re.match(r'^SpaceAfter=', x) and x != 'SpaceAfter=No']) > 0:
                testid = 'spaceafter-value'
                testmessage = "Unexpected value of the 'SpaceAfter' attribute in MISC. Did you mean 'SpacesAfter'?"
                warn(testmessage, testclass, testlevel=testlevel, testid=testid, nodelineno=sentence_line+iline)
            if '.' in cols[ID]: # empty node
                if 'SpaceAfter=No' in cols[MISC]: # I leave this without the split("|") to catch all
                    testid = 'spaceafter-empty-node'
                    testmessage = "'SpaceAfter=No' cannot occur with empty nodes."
                    warn(testmessage, testclass, testlevel=testlevel, testid=testid, nodelineno=sentence_line+iline)
                continue
            elif '-' in cols[ID]: # multi-word token
                beg,end=cols[ID].split('-')
                try:
                    begi,endi = int(beg),int(end)
                except ValueError as e:
                    # This error has been reported elsewhere.
                    begi,endi = 1,0
                # If we see a multi-word token, add its words to an ignore-set - these will be skipped, and also checked for absence of SpaceAfter=No
                for i in range(begi, endi+1):
                    skip_words.add(str(i))
            elif cols[ID] in skip_words:
                if 'SpaceAfter=No' in cols[MISC]:
                    testid = 'spaceafter-mwt-node'
                    testmessage = "'SpaceAfter=No' cannot occur with words that are part of a multi-word token."
                    warn(testmessage, testclass, testlevel=testlevel, testid=testid, nodelineno=sentence_line+iline)
                continue
            else:
                # Err, I guess we have nothing to do here. :)
                pass
            # So now we have either a multi-word token or a word which is also a token in its entirety.
            if not stext.startswith(cols[FORM]):
                if not mismatch_reported:
                    testid = 'text-form-mismatch'
                    testmessage = "Mismatch between the text attribute and the FORM field. Form[%s] is '%s' but text is '%s...'" % (cols[ID], cols[FORM], stext[:len(cols[FORM])+20])
                    if len(stext) >= 1 and stext[0].isspace():
                        testmessage += " (perhaps extra SpaceAfter=No at previous token?)"
                    warn(testmessage, testclass, testlevel=testlevel, testid=testid, nodelineno=sentence_line+iline)
                    mismatch_reported = 1
            else:
                stext = stext[len(cols[FORM]):] # eat the form
                if 'SpaceAfter=No' in cols[MISC].split("|"):
                    spaceafterno_in_effect = True
                else:
                    spaceafterno_in_effect = False
                    if args.check_space_after and (stext) and not stext[0].isspace():
                        testid = 'missing-spaceafter'
                        testmessage = "'SpaceAfter=No' is missing in the MISC field of node #%s because the text is '%s'." % (cols[ID], shorten(cols[FORM]+stext))
                        warn(testmessage, testclass, testlevel=testlevel, testid=testid, nodelineno=sentence_line+iline)
                    stext = stext.lstrip()
        if stext:
            testid = 'text-extra-chars'
            testmessage = "Extra characters at the end of the text attribute, not accounted for in the FORM fields: '%s'" % stext
            warn(testmessage, testclass, testlevel=testlevel, testid=testid)

##### Tests applicable to a single row indpendently of the others

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
    global sentence_line # the line of the first token/word of the current tree (skipping comments!)
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
            warn(testmessage, testclass, testlevel=testlevel, testid=testid, nodelineno=node_line)
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
        warn(testmessage, testclass, testlevel=testlevel, testid=testid, lineno=False)
        return None
    # Return None if there are any cycles. Avoid surprises when working with the graph.
    # Presence of cycles is equivalent to presence of unreachable nodes.
    projection = set()
    get_projection(0, tree, projection)
    unreachable = set(range(1, len(tree['nodes']) - 1)) - projection
    if unreachable:
        testid = 'non-tree'
        testmessage = 'Non-tree structure. Words %s are not reachable from the root 0.' % (','.join(str(w) for w in sorted(unreachable)))
        warn(testmessage, testclass, testlevel=testlevel, testid=testid, lineno=False)
        return None
    return tree



#==============================================================================
# Main part.
#==============================================================================

def validate(inp, out, args, known_sent_ids):
    global tree_counter
    for comments, sentence in trees(inp, args):
        tree_counter += 1
        # The individual lines were validated already in trees().
        # What follows is tests that need to see the whole tree.
        idseqok = validate_ID_sequence(sentence) # level 1
        if args.level > 1:
            validate_sent_id(comments, known_sent_ids, args.lang) # level 2
            if args.check_tree_text:
                validate_text_meta(comments, sentence) # level 2
            validate_root(sentence) # level 2
            validate_ID_references(sentence) # level 2
            # Avoid building tree structure if the sequence of node ids is corrupted.
            if idseqok:
                tree = build_tree(sentence) # level 2 test: tree is single-rooted, connected, cycle-free
                egraph = build_egraph(sentence) # level 2 test: egraph is connected
            else:
                tree = None
                egraph = None
            if tree:
                if args.level > 2:
                    validate_annotation(tree) # level 3
                    if args.level > 4:
                        validate_lspec_annotation(sentence, args.lang) # level 5
            else:
                testlevel = 2
                testclass = 'Format'
                testid = 'skipped-corrupt-tree'
                testmessage = "Skipping annotation tests because of corrupt tree structure."
                warn(testmessage, testclass, testlevel=testlevel, testid=testid, lineno=False)
            if egraph:
                if args.level > 2:
                    validate_enhanced_annotation(egraph) # level 3
    validate_newlines(inp) # level 1

if __name__=="__main__":
    opt_parser = argparse.ArgumentParser(description="UMR validation script. Python 3 is needed to run it!")

    io_group = opt_parser.add_argument_group("Input / output options")
    io_group.add_argument('--quiet', dest="quiet", action="store_true", default=False, help='Do not print any error messages. Exit with 0 on pass, non-zero on fail.')
    io_group.add_argument('--max-err', action="store", type=int, default=20, help='How many errors to output before exiting? 0 for all. Default: %(default)d.')
    io_group.add_argument('input', nargs='*', help='Input file name(s), or "-" or nothing for standard input.')

    list_group = opt_parser.add_argument_group("Label sets", "Options relevant to checking label sets.")
    list_group.add_argument("--lang", action="store", required=True, default=None, help="Which langauge are we checking? If you specify this (as a two-letter code), the validator will use language-specific guidelines.")
    list_group.add_argument("--level", action="store", type=int, default=5, dest="level", help="Level 1: Test only the technical format backbone. Level 2: UMR format. Level 3: UMR contents. Level 4: Language-specific labels. Level 5: Language-specific contents.")

    meta_group = opt_parser.add_argument_group("Metadata constraints", "Options for checking the validity of tree metadata.")
    meta_group.add_argument("--no-tree-text", action="store_false", default=True, dest="check_tree_text", help="Do not test tree text. For internal use only, this test is required and on by default.")
    meta_group.add_argument("--no-space-after", action="store_false", default=True, dest="check_space_after", help="Do not test presence of SpaceAfter=No.")

    args = opt_parser.parse_args() # Parsed command-line arguments
    error_counter={} # Incremented by warn()  {key: error type value: its count}
    tree_counter=0

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
