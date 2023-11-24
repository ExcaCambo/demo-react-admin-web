#!/bin/bash
REGISTRY=${1:-'localhost'}
VERSION=${2:-'1.0.0'}
docker push ${REGISTRY}/react-admin-web:${VERSION}