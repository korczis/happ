#! /usr/bin/env sh

docker run --name postgis -p 5432:5432 -e POSTGRES_PASSWORD=postgres -d postgis/postgis
