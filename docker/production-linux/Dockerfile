FROM ubuntu:jammy
# jammy is the code name of 22.04 LTS
LABEL maintainer="adelsoncn@gmail.com"

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -yy install \
    build-essential \
    libcurl4-openssl-dev \
    libcurl3-gnutls \
    libgl1-mesa-dev \
    libgtk-3-bin \
    libosmesa-dev \
    libpython3.10 \
    xorg \
    net-tools \
    libfbclient2 \
    locales

RUN ln -s /usr/lib/x86_64-linux-gnu/libfbclient.so.2 /usr/lib/x86_64-linux-gnu/libfbclient.so

RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
	&& localedef -i pt_BR -c -f UTF-8 -A /usr/share/locale/locale.alias pt_BR.UTF-8
ENV LC_ALL pt_BR.UTF-8
ENV LANG ept_BR.UTF-8
ENV LANGUAGE pt_BR.UTF-8

ENTRYPOINT ./production/APITeste 

EXPOSE 9000