#!/bin/sh


envsubst < /default.template.conf > /etc/nginx/conf.d/default.conf

nginx -c /etc/nginx/nginx.conf
#start the gateway
/bin/neofs-http-gw --config /etc/secrets/config.yaml

