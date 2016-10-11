#!/bin/bash

if [ -f .env ];
then
    set -a
    source .env
    docker-compose up -d
else
    echo "Please copy .env.sample to .env"
fi
