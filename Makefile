BINDIR=/usr/bin
DESKTOPDIR=/usr/share/applications
DESTDIR=

all: desktop/quikscan.desktop

dist: clean
	DIR=quikscan-`awk '/^Version:/ {print $$2}' rpm/quikscan.spec` && FILENAME=$$DIR.tar.gz && tar cvzf "$$FILENAME" --exclude "$$FILENAME" --exclude .git --exclude .gitignore -X .gitignore --transform="s|^|$$DIR/|" --show-transformed *

rpm: dist
	T=`mktemp -d` && rpmbuild --define "_topdir $$T" -ta quikscan-`awk '/^Version:/ {print $$2}' rpm/quikscan.spec`.tar.gz || { rm -rf "$$T"; exit 1; } && mv "$$T"/RPMS/noarch/* "$$T"/SRPMS/* . || { rm -rf "$$T"; exit 1; } && rm -rf "$$T"

srpm: dist
	T=`mktemp -d` && rpmbuild --define "_topdir $$T" -ts quikscan-`awk '/^Version:/ {print $$2}' rpm/quikscan.spec`.tar.gz || { rm -rf "$$T"; exit 1; } && mv "$$T"/SRPMS/* . || { rm -rf "$$T"; exit 1; } && rm -rf "$$T"

install: all
	install -Dm 755 bin/quikscan -t $(DESTDIR)/$(BINDIR)/
	install -Dm 644 desktop/quikscan.desktop -t $(DESTDIR)/$(DESKTOPDIR)/

desktop/quikscan.desktop: desktop/quikscan.desktop.in
	sed 's|@BINDIR@|$(BINDIR)|g' < $< > $@

clean:
	rm -f doc/*.gz desktop/eyefiserver-prefs.desktop

gitclean:
	LANG=C git status | grep -q 'orking directory clean' && { git clean -fxd ; } || { git status ; read -p "Some of these changes will be lost.  Hit ENTER to confirm, Ctrl+C to cancel. " ; git clean -fxd ; }

.PHONY: install clean
