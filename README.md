# Configuring Greenfinch HTTP Gateway

## Building the container

`make build`

```
docker build -t greenfinch-gateway .
```

### Executing Shell into the container

`make exec`

```
docker run -it -p 8080:8080 -p 8083:8083 -v "$(pwd)"/wallet.test.json:/wallet.test.json:ro -v "$(pwd)"/config.yaml:/config.yaml:ro greenfinch-gateway sh
```

### Running it directly

`make`

```
docker run -it -p 8080:8080 -p 8083:8083 -v "$(pwd)"/wallet.test.json:/wallet.test.json:ro -v "$(pwd)"/config.yaml:/config.yaml:ro greenfinch-gateway
```

### Endpoints

Direct

```
/upload/{cid}
/get/{cid}/{oid}
/get_by_attribute/{cid}/{attr_key}/{attr_val:*}
/zip/{cid}/{prefix}
/ (takes you to a default container's index.html file)
/{cid} (takes you to the index.html of that container)
/{dir}/{dir}/filename.ext (takes you to the default container's filename with that #filepath attribute - see notes.)
```

### Notes

To access 'filepaths' for files. They will need the attribute `FilePath`, e.g `FilePath=styles/styles.css` if you want to suggest a path to the file
