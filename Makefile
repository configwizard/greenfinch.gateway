
include .env
export

default:
	docker run --rm --name default -p 8000:8000 -p 8080:8080 -p 8083:8083 \
	--env-file .env \
	-v "$(shell pwd)/wallet.test.json":/etc/secrets/wallet.json:ro \
	-v "$(shell pwd)/config.yaml":/etc/secrets/config.yaml:ro greenfinch-gateway

exec:
	docker exec -it default sh

build:
	docker build -t greenfinch-gateway .

curl:
	http://localhost:8080/$(DEFAULT_CONTAINER_ID)/$(OID)
