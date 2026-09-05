LATEST_TAG := $(shell git tag --sort=-v:refname | head -n1)
VERSION ?= $(shell \
	if [ -z "$(LATEST_TAG)" ]; then \
		echo v0.1.0; \
	else \
		ver=$(LATEST_TAG); ver=$${ver#v}; \
		major=$$(echo $$ver | cut -d. -f1); \
		minor=$$(echo $$ver | cut -d. -f2); \
		patch=$$(echo $$ver | cut -d. -f3 | cut -d- -f1); \
		echo v$$major.$$minor.$$((patch+1)); \
	fi)

.PHONY: release
release:
	gh release create $(VERSION) --title "Release $(VERSION)" --target main --generate-notes
