# Private and Public keys injected in nodes in ~/.ssh/ folder in order to
# access to the nodes from the development machine and also to navigate among them
# simply typing "ssh <node name>"
PRIVATE_KEY=$(cat ~/.ssh/id_rsa_docker)
PUBLIC_KEY=$(cat ~/.ssh/id_rsa_docker.pub)

# Create the PostgreSQL image.
docker build -t postgresql --build-arg ssh_prv_key="$PRIVATE_KEY" --build-arg ssh_pub_key="$PUBLIC_KEY" .
