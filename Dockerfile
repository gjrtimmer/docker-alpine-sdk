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
	apk upgrade --update --no-cache && \
	apk add --update --no-cache \
		bash \
		bash-completion \
		ca-certificates \
		wget \
		curl \
		git \
		alpine-sdk \
		readline \
		perl \
		perl-dev \
		python \
		python-dev \
		tcl \
		tcl-dev \
		zlib-dev \
		openssl-dev \
		openldap-dev \
		libedit-dev \
		libxml2-dev \
		util-linux-dev && \
	adduser -D -s /bin/bash -G abuild apk && \
	echo "apk ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/apk && \
	chmod 600 /etc/sudoers.d/apk && \
	mkdir -p /var/cache/distfiles && \
	chmod a+w /var/cache/distfiles

COPY ./init /init
VOLUME ["/home/apk/data"]
CMD /init