FROM --platform=$BUILDPLATFORM debian:bullseye-slim as build

LABEL maintainer="jacob.alberty@foundigital.com"

ARG TARGETPLATFORM
ARG BUILDPLATFORM

ENV PREFIX=/usr/local/firebird
ENV VOLUME=/firebird
ENV DEBIAN_FRONTEND noninteractive
ENV FBURL=https://github.com/FirebirdSQL/firebird/releases/download/v4.0.1/Firebird-4.0.1.2692-0.tar.xz
ENV DBPATH=/firebird/data

COPY fixes /home/fixes
RUN chmod -R +x /home/fixes

COPY build.sh ./build.sh

RUN chmod +x ./build.sh && \
    sync && \
    ./build.sh && \
    rm -f ./build.sh

FROM --platform=$TARGETPLATFORM debian:bullseye-slim

ENV PREFIX=/usr/local/firebird
ENV VOLUME=/firebird
ENV DEBIAN_FRONTEND noninteractive
ENV DBPATH=/firebird/data

#VOLUME ["/firebird"]

EXPOSE 3050/tcp

COPY --from=build /home/firebird/firebird.tar.gz /home/firebird/firebird.tar.gz

COPY install.sh ./install.sh

RUN chmod +x ./install.sh && \
    sync && \
    ./install.sh && \
    rm -f ./install.sh

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y locales
RUN locale-gen C.UTF-8
RUN sed -i '/C.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen
ENV LANG C.UTF-8  
ENV LANGUAGE C.UTF-8  
ENV LC_ALL C.UTF-8   

# RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y locales
# RUN locale-gen pt_BR.UTF-8
# RUN sed -i '/pt_BR.UTF-8/s/^# //g' /etc/locale.gen && \
#     locale-gen
# ENV LANG pt_BR.UTF-8  
# ENV LANGUAGE pt_BR.UTF-8  
# ENV LC_ALL pt_BR.UTF-8   

COPY docker-entrypoint.sh ${PREFIX}/docker-entrypoint.sh
RUN chmod +x ${PREFIX}/docker-entrypoint.sh

COPY docker-healthcheck.sh ${PREFIX}/docker-healthcheck.sh
RUN chmod +x ${PREFIX}/docker-healthcheck.sh \
    && apt-get update \
    && apt-get -qy install netcat \
    && rm -rf /var/lib/apt/lists/*

HEALTHCHECK CMD ${PREFIX}/docker-healthcheck.sh || exit 1

ENTRYPOINT ["/usr/local/firebird/docker-entrypoint.sh"]

CMD ["firebird"]
