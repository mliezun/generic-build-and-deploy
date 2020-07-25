FROM ubuntu:20.04

MAINTAINER Miguel Liezun <liezun.js@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# Install initial dependencies & tools
RUN apt-get -qqy update && \
    apt-get install -qqy --no-install-recommends wget gnupg2 rsync \
    apache2 composer php php-cli php-fpm php-json php-pdo php-mysql \ 
    php-zip php-gd php-mbstring php-curl php-xml php-pear php-bcmath \
    git apt-transport-https ca-certificates nodejs npm openssh-client \
    curl lsb-core redis-server php-redis && \
    a2enmod proxy_fcgi setenvif && \
    a2enconf php7.4-fpm && \
    phpenmod -v 7.4 -s ALL redis && \
    npm -g install n && \
    n 12

# Install yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    wget https://repo.percona.com/apt/percona-release_latest.$(lsb_release -sc)_all.deb && \
    dpkg -i percona-release_latest.$(lsb_release -sc)_all.deb && \
    percona-release setup ps80 && \
    apt-get install -qqy --no-install-recommends yarn percona-server-server && \
    rm percona-release_latest.$(lsb_release -sc)_all.deb

# Install node packages
RUN npm -g install @quasar/cli cordova


# Clear all caches
RUN rm -rf /var/lib/apt/lists/* && \
    npm cache clean --force 

