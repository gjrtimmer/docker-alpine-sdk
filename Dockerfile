FROM alpine:edge
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

RUN apk update && \
	apk add --update --no-cache \
				bash \
				bash-completion \
				alpine-sdk && \
	adduser sdk && \
	passwd --delete sdk && \
	echo "sdk ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/apk && \
	chmod 600 /etc/sudoers.d/apk && \
	chmod g+w /var/cache/distfiles/ && \
	addgroup sdk abuild
	
USER sdk
WORKDIR /home/sdk

COPY ./init /init
COPY ./functions /etc/profile.d/functions.sh
ENTRYPOINT ["/init"]
CMD ["/bin/bash"]
