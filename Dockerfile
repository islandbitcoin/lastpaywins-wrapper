FROM node:14.17.0-buster-slim

# arm64 or amd64
ARG PLATFORM
ARG ARCH

RUN apt-get clean
RUN apt-get update && apt-get install -y curl wget bash tini 
RUN wget -qO /usr/local/bin/yq https://github.com/mikefarah/yq/releases/latest/download/yq_linux_${PLATFORM} && chmod +x /usr/local/bin/yq
RUN apt-get purge -y --auto-remove wget && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /
COPY lastpaywins/ .

ADD .env.example ./.env
RUN chmod a+x ./.env
ADD docker_entrypoint.sh /usr/local/bin/docker_entrypoint.sh
ADD check-web.sh /usr/local/bin/check-web.sh
RUN chmod a+x /usr/local/bin/*.sh
