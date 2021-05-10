#! /usr/bin/env sh

#export MIX_ENV="prod"
#export SECRET_KEY_BASE="/st6IOeQcfRQlVeAhvPTQM3pRJOgQTDBkIoqshpep2hfKJxVAKh29p4cK0wX+A7v"
#export DATABASE_URL="ecto://postgres:postgres@localhost:5432/happ_prod"

source .env.sh

echo "Digesting assets"
mix phx.digest

echo "Creating release"
mix distillery.release --env=$MIX_ENV
