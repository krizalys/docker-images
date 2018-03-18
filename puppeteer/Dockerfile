FROM ubuntu:bionic

ARG node_version='10.0.0'
ARG puppeteer_version='1.3.0'
ARG build_deps='xz-utils'

ARG packages=' \
  libasound2   \
  libgtk-3-0   \
  libnss3      \
  libxss1      \
  libxtst6     \
'

ENV NODE_PATH="/usr/local/lib/node_modules:$NODE_PATH"

ADD                                                                             \
  "https://nodejs.org/dist/v$node_version/node-v$node_version-linux-x64.tar.xz" \
  /tmp/node-linux-x64.tar.xz

RUN                                                          \
     set -ex                                                 \
  && apt-get update --fix-missing                            \
  &&                                                         \
    apt-get install                                          \
      --no-install-recommends                                \
      --yes                                                  \
      $packages                                              \
      $build_deps                                            \
  &&                                                         \
    tar                                                      \
      --directory=/usr/local                                 \
      --extract                                              \
      --file=/tmp/node-linux-x64.tar.xz                      \
      --no-same-owner                                        \
      --strip-components=1                                   \
      --xz                                                   \
  && rm --force /tmp/node-linux-x64.tar.xz                   \
  && ln --symbolic /usr/local/bin/node /usr/local/bin/nodejs \
  && rm --force --recursive /var/lib/apt/lists/*             \
  && apt-get purge --auto-remove --yes $build_deps           \
  &&                                                         \
    npm_config_user=0                                        \
    npm install                                              \
      --global                                               \
      --production                                           \
      puppeteer@$puppeteer_version
