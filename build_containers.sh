# PostgreSQL node names
NODE1_NAME=node1
NODE2_NAME=node2
NODE3_NAME=node3

# PostgreSQL volumes
NODE1_VOLUME=volume1
NODE2_VOLUME=volume2
NODE3_VOLUME=volume3

# Nodes private ips
NODE1_PRIVATE_IP=10.0.2.31
NODE2_PRIVATE_IP=10.0.2.32
NODE3_PRIVATE_IP=10.0.2.33

# Nodes private network name
PRIVATE_NETWORK_NAME=node_private_bridge

# Nodes SSH port mapping
NODE1_SSH_PORT=4441
NODE2_SSH_PORT=4442
NODE3_SSH_PORT=4443

# Create a private network
docker network create -d bridge --gateway=10.0.2.1 --subnet=10.0.2.1/24 ${PRIVATE_NETWORK_NAME}

# Create the three volumes for the data directory of each PostgreSQL node
docker volume create ${NODE1_VOLUME}
docker volume create ${NODE2_VOLUME}
docker volume create ${NODE3_VOLUME}

# Create the PostgreSQL containers and start them
docker create -it --net ${PRIVATE_NETWORK_NAME} --ip ${NODE1_PRIVATE_IP} --hostname ${NODE1_NAME} --name ${NODE1_NAME} --publish ${NODE1_SSH_PORT}:22 -v ${NODE1_VOLUME}:/home/postgres/data postgresql /bin/bash
docker create -it --net ${PRIVATE_NETWORK_NAME} --ip ${NODE2_PRIVATE_IP} --hostname ${NODE2_NAME} --name ${NODE2_NAME} --publish ${NODE2_SSH_PORT}:22 -v ${NODE2_VOLUME}:/home/postgres/data postgresql /bin/bash
docker create -it --net ${PRIVATE_NETWORK_NAME} --ip ${NODE3_PRIVATE_IP} --hostname ${NODE3_NAME} --name ${NODE3_NAME} --publish ${NODE3_SSH_PORT}:22 -v ${NODE3_VOLUME}:/home/postgres/data postgresql /bin/bash
docker start ${NODE1_NAME}
docker start ${NODE2_NAME}
docker start ${NODE3_NAME}
