# Makefile for csv - Unix-style commands for CSV files
# GNU Makefile conventions compliant

PACKAGE = csv
VERSION = 1.0.0

# Installation directories (GNU standard)
prefix = /usr/local
exec_prefix = $(prefix)
bindir = $(exec_prefix)/bin
datarootdir = $(prefix)/share
mandir = $(datarootdir)/man
man1dir = $(mandir)/man1
docdir = $(datarootdir)/doc/$(PACKAGE)

# Install programs
INSTALL = install
INSTALL_PROGRAM = $(INSTALL) -m 755
INSTALL_DATA = $(INSTALL) -m 644

# Files
SCRIPTS = csv
MANPAGES = csv.1
DOCS = README NEWS AUTHORS COPYING ChangeLog

.PHONY: all install install-bin install-man install-doc uninstall clean distclean dist help

all:
	@echo "Nothing to build. Run 'make install' to install."

install: install-bin install-man install-doc

install-bin:
	$(INSTALL) -d $(DESTDIR)$(bindir)
	$(INSTALL_PROGRAM) $(SCRIPTS) $(DESTDIR)$(bindir)/

install-man:
	$(INSTALL) -d $(DESTDIR)$(man1dir)
	$(INSTALL_DATA) $(MANPAGES) $(DESTDIR)$(man1dir)/

install-doc:
	$(INSTALL) -d $(DESTDIR)$(docdir)
	$(INSTALL_DATA) $(DOCS) $(DESTDIR)$(docdir)/

uninstall:
	rm -f $(DESTDIR)$(bindir)/csv
	rm -f $(DESTDIR)$(man1dir)/csv.1
	rm -rf $(DESTDIR)$(docdir)

clean:
	@echo "Nothing to clean."

distclean: clean
	rm -f config.status config.log

dist:
	mkdir -p $(PACKAGE)-$(VERSION)
	cp $(SCRIPTS) $(MANPAGES) $(DOCS) Makefile $(PACKAGE)-$(VERSION)/
	tar -czf $(PACKAGE)-$(VERSION).tar.gz $(PACKAGE)-$(VERSION)
	rm -rf $(PACKAGE)-$(VERSION)
	@echo "Created $(PACKAGE)-$(VERSION).tar.gz"

help:
	@echo "Targets:"
	@echo "  all          - Default target (nothing to build)"
	@echo "  install      - Install script, man page, and documentation"
	@echo "  install-bin  - Install only the script"
	@echo "  install-man  - Install only the man page"
	@echo "  install-doc  - Install only the documentation"
	@echo "  uninstall    - Remove installed files"
	@echo "  dist         - Create distribution tarball"
	@echo "  clean        - Clean build artifacts"
	@echo "  help         - Show this help"
	@echo ""
	@echo "Variables:"
	@echo "  prefix       - Installation prefix (default: /usr/local)"
	@echo "  DESTDIR      - Staging directory for package building"
	@echo ""
	@echo "Example:"
	@echo "  sudo make install"
	@echo "  make install prefix=\$$HOME/.local"
