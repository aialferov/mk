VERSION = $(shell cat Version)

usage:
	@echo "Usage: make git-release"

git-release:
	git tag -a $(VERSION)
	git push origin $(VERSION)
