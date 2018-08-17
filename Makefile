VERSION = $(shell cat Version)

usage:
	@echo "Usage: make clean-up|git-release"

clean-up:
	find . -type f ! -name \*.mk -exec rm -f "{}" \;
	find .git -type d | sort -r | xargs rm -d

git-release:
	git tag -a $(VERSION)
	git push origin $(VERSION)
