#!/bin/bash

# Prompt the user to enter a username or cancel the build
read -p "Enter a username for the Docker container: " username
if [ -z "$username" ]; then
  echo "Cancelling build..."
  exit 1
fi

echo $username > ./username.txt

# Get the group ID from the host's group `docker`
# this is so we can match the gid in the container to the host gid for permissions to match
DOCKER_GID=$(getent group docker | cut -d: -f3)
if [ -z "$DOCKER_GID" ]; then
  echo "Docker group not found. Exiting..."
  exit 1
fi

docker build --build-arg DOCKER_GID=$DOCKER_GID --build-arg USER_ACCT=$username -t supercontainer  .
