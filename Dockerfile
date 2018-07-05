# Download base image ubuntu 14.04.
FROM ubuntu:14.04

ARG ssh_prv_key
ARG ssh_pub_key

# Update Ubuntu Software repository. This is required to install packages.
# Install the following packages:
#     openssh-server is required to access nodes via ssh
RUN apt-get update && apt-get install -y openssh-server

# Create .ssh folder in /root folder in order to install SSH Keys
# that will be used to:
# 1. connect to the five machines from the development machine
# Private key is copied in /root/.ssh/id_rsa
# Public key is copied in /root/.ssh/id_rsa.pub and will be part of authorized_keys
# These keys will be used to access to nodes from the development machine
# without any password and to navigate from one machine to another simply typing
# "ssh <node name>".
RUN mkdir -p /root/.ssh && \
	chmod 0700 /root/.ssh && \
	ssh-keyscan github.ibm.com > /root/.ssh/known_hosts
RUN echo "$ssh_prv_key" > /root/.ssh/id_rsa && \
	echo "$ssh_pub_key" > /root/.ssh/id_rsa.pub && \
	echo "$ssh_pub_key" > /root/.ssh/authorized_keys && \
	chmod 600 /root/.ssh/id_rsa && \
	chmod 600 /root/.ssh/id_rsa.pub && \
	chmod 600 /root/.ssh/authorized_keys
RUN env=~/.ssh/agent.env; umask 077; ssh-agent > "$env"; . "$env"; ssh-add ~/.ssh/id_rsa

# Use bash as extry point and expose on target host the port 5432 where
# PostgreSQL server will listen.
ENTRYPOINT service ssh start && /bin/bash
EXPOSE 22
