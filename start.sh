#!/bin/bash

if [ -f .env ];
then
    source .env
    docker-compose up -d
else
    echo "Please copy .env.sample to .env"
fi
