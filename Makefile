DOCKER := /usr/bin/docker

.PHONY: all
all:

define build_push
	$(DOCKER) build --force-rm --tag $(2) $(1)
	$(DOCKER) push $(2)
endef

define tag_push
	$(DOCKER) tag $(1) $(2)
	$(DOCKER) push $(2)
	$(DOCKER) rmi $(2)
endef
