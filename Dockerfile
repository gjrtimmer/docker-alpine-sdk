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
				alpine-sdk \
				diffutils && \
	adduser -D sdk && \
	passwd -d sdk && \
	echo "sdk ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/apk && \
	chmod 600 /etc/sudoers.d/apk && \
	chmod g+w /var/cache/distfiles/ && \
	addgroup sdk abuild && \
	sed "s|local size=\$(du|local size=\$(sync\;du|" -i /usr/bin/abuild && \
	apk add tzdata && \
	cp /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime && \
	apk del tzdata
	
USER sdk
WORKDIR /home/sdk

COPY ./init /init
COPY ./boot /etc/profile.d/boot.sh
COPY ./functions /etc/profile.d/functions.sh
ENTRYPOINT ["/init"]
CMD ["/bin/bash", "--login"]
