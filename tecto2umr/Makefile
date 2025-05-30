SHELL=/bin/bash

UFALUMRDIR = /net/work/people/zeman/umr/ufal-umr-repo
VALIDATE = $(UFALUMRDIR)/tools/validate.py
JSCZECHDATA = /net/work/people/stepanek/umr/data/stepanek
DZMODIFDATA = /net/work/people/zeman/umr/data-pdt-upravena

.PHONY: all
all: copy

# Verify that the UMR files do not contain pseudo-roles with two exclamation marks (the validator would choke up on that).
.PHONY: noexcl
noexcl:
	cd $(JSCZECHDATA) ; cat *.umr | grep -P ':!!' | perl -pe 's/^\s+(:!![A-Z]+).*/$$1/' | sort | uniq -c | sort -rn

# Copy data from Honza to Dan, remove the exclamation marks from pseudo-roles on the fly.
.PHONY: copy
copy:
	rm -f $(DZMODIFDATA)/*.umr
	cd $(JSCZECHDATA) ; for i in *.umr ; do echo $$i ; cat $$i | \
	    perl -pe 's/:!!/:/g; s/\((s[0-9]+x[0-9]+ \/) :\)/($$1 colon)/; s/\((s[0-9]+x[0-9]+ \/) \(\)/($$1 %lpar;)/' \
	    > $(DZMODIFDATA)/$$i ; \
	done

# Validate the modified data.
.PHONY: validate
validate:
	if [ "$(whoami)" == "zeman" ]; then pushd $(UFALUMRDIR) ; git pull --no-edit ; popd ; fi
	cd $(DZMODIFDATA) ; ( for i in *.umr ; do echo $$i ; $(VALIDATE) $$i --no-warn-unaligned-token --allow-forward-references --optional-aspect-modstr --allow-duplicate-roles --allow-coref-entity-event-mismatch ; done ) 2>&1 | tee validation.log

# If we are unable to make all files valid, we can take only the valid ones and release them.
# The script assumes that all files lie in the same folder as validation.log, and the release
# is prepered as a subfolder there.
.PHONY: release_valid
release_valid:
	cd $(DZMODIFDATA) ; $(UFALUMRDIR)/tools/release_valid_files.pl validation.log
	cd $(DZMODIFDATA) ; rm -f czech-umr.zip ; zip -r czech-umr.zip czech
	cd $(DZMODIFDATA) ; /home/zeman/bin/publish czech-umr.zip

# Honza: Celé se to (konverze z PDT-C do UMR) dá pustit skriptem
# /net/work/people/stepanek/umr/pdt-c2umr.sh ( all | trx2u | vrf )
# Skript by si měl postěžovat, kdyby bylo něco špatně. Je nutné mít nastavené tyto dvě proměnné:
# $UFAL_PDTC2A - cesta k SVN repozitáři s daty PDT-C;
# $UFAL_UMR    - cesta k UMR (ale ne checkout githubu, ale o patro výš jako mám
#                já v /net/work/people/stepanek/umr.
# V současné době není algoritmus úplně deterministický, některé stromy se vygenerují špatně a selže jejich verifikace. Dělám na tom.
