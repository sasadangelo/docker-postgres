# Download base image ubuntu 14.04.
FROM ubuntu:14.04

# Update Ubuntu Software repository. This is required to install packages.
# Install the following packages:
#     openssh-server is required to access nodes via ssh
RUN apt-get update && apt-get install -y openssh-server postgresql

# Create .ssh folder in /root folder in order to install SSH Keys
# that will be used to:
# 1. connect to the three machines from the development machine
# Private key is copied in /root/.ssh/id_rsa
# Public key is copied in /root/.ssh/id_rsa.pub and will be part of 
# authorized_keys
# These keys will be used to access to nodes from the development machine
# without any password and to navigate from one machine to another simply typing
# "ssh <node name>".
RUN mkdir -p /root/.ssh && \
	chmod 0700 /root/.ssh
COPY ssh/* /root/.ssh/
RUN mv /root/.ssh/sshd_start /usr/local/bin/sshd_start && chmod +x /usr/local/bin/sshd_start

RUN chmod 600 /root/.ssh/* && \
	env=~/.ssh/agent.env && \
	umask 077 && \
	ssh-agent > "$env" && \
	. "$env" && \
	ssh-add ~/.ssh/id_rsa

# Create the folder for data directory
RUN mkdir -p /home/postgres/data/postgres && \
	mkdir -p /home/postgres/data/logs && \
	chown -R postgres:staff /home/postgres/ && \
	chmod -R 700 /home/postgres/data

RUN mkdir -p /usr/local/bin/cluster
COPY ./pgsql /usr/local/bin/cluster

# Use bash as extry point and expose on target host the port 5432 where
# PostgreSQL server will listen.
#ENTRYPOINT service ssh start && /bin/bash
EXPOSE 22
#CMD ["/usr/local/bin/cluster/bin/entrypoint.sh"]
ENTRYPOINT /usr/local/bin/cluster/bin/entrypoint.sh && /bin/bash
