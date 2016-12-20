FROM alpine:edge
MAINTAINER G.J.R. Timmer <gjr.timmer@gmail.com>

ARG BUILD_DATE
ARG VCS_REF
ARG GITHUB_USER

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
	apk update && \
	apk add --update --no-cache \
				bash \
				bash-completion \
				ca-certificates \
				shadow \
				openssh-client \
				wget \
				curl \
				git \
				alpine-sdk \
				readline-dev && \
	addgroup sdk && \
	adduser  -G sdk -s /bin/bash -D sdk && \
	passwd --delete sdk && \
	echo "sdk ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/apk && \
	chmod 600 /etc/sudoers.d/apk && \
	chmod g+w /var/cache/distfiles/ && \
	addgroup sdk abuild
	
USER sdk
WORKDIR /tmp
RUN git clone --recursive https://github.com/${GITHUB_USER}/aports.git
WORKDIR /home/sdk

COPY ./init /init
ENTRYPOINT ["/init"]
CMD ["/bin/bash"]
