#!/bin/bash

# Update the package repository and upgrade packages
sudo yum update -y

# Install Docker using Amazon Linux extras
sudo yum  install docker -y

# Start and enable Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Add ec2-user to the docker group to run docker commands without sudo
sudo groupadd docker
sudo usermod -aG docker ec2-user
groups $USER
sudo chmod 666 /var/run/docker.sock

# Install Docker Compose
DOCKER_COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | jq -r .tag_name)
sudo curl -L "https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# Apply executable permissions to the Docker Compose binary
sudo chmod +x /usr/local/bin/docker-compose

# Verify installation
docker --version
docker-compose --version


sudo yum install -y git

#https://github.com/bjnandi/containerize-full-stack-app-MERN-with-docker-compose
#https://github.com/bjnandi/containerize-full-stack-app-MERN-with-docker-compose

sudo yum install -y nodejs npm


sudo docker pull scalyr/scalyr-agent-docker-json


JSON_CONTENT=$(cat <<EOF
{
  "api_key": "0p9_cscHLqf402lnUD1zgsOwbIkG4TqWv2bzKDrr3YPE-"
}
EOF
)

echo "$JSON_CONTENT" > /tmp/api_key.json

echo "API key has been written to /tmp/api_key.json"


sudo docker run -d --name scalyr-docker-agent       -v /tmp/api_key.json:/etc/scalyr-agent-2/agent.d/api_key.json       -v /var/run/docker.sock:/var/scalyr/docker.sock       -v /var/lib/docker/containers:/var/lib/docker/containers       scalyr/scalyr-agent-docker-json


#0p9_cscHLqf402lnUD1zgsOwbIkG4TqWv2bzKDrr3YPE-

git clone https://github.com/sdcilsy/mern-todo-app

cd mern-todo-app

docker-compose up --build