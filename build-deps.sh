ROOT_DIR=/home/ubuntu/Triton

# latest cmake
# https://askubuntu.com/questions/355565/how-do-i-install-the-latest-version-of-cmake-from-the-command-line
# wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | sudo tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null
# sudo apt-add-repository 'deb https://apt.kitware.com/ubuntu/ bionic main'
# sudo apt-get update
# sudo apt install cmake=3.20.5-0kitware1


# libboost1.68 from apt
# sudo add-apt-repository -y ppa:mhier/libboost-latest
# sudo apt install libboost1.68-dev

# build from source
# TODO


# build libcapstone
cd $ROOT_DIR
git clone https://github.com/libcapstone/libcapstone
cd libcapstone
git checkout -b 4.0.2 4.0.2
./make.sh
sudo ./make.sh install


# build libz3-4.8.6
cd $ROOT_DIR
git clone https://github.com/Z3Prover/z3
cd z3
git checkout -b z3-4.8.6 z3-4.8.6
mkdir build && cd build
cmake ..
make -j8
sudo make install