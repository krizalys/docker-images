DOCKER := /usr/bin/docker

.PHONY: all
all:

.PHONY: image-composer
image-composer: image-php
	$(DOCKER) build --force-rm --tag krizalys/composer:1.6.4 composer
	$(DOCKER) tag krizalys/composer:1.6.4 krizalys/composer:1.6
	$(DOCKER) tag krizalys/composer:1.6.4 krizalys/composer:1
	$(DOCKER) tag krizalys/composer:1.6.4 krizalys/composer:latest

.PHONY: image-nginx
image-nginx:
	$(DOCKER) build --force-rm --tag krizalys/nginx:1.14.0 nginx/1.14.0
	$(DOCKER) tag krizalys/nginx:1.14.0 krizalys/nginx:1.14
	$(DOCKER) tag krizalys/nginx:1.14.0 krizalys/nginx:1
	$(DOCKER) tag krizalys/nginx:1.14.0 krizalys/nginx:latest

.PHONY: image-nginx-fastcgi
image-nginx-fastcgi:
	$(DOCKER) build --force-rm --tag krizalys/nginx:1.14.0-fastcgi nginx/1.14.0-fastcgi
	$(DOCKER) tag krizalys/nginx:1.14.0-fastcgi krizalys/nginx:1.14-fastcgi
	$(DOCKER) tag krizalys/nginx:1.14.0-fastcgi krizalys/nginx:1-fastcgi
	$(DOCKER) tag krizalys/nginx:1.14.0-fastcgi krizalys/nginx:latest-fastcgi

.PHONY: image-node
image-node:
	$(call build_push,node,krizalys/node:14.3.0-alpine3.11)
	$(call tag_push,krizalys/node:14.3.0-alpine3.11,krizalys/node:14.3.0-alpine)
	$(call tag_push,krizalys/node:14.3.0-alpine3.11,krizalys/node:14.3.0)
	$(call tag_push,krizalys/node:14.3.0-alpine3.11,krizalys/node:14.3)
	$(call tag_push,krizalys/node:14.3.0-alpine3.11,krizalys/node:14)

.PHONY: image-npm
image-npm:
	$(DOCKER) build --force-rm --tag krizalys/npm:3.10.10 npm
	$(DOCKER) tag krizalys/npm:3.10.10 krizalys/npm:3.10
	$(DOCKER) tag krizalys/npm:3.10.10 krizalys/npm:3
	$(DOCKER) tag krizalys/npm:3.10.10 krizalys/npm:latest

.PHONY: image-php
image-php:
	$(DOCKER) build --force-rm --tag krizalys/php:5.6.35 php
	$(DOCKER) tag krizalys/php:5.6.35 krizalys/php:5.6
	$(DOCKER) tag krizalys/php:5.6.35 krizalys/php:5
	$(DOCKER) tag krizalys/php:5.6.35 krizalys/php:latest

define build_push
	$(DOCKER) build --force-rm --tag $(2) $(1)
	$(DOCKER) push $(2)
endef

define tag_push
	$(DOCKER) tag $(1) $(2)
	$(DOCKER) push $(2)
	$(DOCKER) rmi $(2)
endef
