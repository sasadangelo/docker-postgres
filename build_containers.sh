# PostgreSQL node name
NODE1_NAME=node1

# Create the PostgreSQL container and start it
docker create -it --name ${NODE1_NAME} --publish 5432:5432 postgresql /bin/bash
docker start ${NODE1_NAME}
