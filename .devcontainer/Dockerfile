FROM debian:stretch
FROM mcr.microsoft.com/devcontainers/universal:2-linux


RUN apt-get update && apt-get -y install git curl unzip

RUN apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /home/codespace
WORKDIR /home/codespace

ENV PUB_CACHE=/home/codespace/.pub_cache
ENV PATH="/home/codespace/flutter/bin:$PATH"

RUN git clone https://github.com/flutter/flutter.git -b stable && \
    /home/codespace/flutter/bin/flutter config --enable-web
