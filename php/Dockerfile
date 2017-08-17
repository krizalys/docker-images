FROM alpine:3.7

ARG php_version='5.6.35-r0'

ARG extensions="            \
  php5-json=$php_version    \
  php5-openssl=$php_version \
  php5-phar=$php_version    \
  php5-zlib=$php_version    \
"

RUN                                   \
     set -ex                          \
  && apk update                       \
  &&                                  \
    apk add                           \
      php5=$php_version               \
      $extensions                     \
  && ln -s /usr/bin/php5 /usr/bin/php

ENTRYPOINT ['/usr/bin/php']
