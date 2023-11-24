#!/bin/bash

REPOS_NAME=${1:-'localhost'}
VERSION=${2:-'1.0.0'}
PORT=${3:-80}

sed -i "s/listen 80;/listen ${PORT};/" nginx.conf
sed -i "s/EXPOSE 80/EXPOSE ${PORT}/" Dockerfile
sed -i "s/\(REACT_APP_VERSION = v\)[^ ]*/\1${VERSION}/" .env

docker build -t ${REPOS_NAME}/react-admin-web:${VERSION} .