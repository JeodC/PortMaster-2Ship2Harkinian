# Building from source 2Ship2Harkinian

## Install WSL and chroot
1. 	Install wsl and ubuntu (use wsl2)
```
sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common qemu-user-static debootstrap
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=$(dpkg --print-architecture)] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt install docker-ce -y
sudo docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
sudo qemu-debootstrap --arch arm64 bookworm /mnt/data/arm64 http://deb.debian.org/debian/
```
Use bullseye instead of bookworm if building compatibility.

Note: The folder `/mnt/data/arm64` can be modified, for example to `/mnt/data/bookworm-arm64`. This is useful if you like to maintain multiple chroots.

## Enter chroot and install dependencies
```
sudo chroot /mnt/data/arm64/`
apt -y install wget gcc g++ git cmake ninja-build lsb-release libsdl2-dev libpng-dev libsdl2-net-dev libzip-dev zipcmp zipmerge ziptool nlohmann-json3-dev libtinyxml2-dev libspdlog-dev libboost-dev libopengl-dev libglew-dev
```

## Bullseye and older (newer cmake)
```
wget https://github.com/Kitware/CMake/releases/download/v3.24.4/cmake-3.24.4-linux-aarch64.sh
chmod +x cmake-3.24.4-linux-aarch64.sh
./cmake-3.24.4-linux-aarch64.sh --prefix=/usr
echo 'export PATH=/usr/cmake-3.24.4-linux-aarch64/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
```

\* You may need to build and install tinyxml2 from source

## Build 2Ship (Develop)
```
git clone https://github.com/HarbourMasters/2ship2harkinian.git
cd 2ship2harkinian
git submodule update --init
cmake -H. -B build-cmake -GNinja -DUSE_OPENGLES=1 -DCMAKE_BUILD_TYPE:STRING=Release
cmake --build build-cmake --config Release --target Generate2ShipOtr -j$(nproc)
cmake --build build-cmake --config Release -j$(nproc)
```

## Build 2Ship (Releases)
1.  `git clone https://github.com/HarbourMasters/2ship2harkinian.git`
2.  `cd 2ship2harkinian`
3.  `git checkout tags/1.0.0` -- Change this to whatever release tag you want to use
4.  `git submodule update --init`
5.  `cmake -H. -Bbuild-cmake -GNinja -DUSE_OPENGLES=1 -DCMAKE_BUILD_TYPE:STRING=Release`
6.  `cmake --build build-cmake --config Release --target Generate2ShipOtr -j$(nproc)`
7.  `cmake --build build-cmake --config Release -j$(nproc)`

## Retrieve the binaries
1.  `cd build-cmake/mm`
2.  `strip 2s2h.elf`
3.  `mv 2s2h.elf performance.elf` -- Or compatibility.elf if you built on bullseye.
4.  `mv 2s2h.o2r performance.o2r` -- Or compatibility.otr if you built on bullseye.
5.  Copy both files to `roms/ports/soh2/bin/`
