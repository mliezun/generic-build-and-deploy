FROM ubuntu:20.04

MAINTAINER Miguel Liezun <liezun.js@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# Install initial dependencies & tools
RUN apt-get update && \
    apt-get -qqy install git apt-transport-https ca-certificates nodejs npm openssh-client curl

# Install yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y --no-install-recommends yarn
    
# Updgrade node to 12 LTS using 'n'
RUN npm -g install n && \
    n 12
    
# Install quasar cli
RUN npm -g install @quasar/cli
