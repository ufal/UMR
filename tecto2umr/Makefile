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
	rm -f $(DZMODIFDATA)/*.umr
	cd $(JSCZECHDATA) ; for i in *.umr ; do echo $$i ; cat $$i | \
	    perl -pe 's/:!!/:/g; s/:refer-(person|number) inher//ig; s/\((s[0-9]+x[0-9]+ \/) :\)/($$1 colon)/' \
	    > $(DZMODIFDATA)/$$i ; \
	done

# Validate the modified data.
.PHONY: validate
validate:
	if [ "$(whoami)" == "zeman" ]; then pushd $(UFALUMRDIR) ; git pull --no-edit ; popd ; fi
	cd $(DZMODIFDATA) ; ( for i in *.umr ; do echo $$i ; $(VALIDATE) $$i --no-warn-unaligned-token --allow-forward-references --optional-aspect-modstr --allow-duplicate-roles --allow-coref-entity-event-mismatch ; done ) 2>&1 | tee validation.log

# Honza: Celé se to (konverze z PDT-C do UMR) dá pustit skriptem
# /net/work/people/stepanek/umr/pdt-c2umr.sh ( all | trx2u | vrf )
# Skript by si měl postěžovat, kdyby bylo něco špatně. Je nutné mít nastavené tyto dvě proměnné:
# $UFAL_PDTC2A - cesta k SVN repozitáři s daty PDT-C;
# $UFAL_UMR    - cesta k UMR (ale ne checkout githubu, ale o patro výš jako mám
#                já v /net/work/people/stepanek/umr.
# V současné době není algoritmus úplně deterministický, některé stromy se vygenerují špatně a selže jejich verifikace. Dělám na tom.
