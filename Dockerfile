FROM alpine
MAINTAINER Blagovest Petrov <blagovest@petrovs.info>

RUN apk --no-cache add tini bash curl openssl lighttpd \
    && curl -o /usr/local/bin/dehydrated https://raw.githubusercontent.com/lukas2511/dehydrated/master/dehydrated \
    && chmod +x /usr/local/bin/dehydrated

VOLUME ["/var/www/localhost/htdocs", "/var/dehydrated"]

COPY ./config /etc/dehydrated/config
COPY ./cron /etc/periodic/daily
COPY ./entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/sbin/tini", "--", "/entrypoint.sh"]

