

docker build . -t react-admin

docker tag react-admin:latest registry.digitalocean.com/narith-registry/react-admin-web

docker push registry.digitalocean.com/narith-registry/react-admin-web

docker compose up 99

