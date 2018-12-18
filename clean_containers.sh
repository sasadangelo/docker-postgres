# PostgreSQL node names
NODE1_NAME=node1
NODE2_NAME=node2
NODE3_NAME=node3

# Docker volumes
NODE1_VOLUME=volume1
NODE2_VOLUME=volume2
NODE3_VOLUME=volume3


# Nodes private network name
PRIVATE_NETWORK_NAME=node_private_bridge

# Stop the nodes and drop them
docker stop ${NODE1_NAME}
docker stop ${NODE2_NAME}
docker stop ${NODE3_NAME}
docker rm ${NODE1_NAME}
docker rm ${NODE2_NAME}
docker rm ${NODE3_NAME}
docker volume rm ${NODE1_VOLUME}
docker volume rm ${NODE2_VOLUME}
docker volume rm ${NODE3_VOLUME}
docker network rm ${PRIVATE_NETWORK_NAME}
