#!/bin/bash
VERSION=${1:-'1.0.0'}
appName='react-admin-web'
composeFile='docker-compose.yaml'
sed -i "s|/react-admin-web:latest|/${appName}:${VERSION}|" ${composeFile}

containerId=$(docker ps --all | grep "${appName}" | awk {'print $1'})
if [ "$containerId" ]; then
  docker rm -f $containerId
fi
docker compose -f ${composeFile} up -d --force-recreate