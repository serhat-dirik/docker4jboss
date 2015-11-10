#!/bin/bash
PGDATA="/var/lib/pgsql/9.3/data"
export PGPASSWORD=postgres
#Start postgres
/usr/pgsql-9.3/bin/pg_ctl -w start -D $PGDATA
/usr/pgsql-9.3/bin/psql --command "CREATE USER jboss WITH SUPERUSER PASSWORD 'jboss';"
/usr/pgsql-9.3/bin/psql --command "CREATE DATABASE jboss WITH OWNER jboss;"
/usr/pgsql-9.3/bin/psql -a -f /tmp/postgresConfig/demo/financials-psql.sql

#The routine below is written to keep the container alive
for (( ; ; ))
do
   sleep 10000
done
