#!/usr/bin/env bash
set -e

echo '>>> STARTING SSH (if required)...'
sshd_start

echo '>>> CONFIGURE POSTGRESQL ...'
/usr/local/bin/cluster/bin/postgres/entrypoint.sh & wait ${!}

EXIT_CODE=$?

while [ -f /var/run/recovery.lock ]; do
    sleep 1;
done;
echo ">>> POSTGRESQL TERMINATED WITH EXIT CODE: $EXIT_CODE"

exit $EXIT_CODE
