VERSION = 0.2.1
GIT_SHA = $(shell git rev-parse HEAD | cut -c1-8)

usage:
	@echo "Usage: make setup|git-release"

setup:
	find . -type f ! -name \*.mk -exec rm -f "{}" \;
	find .git -type d | sort -r | xargs rm -d
	@echo "$(VERSION) (git-$(GIT_SHA))" > Version

git-release:
	git tag -a $(VERSION)
	git push origin $(VERSION)
