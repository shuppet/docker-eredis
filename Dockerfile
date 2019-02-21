FROM debian:stretch-slim
LABEL maintainer="Kane Valentine <kane@cute.im>"

ENV DEBIAN_FRONTEND noninteractive

ADD $PWD/eredis /usr/src/eredis
WORKDIR /usr/src/eredis
RUN ls -lah

RUN set -ex; \
	\
	savedAptMark="$(apt-mark showmanual)"; \
	\
	apt-get update; \
	apt-get install -qq --no-install-recommends \
		build-essential \
		ca-certificates \
		cmake \
		git \
		libev-dev \
	; \
	\
	git submodule update --init; \
	cmake $PWD; \
	make && make install; \
	\
	apt-mark auto '.*' > /dev/null; \
	apt-mark manual $savedAptMark; \
	apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
	rm -rf /var/lib/apt/lists/*
