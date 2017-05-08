#!/bin/bash

export CFLAGS=$(pkg-config --cflags gstreamer-1.0) $CFLAGS
export LDFLAGS=$(pkg-config --libs gstreamer-1.0) $LDFLAGS

cd /source && git clone git://code.qt.io/qt/qt5.git && cd qt5 && git checkout 5.9
git fetch https://codereview.qt-project.org/qt/qt5 refs/changes/44/189744/2 && git format-patch -1 --stdout FETCH_HEAD > init.patch
patch -p1 < init.patch
perl init-repository --module-subset=default,-qtmacextras,-qtwinextras,-qtwebkit-examples,-qtandroidextras
cd /source/qt5 && ./configure -v -release -opensource -nomake examples -nomake tests -confirm-license -opengl desktop -reduce-exports -prefix /opt/usr && make  -j8 && make install && rm -rfv $SOURCES/qt5
rm -rfv /source/qt5
git clone http://code.qt.io/qt/qtwebkit.git && cd qtwebkit && git checkout 5.9 && \
rbenv local 2.3.1 && echo "CONFIG -= precompile_header" >> .qmake.conf && echo "QMAKE_CFLAGS_ISYSTEM=''" >> .qmake.conf && qmake "PREFIX = /opt/usr" WebKit.pro && \
make && make install && rm -rfv /source/qtwebkit
