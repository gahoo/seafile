# Seafile Server 8.0.7 for Raspberry Pi
Docker images for Raspberry Pi.

## Build
```bash
docker build -t seafile:8.0.7 .
```

## Quick Start
```bash
docker run --rm -it -p 8000:8000 -p 8080:8080 -p 8082:8082 seafile:8.0.7
```

## Enviroments defaults
- SERVICE_URL: http://127.0.0.1:8000
- HUB_PORT: 8000, must be the same as above
- WEBDAV_HOST: 0.0.0.0 \
- WEBDAV_PORT: 8080 \
- FILESERVER_PORT: 8082 \

```bash
docker run -d \
    -e SERVICE_URL=http://127.0.0.1:8500 \
    -e HUB_PORT=8500 \
    -e WEBDAV_HOST=127.0.0.1 \
    -e WEBDAV_PORT=8081 \
    -e FILESERVER_PORT=8082 \
    -p 8500:8500 \
    -p 8081:8081 \
    -p 8082:8082 \
    seafile:8.0.7
```


