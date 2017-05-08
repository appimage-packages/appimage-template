#!/bin/bash
add-apt-repository -y ppa:jonathonf/gtk3.18 && sudo apt-get update && sudo apt-get -y install libglib2.0-dev && add-apt-repository -y -r ppa:jonathonf/gtk3.18
git clone https://github.com/ximion/appstream
cd appstream && mkdir build && cd build && cmake -DCMAKE_INSTALL_PREFIX:PATH=/opt/usr -DQT=ON ../ && make && make install && rm -rfv /appstream
