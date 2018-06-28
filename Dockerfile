# Download base image ubuntu 14.04.
FROM ubuntu:14.04

# Use bash as extry point and expose on target host the port 5432 where
# PostgreSQL server will listen.
ENTRYPOINT /bin/bash
EXPOSE 5432
