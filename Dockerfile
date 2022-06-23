FROM ubuntu:18.04

RUN apt-get update && apt-get install -y sudo
RUN adduser --disabled-password --gecos '' ubuntu && usermod -aG sudo ubuntu
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER ubuntu
WORKDIR /home/ubuntu

RUN sudo apt-get update && sudo apt-get install -y libc6 libstdc++6 linux-libc-dev g++ git vim python3-dev python-dev software-properties-common lsb-release
RUN sudo apt-get install -y ca-certificates wget
RUN sudo apt clean all


# latest cmake
# https://askubuntu.com/questions/355565/how-do-i-install-the-latest-version-of-cmake-from-the-command-line
RUN wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | sudo tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null && \
    sudo apt-add-repository "deb https://apt.kitware.com/ubuntu/ $(lsb_release -cs) main" && \
    sudo apt-get update && sudo apt install -y cmake-data=3.20.5-0kitware1 cmake=3.20.5-0kitware1

# libboost1.68
RUN sudo add-apt-repository -y ppa:mhier/libboost-latest && \
    sudo apt-get update && sudo apt -y install libboost1.68-dev

COPY --chown=ubuntu:ubuntu build.sh .
RUN chmod +x build.sh && ./build.sh