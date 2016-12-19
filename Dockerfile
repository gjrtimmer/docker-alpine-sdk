FROM alpine:3.4
MAINTAINER G.J.R. Timmer <gjr.timmer@gmail.com>

ARG BUILD_DATE
ARG VCS_REF

LABEL \
	nl.timmertech.build-date=${BUILD_DATE} \
	nl.timmertech.name=alpine-sdk \
	nl.timmertech.vendor=timmertech.nl \
	nl.timmertech.vcs-url="https://github.com/GJRTimmer/docker-alpine-sdk.git" \
	nl.timmertech.vcs-ref=${VCS_REF} \
	nl.timmertech.license=MIT

RUN echo 'http://nl.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories && \
	echo 'http://nl.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories && \
	echo 'http://nl.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories && \
	apk upgrade --update --no-cache && \
	apk add --update --no-cache \
		bash \
		bash-completion \
		ca-certificates \
		shadow \
		wget \
		curl \
		git \
		alpine-sdk \
		readline && \
	adduser -D -s /bin/bash -G abuild apk && \
	passwd --delete apk && \
	echo "apk ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/apk && \
	chmod 600 /etc/sudoers.d/apk && \
	mkdir -p /var/cache/distfiles && \
	chgrp abuild /var/cache/distfiles && \
	chmod g+w /var/cache/distfiles && \
	chown -R apk:abuild /var/cache/distfiles

COPY ./init /init
VOLUME ["/home/apk/data"]
CMD /init
