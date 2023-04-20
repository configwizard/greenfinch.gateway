
WALLET=wallet.test.json
NGINX_CONFIG=nginx.conf

include .env
export

default:
	docker run --rm --name default -p 8000:8000 -p 8080:8080 -p 8083:8083 \
	-v "$(shell pwd)/$(NGINX_CONFIG)":/etc/secrets/nginx.conf:ro \
	-v "$(shell pwd)/$(WALLET)":/etc/secrets/wallet.test.json:ro \
	-v "$(shell pwd)/config.yaml":/etc/secrets/config.yaml:ro greenfinch-gateway

exec:
	echo $(HTTP_GW_WALLET_PATH)
	docker exec -it default sh

build:
	docker build -t greenfinch-gateway .
