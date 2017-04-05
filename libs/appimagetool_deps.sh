#!/bin/bash

#Appstream support for appimagetool
wget http://ftp.gnome.org/pub/gnome/sources/gobject-introspection/1.46/gobject-introspection-1.46.0.tar.xz && tar -xvf gobject-introspection-1.46.0.tar.xz
cd gobject-introspection-1.46.0 && ./configure --prefix=/opt/usr --enable-shared --enable-static &&  make -j 8 && make install && rm /gobject-introspection-1.46.0.tar.xz && rm -rfv /gobject-introspection-1.46.0

sudo add-apt-repository -y ppa:jonathonf/gtk3.18 && sudo apt-get update && sudo apt-get -y install libglib2.0-dev && add-apt-repository -y -r ppa:jonathonf/gtk3.18

git clone https://github.com/ximion/appstream
cd appstream && mkdir build && cd build && cmake -DCMAKE_INSTALL_PREFIX:PATH=/opt/usr -DQT=ON ../ && make && make install && rm -rfv /appstream

wget https://www.gnupg.org/ftp/gcrypt/gnupg/gnupg-2.1.17.tar.bz2 && tar -jxvf gnupg-2.1.17.tar.bz2
cd gnupg-2.1.17 && autoreconf --force --install && mkdir builddir && cd builddir && ../configure --prefix=/opt/usr &&  make -j 8 && make install && rm /gnupg-2.1.17.tar.bz2 && rm -rfv /gnupg-2.1.17
