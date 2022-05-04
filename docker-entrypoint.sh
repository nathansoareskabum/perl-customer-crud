#!/bin/sh

#
# Aguarda o container de MySQL subir totalmente os serviços antes de prosseguir
#

while ! mysql -u $DATABASE_USER -p$DATABASE_PASS -h $DATABASE_HOST -P $DATABASE_PORT  -e ";" ; do
  echo "Awaiting mysql - sleeping"
  sleep 1
done

perl /app/src/scripts/setup_dabase.pl

exec "$@"