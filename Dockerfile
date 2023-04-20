FROM golang:1.19-alpine as basebuilder
RUN apk add --update make bash ca-certificates

FROM basebuilder as builder
ENV GOGC off
ENV CGO_ENABLED 0
RUN go install github.com/nspcc-dev/neofs-http-gw@latest
RUN which neofs-http-gw

# Executable image
FROM openresty/openresty:alpine-fat

# Install gettext for envsubst
RUN apk add --no-cache gettext


RUN apk add --no-cache luarocks
RUN luarocks install lua-resty-http && \
    luarocks install lua-cjson

WORKDIR /

COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /go/bin/neofs-http-gw /bin/neofs-http-gw
COPY ./start.sh /start.sh
COPY ./openresty.conf /usr/local/openresty/nginx/conf/nginx.conf
COPY ./proxy.nginx.conf /default.template.conf

RUN mkdir -p /var/log/nginx
RUN chmod -R 755 /var/log/nginx

RUN chmod +x /bin/neofs-http-gw
RUN chmod +x /start.sh

ENTRYPOINT /start.sh
