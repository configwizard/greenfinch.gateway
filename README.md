![logo.png](https://greenfinch-gateway.onrender.com/87JeshQhXKBw36nULzpLpyn34Mhv1kGCccYyHU2BqGpT/logo.png)

# Greenfinch HTTP Gateway

This is based on the [NSPCC's HTTP Gateway](https://github.com/nspcc-dev/neofs-http-gw).

In essence this offers an HTTP service to access assets on NeoFS as a browser cannot directly make GRPC requests.

This wraps the above plus NGINX and NGINX configuration into a docker image to ease the journey towards hosting your own Gateway into NeoFS, further enabling the decentralised web.

It is important to point out that by hosting this and using it you are in effect removing the decentralised aspect. Therefore it is important to remember that any asset that is available on NeoFS can always be accessed directly, using [Greenfinch.app](https://www.greenfinch.app). 

This should be everything needed to get started, all you need to do is have docker installed and a few environment variables set.

The default port for this service is [8000](http://localhost:8000).

## Further information

This uses the openResty version of NGINX, allowing Lua scripts to be written and used as middleware/plugins on the NGINX endpoints. A hello world example of doing this would be

```nginx
 location /hello {
         default_type 'text/plain';
         content_by_lua_block {
             ngx.say('Hello,world!')
         }
     }
```
This will respond with the text `Hello,world` when the user navigates to the `/hello` endpoint. Note that Lua scripts can be used in conjunction with any other NGINX capabilities within a location block and can be run on the request or on the response, however writing Lua scripts for NGINX is outside of the scope of this document.

Environment variables can be placed within the `proxy.nginx.conf` file as when the container is started (see `start.sh`) `envsubst` will replace the templated placeholders with their values. An example of doing so can be seen on the rewrites within the proxy.nginx.conf file, e.g

```nginx
rewrite '^/assets/(.+)$' /get_by_attribute/${DEFAULT_CONTAINER_ID}/FilePath/$1
```
here, `${DEFAULT_CONTAINER_ID}` will be replaced with the environment variable value for `DEFAULT_CONTAINER_ID`


The config.yaml file configures the Gateway accessing NeoFS. This should not need to be changed, however if you do have need to, you can set the values in here, or as environment variables. See `.env.gateway.example` for an exhaustive list of configuration options.

`make` is used to manage building and running the image.

When you navigate to the route, the default is to serve an index.html file. This would need to have been already uploaded to your container.

## Prerequisites

Copy `.localenv.example` to `.env` and fill in the environment variables


## Building the container

`make build`

```
docker build -t greenfinch-gateway .
```

### Executing Shell into the container

`make exec`

```
docker exec -it default sh
```

### Running it directly

`make`

```
docker run --rm --name default -p 8000:8000 -p 8080:8080 -p 8083:8083 \
	--env-file .env \
	-v $(shell pwd)/scripts:/scripts \
	-v "$(shell pwd)/wallet.test.json":/etc/secrets/wallet.json:ro \
	-v "$(shell pwd)/config.yaml":/etc/secrets/config.yaml:ro greenfinch-gateway
```

### Endpoints

Its easiest to see whats available by checking the proxy.nginx.conf file

### Notes

To access 'filepaths' for files. They will need the attribute `FilePath`, e.g `FilePath=styles/styles.css` if you want to suggest a path to the file
