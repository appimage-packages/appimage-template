#!/bin/bash

# # Various external Qt relelated modules addons
cd $SOURCES && git clone git://code.qt.io/qt/qtdeclarative.git && cd $SOURCES/qtdeclarative && git checkout 5.9 && \
cd $SOURCES/qtdeclarative &&  qmake PREFIX=/opt/usr . && make && make install && rm -rfv $SOURCES/qtdeclarative
cd $SOURCES && git clone http://code.qt.io/qt/qtstyleplugins.git && \
cd $SOURCES/qtstyleplugins && qmake PREFIX=/opt/usr . && make && make install && rm -rfv $SOURCES/qtstyleplugins
cd $SOURCES && git clone https://code.qt.io/cgit/qt/qtquick1.git && \
cd $SOURCES/qtquick1 && qmake PREFIX=/opt/usr . && make && make install && rm -rfv $SOURCES/qtquick1
cd $SOURCES && git clone https://github.com/flavio/qjson && \
cd $SOURCES/qjson &&  cmake -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX:PATH=/opt/usr && make && make install && rm -rfv $SOURCES/qjson
cd $SOURCES && wget 'https://gstreamer.freedesktop.org/src/qt-gstreamer/qt-gstreamer-1.2.0.tar.xz' && tar -xvf qt-gstreamer-1.2.0.tar.xz && \
cd $SOURCES/qt-gstreamer-1.2.0 &&  cmake -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX:PATH=/opt/usr -DQT_VERSION=5 -DCMAKE_REQUIRED_INCLUDES=/opt/usr/include/gstreamer-1.0/ \
-DQTGSTREAMER_STATIC=OFF -DQTGSTREAMER_EXAMPLES=OFF && make && make install && rm $SOURCES/qt-gstreamer-1.2.0.tar.xz && rm -rfv $SOURCES/qt-gstreamer-1.2.0
# RUN cd $SOURCES && wget https://www.riverbankcomputing.com/static/Downloads/PyQt5/PyQt5_gpl-5.8.3.dev1704051437.tar.gz && tar -zxvf PyQt5_gpl-5.8.3.dev1704051437.tar.gz && \
# cd $SOURCES/PyQt5_gpl-5.8.3.dev1704051437 && /opt/usr/bin/python3 configure.py --confirm-license --verbose --destdir /opt/usr --sip /opt/usr/bin/sip --sip-incdir /opt/usr/include/python3.5/ \
# -q /opt/usr/bin/qmake -c -j 4 LIBDIR_QT=/opt/usr/lib STRIP="" MOC=/usr/bin/moc --qmake="/opt/usr/bin/qmake" \
# LIBS_OPENGL="" LIBS_X11="" LIBS_THREAD="" -m /opt/usr/lib/python3.5/config-3.5m \
# -d /opt/usr/lib/python3.5/dist-packages	--dbus /usr/include/dbus-1.0 --no-designer-plugin --no-qml-plugin && make -j8 && make install && \
# rm -rfv $SOURCES/PyQt5_gpl-5.8.3.dev1704051437 && rm $SOURCES/PyQt5_gpl-5.8.3.dev1704051437.tar.gz && rm $SOURCES/sip-4.19.1.tar.gz && rm -rfv $SOURCES/sip-4.19.1
cd $SOURCES && wget http://download.kde.org/stable/qca/2.1.1/src/qca-2.1.1.tar.xz && tar -xvf qca-2.1.1.tar.xz && \
cd $SOURCES/qca-2.1.1 && mkdir build && cd build && cmake -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX:PATH=/opt/usr .. && cmake --build . && cmake --build . --target install && \
rm $SOURCES/qca-2.1.1.tar.xz && rm -rfv $SOURCES/qca-2.1.1
RUN cd $SOURCES && git clone https://github.com/ayoy/qoauth && \
cd $SOURCES/qoauth && sed s#/usr#/opt/usr# -i src/src.pro  && sed s#/lib64#/lib# -i src/src.pro&& qmake ' "QT += widgets" "QT += webkitwidgets" "CONFIG += crypto" "DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x000000"' src/src.pro \
&& make -j8 && make install && rm -rfv $SOURCES/qoauth
cd $SOURCES && svn export svn://svn.code.sf.net/p/qwt/code/branches/qwt-6.1 && cd $SOURCES/qwt-6.1 && qmake -set prefix '/opt' && qmake qwt.pro && \
make -j8 && INSTALL_ROOT=/opt make install && rm -rfv $SOURCES/qwt-6.1 && \
mv /opt/usr/local/qwt-6.1.4-svn/include/* /opt/usr/include/ && \
mv /opt/usr/local/qwt-6.1.4-svn/lib/* /opt/usr/lib/ && \
mv /opt/usr/local/qwt-6.1.4-svn/plugins/designer/* /opt/usr/plugins/designer/ && rmdir /opt/usr/local/qwt-6.1.4-svn/plugins/designer
cd $SOURCES && git clone https://github.com/steveire/grantlee && \
cd $SOURCES/grantlee && mkdir build && cd build && cmake -DCMAKE_INSTALL_PREFIX:PATH=/opt/usr CMAKE_BUILD_TYPE=Release .. && cmake --build . && cmake --build . --target install \
&& rm -rfv $SOURCES/grantlee
cd $SOURCES && wget https://poppler.freedesktop.org/poppler-0.51.0.tar.xz && tar -xvf poppler-0.51.0.tar.xz && \
cd $SOURCES/poppler-0.51.0 && mkdir build && cd build && ../configure --prefix=/opt/usr -sysconfdir=/opt/etc --disable-static --enable-build-type=release \
--enable-cmyk --enable-xpdf-headers --enable-poppler-qt5 && make && make install && rm $SOURCES/poppler-0.51.0.tar.xz && rm -rfv $SOURCES/poppler-0.51.0
wget https://www.gnupg.org/ftp/gcrypt/gnupg/gnupg-2.1.17.tar.bz2 && tar -jxvf gnupg-2.1.17.tar.bz2
cd gnupg-2.1.17 && autoreconf --force --install && mkdir builddir && cd builddir && ../configure --prefix=/opt/usr &&  make -j 8 && make install && rm /gnupg-2.1.17.tar.bz2 && rm -rfv /gnupg-2.1.17
