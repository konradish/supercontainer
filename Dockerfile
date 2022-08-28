FROM debian
# grep docker /etc/group | cut -d: -f3
# Set the docker_gid to the above value
ARG DOCKER_GID
ARG USER_ACCT
ENV USER_ACCT=$USER_ACCT
RUN apt update && apt install -y openssl sudo git
RUN adduser --disabled-password --gecos '' ${USER_ACCT}
RUN adduser ${USER_ACCT} sudo
# Add group docker and add ${USER_ACCT} to it
RUN sudo groupadd -g ${DOCKER_GID} docker && sudo usermod -aG docker ${USER_ACCT}
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER ${USER_ACCT}
WORKDIR /home/${USER_ACCT}
RUN git clone https://github.com/konradish/scripts && cd scripts && ./setup_env.sh install_software && ./setup_env.sh install_gh && ./setup_env.sh install_zsh
RUN sudo ./scripts/install_docker.sh
ENTRYPOINT /home/$USER_ACCT/startup.sh

# To run the container with access to Docker daemon:
# docker run -v /var/run/docker.sock:/var/run/docker.sock -it supercontainer