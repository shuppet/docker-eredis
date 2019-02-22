FROM debian:stretch
LABEL maintainer="Kane Valentine <kane.valentine@shuppet.com>"

ENV DEBIAN_FRONTEND noninteractive

ADD $PWD/eredis /usr/src/eredis

WORKDIR /usr/src/eredis

RUN set -ex; \
	\
	savedAptMark="$(apt-mark showmanual)"; \
	\
	apt-get update; \
	apt-get install -y --no-install-recommends \
		build-essential \
		ca-certificates \
		cmake \
		git \
		libev-dev \
	; \
	\
	cmake $PWD; \
	make && make install; \
	\
	apt-mark auto '.*' > /dev/null; \
	apt-mark manual $savedAptMark; \
	apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
	rm -rf /var/lib/apt/lists/*
