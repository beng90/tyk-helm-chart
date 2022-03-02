CHART_NAME=tyk-headless

test:
	helm lint $(CHART_NAME)

build: version test
	helm package $(CHART_NAME)

publish: version
	jfrog rt u $(CHART_NAME)-$(CHART_VERSION).tgz helm-local/

version:
	$(eval VERSION := $(shell git describe --exact-match --tags $(git log -n1 --pretty='%h') 2> /dev/null || git log -1 --pretty=format:"%H"))
	$(eval CHART_VERSION := $(shell cat $(CHART_NAME)/Chart.yaml | grep 'version:' | tail -n1 | awk '{ print $$2 }'))
