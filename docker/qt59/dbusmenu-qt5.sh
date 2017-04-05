#!/bin/bash

cd $SOURCES && bzr branch lp:libdbusmenu-qt && cd $SOURCES/libdbusmenu-qt && \
cmake -DCMAKE_INSTALL_PREFIX:PATH=/opt/usr -DCMAKE_BUILD_TYPE=Debug  -DWITH_DOC=OFF -DUSE_QT5=ON && make VERBOSE=1 && make install && rm -rfv $SOURCES/libdbusmenu-qt
