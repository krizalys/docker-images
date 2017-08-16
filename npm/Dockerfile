FROM krizalys/node:latest

ARG node_version='6.10.3-r1'
ARG gxx_version='6.3.0-r4'
ARG git_version='2.13.5-r0'
ARG libexecinfo_dev_version='1.1-r0'
ARG make_version='4.2.1-r0'
ARG python_version='2.7.13-r1'
ARG jobs='MAX'

RUN                                   \
     set -ex                          \
  && apk update                       \
  && apk add nodejs-npm=$node_version

RUN                                            \
     set -ex                                   \
  && apk update                                \
  &&                                           \
    apk add                                    \
      g++=$gxx_version                         \
      git=$git_version                         \
      libexecinfo-dev=$libexecinfo_dev_version \
      make=$make_version                       \
      python=$python_version

ENV JOBS="$jobs"

ENTRYPOINT ['npm']
