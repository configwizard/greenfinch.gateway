#!/bin/sh

nginx -c /etc/secrets/nginx.conf

#start the gateway
/bin/neofs-http-gw --config /etc/secrets/config.yaml

