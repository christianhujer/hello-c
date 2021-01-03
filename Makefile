CFLAGS:=-W -Wall --pedantic -Werror
SHELL:=/bin/sh
prefix:=/usr/local
exec_prefix:=$(prefix)
bindir:=$(exec_prefix)/bin
mandir:=$(prefix)/share/man/man1

vpath %.c src/

.PHONY: all
all: hello

.PHONY: install
install:
	install -t $(bindir) hello
	-install -t $(mandir) man/hello.1

.PHONY: clean
clean:: distclean
	$(RM) hello

.PHONY: distclean
distlean::
	$(RM) hello TAGS

.PHONY: mostlyclean
mostlyclean:: clean

.PHONY: realclean
realclean::
	git clean -dfX

TAGS:
	ctags -e -R .

.PHONY: dist
dist: hello-c.tar.gz
hello-c.tar.gz:
	touch $@
	tar \
		czf $@ \
		-C ../ \
		--exclude-vcs \
		--exclude-vcs-ignores \
		--owner=nobody \
		--group=nobody \
		$(notdir $(abspath .))

.PHONY: check
check: SHELL:=/bin/bash
check: hello
	diff check/expected.txt <(./hello)
