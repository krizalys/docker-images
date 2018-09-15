FROM alpine:3.8

ARG user='nginx'
ARG group='nginx'
ARG htdocs="/usr/share/$user"
ARG nginx_version='1.14.0'

ARG nginx_config_modules='                  \
  --with-pcre                               \
  --without-http-cache                      \
  --without-http_access_module              \
  --without-http_auth_basic_module          \
  --without-http_autoindex_module           \
  --without-http_browser_module             \
  --without-http_charset_module             \
  --without-http_empty_gif_module           \
  --without-http_geo_module                 \
  --without-http_grpc_module                \
  --without-http_gzip_module                \
  --without-http_limit_conn_module          \
  --without-http_limit_req_module           \
  --without-http_map_module                 \
  --without-http_memcached_module           \
  --without-http_mirror_module              \
  --without-http_proxy_module               \
  --without-http_referer_module             \
  --without-http_rewrite_module             \
  --without-http_scgi_module                \
  --without-http_split_clients_module       \
  --without-http_ssi_module                 \
  --without-http_upstream_hash_module       \
  --without-http_upstream_ip_hash_module    \
  --without-http_upstream_keepalive_module  \
  --without-http_upstream_least_conn_module \
  --without-http_upstream_zone_module       \
  --without-http_userid_module              \
  --without-http_uwsgi_module               \
'

ARG nginx_config_build_deps=' \
  pcre-dev                    \
'

ARG nginx_config="                                          \
  --prefix=$htdocs                                          \
  --sbin-path=/usr/sbin/nginx                               \
  --modules-path=/usr/lib/nginx/modules                     \
  --conf-path=/etc/nginx/nginx.conf                         \
  --error-log-path=/var/log/nginx/error.log                 \
  --http-log-path=/var/log/nginx/access.log                 \
  --pid-path=/var/run/nginx.pid                             \
  --lock-path=/var/run/nginx.lock                           \
  --http-client-body-temp-path=/var/cache/nginx/client_temp \
  --http-proxy-temp-path=/var/cache/nginx/proxy_temp        \
  --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp    \
  --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp        \
  --http-scgi-temp-path=/var/cache/nginx/scgi_temp          \
  --user=$user                                              \
  --group=$group                                            \
  $nginx_config_modules                                     \
"

ARG build_deps="           \
  gcc                      \
  libc-dev                 \
  make                     \
  $nginx_config_build_deps \
"

RUN                                                                                                  \
     set -ex                                                                                         \
  && wget -O /tmp/nginx-$nginx_version.tar.gz https://nginx.org/download/nginx-$nginx_version.tar.gz \
  && tar -xz -C /tmp -f /tmp/nginx-$nginx_version.tar.gz                                             \
  && rm /tmp/nginx-$nginx_version.tar.gz                                                             \
  && cd /tmp/nginx-$nginx_version                                                                    \
  && apk add --no-cache --virtual .build-deps $build_deps                                            \
  && ./configure $nginx_config                                                                       \
  && make CFLAGS='-pipe -O3' -j$(getconf _NPROCESSORS_ONLN)                                          \
  && addgroup -S $group                                                                              \
  && adduser -DS -G $group -h "$htdocs" -s /sbin/nologin $user                                       \
  && make install                                                                                    \
  && strip /usr/sbin/nginx                                                                           \
  && { test -d /usr/lib/nginx/modules && strip /usr/lib/nginx/modules/*.so; true; }                  \
  && apk del .build-deps                                                                             \
  && rm -f /etc/nginx/*                                                                              \
  && cp conf/mime.types /etc/nginx                                                                   \
  && cd /                                                                                            \
  && rm -fr /tmp/nginx-$nginx_version                                                                \
  && mkdir -p /var/cache/nginx                                                                       \
  && chown $user:$group /var/cache/nginx                                                             \
  && apk add --no-cache pcre                                                                         \
  && ln -fs /dev/stdout /var/log/nginx/access.log                                                    \
  && ln -fs /dev/stderr /var/log/nginx/error.log

COPY snapshot/etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf
COPY snapshot/etc/nginx/nginx.conf          /etc/nginx/nginx.conf
COPY snapshot/etc/nginx/fastcgi_params      /etc/nginx/fastcgi_params

EXPOSE 80

STOPSIGNAL SIGTERM

CMD ["nginx", "-g", "daemon off;"]
