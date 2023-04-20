#!/bin/sh

nginx -c /etc/nginx/nginx.conf

#start the gateway
/bin/neofs-http-gw --config /config.yaml

