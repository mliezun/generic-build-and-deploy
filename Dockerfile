FROM ubuntu:20.04

MAINTAINER Miguel Liezun <liezun.js@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# Install dependencies & tools
RUN apt-get update && \
    apt-get -qqy install git apt-transport-https ca-certificates nodejs npm openssh-client curl && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt update && apt install -y --no-install-recommends yarn && \
    npm -g install n && \
    n 12 && \
    npm -g install @quasar/cli
