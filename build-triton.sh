ROOT_DIR=/home/ubuntu/Triton

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
ln -s `pwd`/triton $ROOT_DIR/triton