ARG DOCKER_PROXY
FROM ${DOCKER_PROXY}/alpine:edge

RUN apk update && \
	apk add --update --no-cache --force-overwrite \
	bash \
	bash-completion \
	alpine-sdk \
	sudo \
	diffutils && \
	adduser -D sdk && \
	passwd -d sdk && \
	echo "sdk ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/apk && \
	chmod 600 /etc/sudoers.d/apk && \
	chmod g+w /var/cache/distfiles/ && \
	addgroup sdk abuild && \
	apk add tzdata && \
	cp /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime && \
	apk del tzdata

USER sdk
WORKDIR /home/sdk

COPY rootfs/ /
ENTRYPOINT ["/init"]
CMD ["/bin/bash", "--login"]

ARG BUILD_DATE
ARG CI_PROJECT_NAME
ARG CI_PROJECT_URL
ARG VCS_REF
ARG DOCKER_IMAGE

LABEL \
	maintainer="G.J.R. Timmer <gjr.timmer@gmail.com>" \
	org.label-schema.schema-version="1.0" \
	org.label-schema.build-date="${BUILD_DATE}" \
	org.label-schema.name="${CI_PROJECT_NAME}" \
	org.label-schema.url="${CI_PROJECT_URL}" \
	org.label-schema.vcs-url="https://github.com/GJRTimmer/docker-alpine-sdk.git" \
	org.label-schema.vcs-ref=${VCS_REF} \
	org.label-schema.docker.image="${DOCKER_IMAGE}" \
	org.label-schema.license=MIT
