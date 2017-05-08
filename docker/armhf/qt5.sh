#!/bin/bash

export CFLAGS=$(pkg-config --cflags gstreamer-1.0) $CFLAGS
export LDFLAGS=$(pkg-config --libs gstreamer-1.0) $LDFLAGS

cd /source && git clone git://code.qt.io/qt/qt5.git && cd qt5 && git checkout 5.9
git fetch https://codereview.qt-project.org/qt/qt5 refs/changes/44/189744/2 && git format-patch -1 --stdout FETCH_HEAD > init.patch
patch -p1 < init.patch
perl init-repository --module-subset=default,-qtmacextras,-qtwinextras,-qtwebkit-examples,-qtandroidextras
cd /source/qt5 && ./configure -v -developer-build -opensource -nomake examples -nomake tests -confirm-license -opengl desktop -reduce-exports -prefix /opt/usr && make  -j8 && make install && rm -rfv $SOURCES/qt5
rm -rfv /source/qt5
