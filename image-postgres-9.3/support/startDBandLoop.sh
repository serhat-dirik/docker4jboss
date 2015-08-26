#!/bin/bash

PGDATA=/var/lib/pgsql/9.3/data

/usr/pgsql-9.3/bin/pg_ctl start -D $PGDATA

#The routine below is written to keep the container alive
for (( ; ; ))
do
   sleep 10000
done
