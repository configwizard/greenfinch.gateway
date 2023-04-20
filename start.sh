#!/bin/sh


envsubst < /default.template.conf > /etc/nginx/conf.d/default.conf

nginx -c /usr/local/openresty/nginx/conf/nginx.conf
#start the gateway
/bin/neofs-http-gw --config /etc/secrets/config.yaml

