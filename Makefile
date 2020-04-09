##
# Makefile automatically generated by genmake 1.0, May-03-00
# genmake 1.0 by muquit@muquit.com, http://www.muquit.com/

PROGNAME= mailsend-go
PROGNAME_WIN= $(PROGNAME).exe
PROGNAME_PI= $(PROGNAME)-raspberry-pi
PROGNAME_PI_JESSIE= $(PROGNAME)-raspberry-pi-jessie
DESTDIR=
VERSION=1.0.1
BUILD_OPTIONS = -ldflags "-X main.Version=$(VERSION)"
BINDIR= /usr/local/bin
MANPAGE= docs/mailsend-go.1
MANDIR= /usr/local/share/man/man1
CP= /bin/cp -v
OS= $(shell go env GOOS)

all:
	@echo "- Compiling ${PROGNAME} ..."
	go build


example:
	@./scripts/mkexamples.sh

$(PROGNAME) : native

linux: 
	@echo "- Building $(PROGNAME)_linux"
	@CGO_ENABLED=0 GOOS=linux go build -o $(PROGNAME)_linux
	/bin/ls -lt $(PROGNAME)_linux
	@echo ""

native:
	@echo "- Building $(PROGNAME)"
	@go build -o $(PROGNAME)
	/bin/ls -lt $(PROGNAME)
	@echo ""

windows:
	@echo "- Building $(PROGNAME_WIN) for Windows amd64"
	CGO_ENABLED=0 GOOS=windows GOARCH=386 go build -o $(PROGNAME_WIN)
	/bin/ls -lt $(PROGNAME_WIN)
	@echo ""

mac:
	@echo "- Building $(PROGNAME) for Mac amd64"
	CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go build -o $(PROGNAME)_mac
	/bin/ls -lt $(PROGNAME)_mac
	@echo ""

pi: 
	@echo "- Building $(PROGNAME) for raspberry pi"
	GOOS=linux GOARCH=arm GOARM=7 go build -o $(PROGNAME_PI)
	/bin/ls -lt $(PROGNAME_PI)
	@echo ""

pijessie: 
	@echo "- Building $(PROGNAME) for raspberry pi jessie"
	GOARM=6 GOARCH=arm GOOS=linux go build -o $(PROGNAME_PI_JESSIE)
	/bin/ls -lt $(PROGNAME_PI_JESSIE)
	@echo ""


# generate files/examples.txt from docs/examples.md
# generate examples.go from examples.txt for -ex flag
gen: example doc

dev: gen all doc

doc:
	@./scripts/mkdocs.sh
	@echo " - Generate docs/mailsend-go.1"
	@pandoc --standalone --to man README.md -o docs/mailsend-go.1

tools:
	go get gopkg.in/gomail.v2

install: install-bin

help:
	@echo "============================================================"
	@echo " make gen   - assemble document, create usage.txt and examples.
	
	
	go"
	@echo " make       - build native client"
	@echo " make linux - build linux client"
	@echo " make mac   - build mac client"
	@echo " make win   - build windows client"
	@echo " make clean"
	@echo "============================================================"

install-bin:
	$(CP) $(PROGNAME) $(BINDIR)
	$(CP) $(MANPAGE) $(MANDIR)

clean:
	/bin/rm -f $(PROGNAME) $(PROGNAME_WIN) $(PROGNAME)_$(OS) $(PROGNAME)_* *.bak \
		$(PROGNAME)_linux $(PROGNAME)_mac
