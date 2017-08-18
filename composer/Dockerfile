FROM krizalys/php:latest

ARG php='php'
ARG composer_version='1.6.4'
ARG installer='/tmp/composer-setup.php'
ARG checksum='544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061'
ARG install_dir='/usr/bin'
ARG filename='composer'

RUN                                                                                                    \
     set -ex                                                                                           \
  && $php --run "copy('https://getcomposer.org/installer', '$installer');"                             \
  &&                                                                                                   \
    $php --run "                                                                                       \
      if (hash_file('SHA384', '$installer') === '$checksum') echo 'Installer verified';                \
      else { echo 'Installer corrupt'; unlink('$installer'); } echo PHP_EOL;                           \
    "                                                                                                  \
  && $php "$installer" --install-dir="$install_dir" --filename="$filename" --version=$composer_version \
  && $php --run "unlink('$installer');"

ENTRYPOINT ['/usr/bin/composer']
