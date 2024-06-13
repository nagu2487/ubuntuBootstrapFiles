#!/bin/bash

sudo usermod -aG docker $USER


sudo docker pull scalyr/scalyr-agent-docker-json

API_KEY=$1

JSON_CONTENT=$(cat <<EOF
{
  "api_key": "$API_KEY"
}
EOF
)

echo "$JSON_CONTENT" > /tmp/api_key.json

echo "API key has been written to /tmp/api_key.json"


sudo docker run -d --name scalyr-docker-agent       -v /tmp/api_key.json:/etc/scalyr-agent-2/agent.d/api_key.json       -v /var/run/docker.sock:/var/scalyr/docker.sock       -v /var/lib/docker/containers:/var/lib/docker/containers       scalyr/scalyr-agent-docker-json


#0p9_cscHLqf402lnUD1zgsOwbIkG4TqWv2bzKDrr3YPE-