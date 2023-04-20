FROM golang:1.19-alpine as basebuilder
RUN apk add --update make bash ca-certificates

FROM basebuilder as builder
ENV GOGC off
ENV CGO_ENABLED 0
RUN go install github.com/nspcc-dev/neofs-http-gw@latest
RUN which neofs-http-gw

# Executable image
FROM nginx

WORKDIR /

COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /go/bin/neofs-http-gw /bin/neofs-http-gw
COPY ./start.sh /start.sh
COPY ./proxy.nginx.conf /default.template.conf

RUN chmod +x /bin/neofs-http-gw

RUN chmod +x /start.sh

ENTRYPOINT /start.sh
