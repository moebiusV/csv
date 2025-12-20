# Makefile for csv - Unix-style CSV utilities
#
# Usage:
#   make install          Install to system (default: /usr/local)
#   make install prefix=$HOME/.local   Install to home directory
#   make uninstall        Remove installed files
#   make dist             Create distribution tarball
#   make clean            Remove build artifacts
#   make help             Show this help

PROGNAME = csv
VERSION = 1.2.0

# Installation directories (GNU Coding Standards)
prefix ?= /usr/local
exec_prefix ?= $(prefix)
bindir ?= $(exec_prefix)/bin
datarootdir ?= $(prefix)/share
mandir ?= $(datarootdir)/man
man1dir ?= $(mandir)/man1
docdir ?= $(datarootdir)/doc/$(PROGNAME)

# For staged installs (packaging)
DESTDIR ?=

# Source files
SCRIPT = csv
MANPAGE = csv.1
DOCS = README README.md NEWS ChangeLog COPYING AUTHORS

.PHONY: all install install-bin install-man install-doc uninstall dist clean help

all:
	@echo "Nothing to build (Python script)."
	@echo "Run 'make install' to install, or 'make help' for options."

install: install-bin install-man install-doc

install-bin:
	install -d $(DESTDIR)$(bindir)
	install -m 755 $(SCRIPT) $(DESTDIR)$(bindir)/$(PROGNAME)

install-man:
	install -d $(DESTDIR)$(man1dir)
	install -m 644 $(MANPAGE) $(DESTDIR)$(man1dir)/$(PROGNAME).1

install-doc:
	install -d $(DESTDIR)$(docdir)
	install -m 644 $(DOCS) $(DESTDIR)$(docdir)/

uninstall:
	rm -f $(DESTDIR)$(bindir)/$(PROGNAME)
	rm -f $(DESTDIR)$(man1dir)/$(PROGNAME).1
	rm -rf $(DESTDIR)$(docdir)

dist:
	mkdir -p $(PROGNAME)-$(VERSION)
	cp $(SCRIPT) $(MANPAGE) Makefile $(DOCS) $(PROGNAME)-$(VERSION)/
	tar czvf $(PROGNAME)-$(VERSION).tar.gz $(PROGNAME)-$(VERSION)
	rm -rf $(PROGNAME)-$(VERSION)
	@echo "Created $(PROGNAME)-$(VERSION).tar.gz"

clean:
	rm -rf $(PROGNAME)-$(VERSION) $(PROGNAME)-$(VERSION).tar.gz

help:
	@echo "csv $(VERSION) - Unix-style CSV utilities"
	@echo ""
	@echo "Targets:"
	@echo "  install       Install program, man page, and documentation"
	@echo "  install-bin   Install only the program"
	@echo "  install-man   Install only the man page"
	@echo "  install-doc   Install only documentation"
	@echo "  uninstall     Remove all installed files"
	@echo "  dist          Create distribution tarball"
	@echo "  clean         Remove build artifacts"
	@echo "  help          Show this help"
	@echo ""
	@echo "Variables:"
	@echo "  prefix        Installation prefix (default: /usr/local)"
	@echo "  DESTDIR       Staging directory for packaging"
	@echo ""
	@echo "Examples:"
	@echo "  sudo make install                    Install system-wide"
	@echo "  make install prefix=\$$HOME/.local    Install to home directory"
	@echo "  make DESTDIR=/tmp/pkg install        Stage for packaging"
