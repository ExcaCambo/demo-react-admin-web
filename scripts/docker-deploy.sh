#!/bin/bash
VERSION=${1:-'1.0.0'}

composeFile='docker-compose.yaml'
sed -i "s|/react-admin-web:latest|/react-admin-web:${VERSION}|" ${composeFile}
# docker rm -f react-admin-web
docker compose -f ${composeFile} up -d --force-recreate