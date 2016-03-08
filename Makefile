# dssh Makefile #

PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin
MANDIR ?= $(PREFIX)/share/man

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

release: doc clean
	mkdir dssh-1.0
	cp -r bin ./dssh-1.0
	cp -r doc ./dssh-1.0
	cp LICENSE.txt ./dssh-1.0



# Installation #################################################################
install: all
	install -d $(DESTDIR)/$(BINDIR)
	install bin/dssh $(DESTDIR)/$(BINDIR)
	install -d $(DESTDIR)/$(MANDIR)/man1/
	install doc/dssh.1 $(DESTDIR)/$(MANDIR)/man1/
