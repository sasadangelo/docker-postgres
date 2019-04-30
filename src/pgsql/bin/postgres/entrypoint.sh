if [ $NODE_NAME = "pgmaster" ]
then
    echo ">>> CREATE DATA DIRECTORY ON MASTER NODE"
    su - postgres -c "/usr/lib/postgresql/9.3/bin/initdb -D /home/postgres/data/postgres"
    echo ">>> COPY CONFIGURATION FILES"
    su - postgres -c "cp /usr/local/bin/cluster/configs/postgresql.conf /home/postgres/data/postgres"
    su - postgres -c "cp /usr/local/bin/cluster/configs/pg_hba.conf /home/postgres/data/postgres"
    chown postgres:staff /home/postgres/data/postgres/postgresql.conf
    chown postgres:staff /home/postgres/data/postgres/pg_hba.conf
else
    echo ">>> $NODE_NAME IS WAITING MASTER IS UP AND RUNNING"
    while ! nc -z pgmaster 5432; do sleep 1; done;
    sleep 10
    echo ">>> REPLICATE DATA DIRECTORY ON SLAVE $NODE_NAME"
    su - postgres -c "/usr/lib/postgresql/9.3/bin/pg_basebackup -h 10.0.2.31 -p 5432 -U postgres -D /home/postgres/data/postgres -X stream -P"
    echo ">>> COPY recovery.conf ON SLAVE $NODE_NAME"
    su - postgres -c "cp /usr/local/bin/cluster/configs/recovery.conf /home/postgres/data/postgres"
    sed "s/NODE_NAME/$NODE_NAME/g"
fi
echo ">>> START POSTGRESQL ON NODE $NODE_NAME"
su - postgres -c "/usr/lib/postgresql/9.3/bin/postgres -D /home/postgres/data/postgres > /home/postgres/data/logs/postgres.log 2>&1"
