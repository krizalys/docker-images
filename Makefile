DOCKER := /usr/bin/docker

.PHONY: all
all:

.PHONY: image-node
image-node:
	$(call build_push,node,krizalys/node:14.3.0-alpine3.11)
	$(call tag_push,krizalys/node:14.3.0-alpine3.11,krizalys/node:14.3.0-alpine)
	$(call tag_push,krizalys/node:14.3.0-alpine3.11,krizalys/node:14.3.0)
	$(call tag_push,krizalys/node:14.3.0-alpine3.11,krizalys/node:14.3)
	$(call tag_push,krizalys/node:14.3.0-alpine3.11,krizalys/node:14)

define build_push
	$(DOCKER) build --force-rm --tag $(2) $(1)
	$(DOCKER) push $(2)
endef

define tag_push
	$(DOCKER) tag $(1) $(2)
	$(DOCKER) push $(2)
	$(DOCKER) rmi $(2)
endef
