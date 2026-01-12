#!/bin/bash
set -eu -o pipefail

mkdir -p /tmp/apptmp

set -x

litestream restore -if-replica-exists -config /app/config/litestream.yml /app/db/production.sqlite3
bundle exec rails db:create db:migrate
litestream replicate -exec "$@" -config /app/config/litestream.yml
