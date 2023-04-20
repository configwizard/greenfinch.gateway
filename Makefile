
WALLET=wallet.test.json
NGINX_CONFIG=nginx.conf

include .env
export

default:
	docker run --rm --name default -p 8000:80 -p 8080:8080 -p 8083:8083 \
	-v "$(shell pwd)/$(NGINX_CONFIG)":/etc/nginx/conf.d/default.conf:ro \
	-v "$(shell pwd)/$(WALLET)":/wallet.test.json:ro \
	-v "$(shell pwd)"/config.yaml:/config.yaml:ro greenfinch-gateway

exec:
	echo $(HTTP_GW_WALLET_PATH)
	docker exec -it default sh

build:
	docker build -t greenfinch-gateway .

