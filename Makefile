VERSION = v0.7.0
GIT_SHA = $(shell git rev-parse HEAD | cut -c1-8)

usage:
	@echo "Usage: make <Command>"
	@echo ""
	@echo "Commands"
	@echo "    usage        print this text"
	@echo "    setup        remove all except *.mk files and add Version file"
	@echo "    version      print full version (semantic one and git sha)"
	@echo "    git-release  push git tag named after the current version"

setup:
	find . -type f ! -name \*.mk -exec rm -f "{}" \;
	find .git -type d | sort -r | xargs rm -d
	@echo "$(VERSION) (git-$(GIT_SHA))" > Version

version:
	@echo "$(VERSION) (git-$(GIT_SHA))"

git-release:
	git tag -a $(VERSION)
	git push origin $(VERSION)
