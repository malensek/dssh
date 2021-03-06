# dssh Makefile #
name = dssh
version = 1.1

PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin
MANDIR ?= $(PREFIX)/share/man

release-dir = $(name)-$(version)
release-tar = $(release-dir).tar.gz

all:
	@echo " - Use 'make install' to install dssh"
	@echo " - To (re)generate documentation, use 'make doc' (requires pandoc)"

# Documentation ################################################################
doc: doc/dssh.1 README.md

doc/dssh.1: doc/dssh.1.md
	pandoc --standalone --to=man $< -o $@

doc/dssh.1.gh.md: doc/dssh.1.md
	pandoc --to=markdown_github $< -o $@

README.md: doc/readme_header.md doc/dssh.1.gh.md
	cat $^ > $@

clean:
	rm -f doc/dssh.1.gh.md
	rm -rf $(release-dir)
	rm -f $(release-tar)

# Installation #################################################################
install: bin/dssh doc/dssh.1
	install -d $(DESTDIR)/$(BINDIR)
	install bin/dssh $(DESTDIR)/$(BINDIR)
	install -d $(DESTDIR)/$(MANDIR)/man1/
	install doc/dssh.1 $(DESTDIR)/$(MANDIR)/man1/

dist: doc clean
	mkdir $(release-dir)
	cp -r CHANGELOG.md LICENSE.txt Makefile README.md bin doc $(release-dir)
	tar czvf $(release-tar) $(release-dir)
