SHELL=/bin/bash

# Variables defined with := in GNU make are expanded when they are defined rather than when they are used.

UFALUMRDIR = /net/work/people/zeman/umr/ufal-umr-repo
VALIDATE = $(UFALUMRDIR)/tools/validate.py
JSCZECHDATA = /net/work/people/stepanek/umr/data/stepanek
DZMODIFDATA = /net/work/people/zeman/umr/data-pdt-upravena

# If a command ends with ane error, delete its target file because it may be corrupt.
.DELETE_ON_ERROR:

.PHONY: all
all: copy

# Verify that the UMR files do not contain pseudo-roles with two exclamation marks (the validator would choke up on that).
.PHONY: noexcl
noexcl:
	cd $(JSCZECHDATA) ; cat *.umr | grep -P ':!!' | perl -pe 's/^\s+(:!![A-Z]+).*/$$1/' | sort | uniq -c | sort -rn

# Copy data from Honza to Dan, remove the exclamation marks from pseudo-roles on the fly.
.PHONY: copy
copy:
	rm $(DZMODIFDATA)/*.umr
	cd $(JSCZECHDATA) ; for i in *.umr ; do echo $$i ; cat $$i | perl -pe 's/:!!/:/g' > $(DZMODIFDATA)/$$i ; done

# Validate the modified data.
.PHONY: validate
validate:
	if [ "$(whoami)" == "zeman" ]; then pushd $(UFALUMRDIR) ; git pull --no-edit ; popd ; fi
	cd $(DZMODIFDATA) ; ( for i in *.umr ; do echo $$i ; $(VALIDATE) $$i --no-warn-unaligned-token --allow-forward-references --optional-aspect-modstr ; done ) 2>&1 | tee validation.log
