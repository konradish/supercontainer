HOMEDIR=/home/$(cat ./username.txt)
HOST_HOMEDIR=$(pwd)/home

docker run -v /var/run/docker.sock:/var/run/docker.sock -v $HOST_HOMEDIR:$HOMEDIR -it supercontainer
