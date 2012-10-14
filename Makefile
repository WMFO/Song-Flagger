#Makefile for Watchdog
#Bash scripts aren't compiled, but used for install
#Suggested usage: git pull
#                 sudo make install

INSTALLDIR = /opt/wmfo/songFlagger
OWNER = root
MOD = 644
CREDSMOD = 600
FILES = songFlagger.sh getSongData.php spinpapi.inc.php
CREDS = credentials.php


.PHONY: all install uninstall

all:
	@echo "make: nothing to build for bash scripts"
	@echo "make: suggested usage: sudo make install"

install: $(addprefix $(INSTALLDIR)/, $(FILES)) $(INSTALLDIR)/$(CREDS)

$(CREDS):
	@chown $(OWNER) $@
	@chmod $(CREDSMOD) $@

$(INSTALLDIR)/$(CREDS): $(CREDS)
	@mkdir -p $(INSTALLDIR)
	@cp $< $@
	@chown $(OWNER) $@
	@chmod $(CREDSMOD) $@

$(INSTALLDIR)/%.php: %.php
	@mkdir -p $(INSTALLDIR)
	@cp $< $@
	@chown $(OWNER) $@
	@chmod $(MOD) $@

$(INSTALLDIR)/%.sh: %.sh
	@mkdir -p $(INSTALLDIR)
	@cp $< $@
	@chown $(OWNER) $@
	@chmod $(MOD) $@

uninstall:
	for file in $(FILES); do \
	$(RM) $(INSTALLDIR)/$$file ; \
	done

