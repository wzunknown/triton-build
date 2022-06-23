ROOT_DIR=/home/ubuntu/Triton
mkdir $ROOT_DIR


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

# build Triton
cd $ROOT_DIR
# get pin
wget http://software.intel.com/sites/landingpage/pintool/downloads/pin-2.14-71313-gcc.4.4.7-linux.tar.gz
tar xf pin-2.14-71313-gcc.4.4.7-linux.tar.gz
cd pin-2.14-71313-gcc.4.4.7-linux/source/tools/

git clone https://github.com/JonathanSalwan/Triton.git
ln -s `pwd`/Triton $ROOT_DIR/Triton-src
cd Triton
git checkout -b pin e84b8a0aaf8104d4e158140d4768660d3c8deb57

# patch CMakeLists.txt
sed -i '/PYTHON_VERSION_STRING/,+2d' CMakeLists.txt

mkdir build && cd build
cmake -DPINTOOL=on -DKERNEL4=on -DARCHITECTURE="amd64" -DPYTHON_BINDINGS=ON -DPYTHON_AUTOCOMPLETE=ON ..
make -j8
ln -s triton $ROOT_DIR/triton