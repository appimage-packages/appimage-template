FROM ubuntu:14.04
RUN echo "deb-src http://us.archive.ubuntu.com/ubuntu/ trusty main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb-src http://ca.archive.ubuntu.com/ubuntu/ trusty main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://ca.archive.ubuntu.com/ubuntu/ trusty-updates main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb-src http://ca.archive.ubuntu.com/ubuntu/ trusty-updates main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://us.archive.ubuntu.com/ubuntu/ trusty-backports main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb-src http://us.archive.ubuntu.com/ubuntu/ trusty-backports main restricted universe multiverse" >> /etc/apt/sources.list
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN ln -s -f /bin/true /usr/bin/chfn
RUN apt-get update && apt-get -y upgrade && apt-get -y install \
 # QT + addons and KF5 stack deps
autogen \
automake \
autotools-dev \
bison \
build-essential \
bzr \
docbook-xml \
docbook-xsl \
doxygen \
firebird-dev \
flex \
freetds-dev \
fuse \
gdb \
git \
gperf \
graphviz \
gyp \
libaa1-dev \
libacl1-dev \
libappstream-dev \
libasound2-dev \
libaspell-dev \
libassuan-dev \
libatspi2.0-dev \
libatspi2.0-dev \
libattr1-dev \
libavc1394-dev \
libavcodec-dev \
libavformat-dev \
libavutil-dev \
libboost-all-dev \
libbz2-dev \
libcaca-dev \
libcap-dev \
libcdparanoia-dev \
libcups2-dev \
libdbus-1-dev \
libdc1394-22-dev \
libdrm-dev \
libdv4-dev \
libegl1-mesa-dev \
libepoxy-dev \
libevent-dev \
libexiv2-dev \
libfam-dev \
libflac++-dev \
libflac-dev \
libfontconfig1-dev \
libfreetype6-dev \
libfuse-dev \
libgbm-dev \
libgcrypt11-dev \
libgif-dev \
libgl1-mesa-dev \
libgles2-mesa-dev \
libglib2.0-dev \
libglu-dev \
libglu1-mesa-dev \
libgmp-dev \
libgtk-3-dev \
libgtk2.0-dev \
libharfbuzz-dev \
hspell \
libhunspell-dev \
libicu-dev \
libjack-dev \
libjpeg-dev \
libjsoncpp-dev \
libmagickcore-dev \
libmagickwand-dev \
libmtdev-dev \
libmysqlclient-dev \
libncurses5-dev \
libnss3-dev \
libogg-dev \
libopenal-dev \
libopus-dev \
libpci-dev \
libpcre3-dev \
libpng-dev \
libpolkit-agent-1-dev \
libpolkit-backend-1-dev \
libpolkit-gobject-1-dev \
libpq-dev \
libproxy-dev \
libpulse-dev \
libraw1394-dev \
libreadline-dev \
libshout3-dev \
libsnappy-dev \
libsoup2.4-dev \
libspeex-dev \
libsphinxbase-dev \
libsqlite3-dev \
libsrtp0-dev \
libssl-dev \
libsystemd-journal-dev \
libtag1-dev \
libtheora-dev \
libts-dev \
libudev-dev \
libvisual-0.4-dev \
libvoikko-dev \
libvorbis-dev \
libvorbisidec-dev \
libvpx-dev \
libwavpack-dev \
libwayland-dev \
libwayland-egl1-mesa \
libwayland-server0 \
libwayland0 \
libwebp-dev \
libx11-dev \
libx11-xcb-dev \
libxcb-composite0-dev \
libxcb-damage0-dev \
libxcb-icccm4-dev \
libxcb-image0-dev \
libxcb-keysyms1-dev \
libxcb-randr0-dev \
libxcb-render-util0-dev \
libxcb-render0-dev \
libxcb-shape0-dev \
libxcb-shm0-dev \
libxcb-sync-dev \
libxcb-sync-dev \
libxcb-xfixes0-dev \
libxcb-xinerama0-dev \
libxcb-xkb-dev \
libxcb-xtest0-dev \
libxcb1-dev \
libxcomposite-dev \
libxcursor-dev \
libxdamage-dev \
libxext-dev \
libxi-dev \
libxkbcommon-dev \
libxkbcommon-x11-dev \
libxkbfile-dev \
libxrandr-dev \
libxrender-dev \
libxslt1-dev \
libxss-dev \
libxtst-dev \
libxv-dev \
libutempter-dev \
media-player-info \
ninja-build \
pkg-config \
publicsuffix \
python2.7 \
python2.7-dev \
python3 \
python3-dev \
python-setuptools \
re2c \
ruby \
software-properties-common \
sphinxsearch \
texinfo \
unixodbc-dev \
wget \
xsltproc \
yasm \
zlib1g-dev \
zsync
RUN sudo add-apt-repository -y ppa:wayland.admin/daily-builds && sudo apt-get update && sudo apt-get -y install libinput-dev
RUN add-apt-repository -y ppa:ubuntu-toolchain-r/test && apt-get update && apt-get -y install g++-4.9
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install --reinstall linux-image-4.4.0-59
RUN groupadd -g 1000 jenkins
RUN useradd -m -u 1000 -g 1000 -d /home/jenkins jenkins
RUN mkdir -p /{appimage,app}
RUN chown jenkins.jenkins /appimage
RUN chown jenkins.jenkins /app
RUN echo 'jenkins:1234' | chpasswd #changeme
RUN adduser jenkins sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN modprobe fuse
RUN usermod -a -G fuse jenkins
RUN chgrp fuse /dev/fuse
RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
ENV LD_LIBRARY_PATH /opt/usr/lib:/opt/usr/lib/x86_64-linux-gnu:/usr/lib:/usr/lib64
ENV PATH /opt/usr/bin:/home/jenkins/.rbenv/bin:/home/jenkins/.rbenv/shims:$PATH
ENV PKG_CONFIG_PATH /opt/usr/lib/pkgconfig:/opt/usr/lib/x86_64-linux-gnu/pkgconfig:/usr/lib/pkgconfig:/usr/share/pkgconfig:/usr/lib/x86_64-linux-gnu/pkgconfig
ENV CXXFLAGS -std=c++11
#Misc deps too old on trusty
RUN wget http://ftp.x.org/pub/individual/util/util-macros-1.19.0.tar.bz2 && tar -jxvf util-macros-1.19.0.tar.bz2
RUN cd util-macros-1.19.0 && ./configure --prefix /opt/usr && make install && rm /util-macros-1.19.0.tar.bz2 && rm -rfv /util-macros-1.19.0
RUN wget http://ftp.gnu.org/gnu/m4/m4-1.4.18.tar.bz2 && tar -jxvf m4-1.4.18.tar.bz2
RUN cd m4-1.4.18  && autoreconf --force --install && mkdir builddir && cd builddir && ../configure --prefix=/opt/usr --disable-static &&  make -j 8 && make install && rm /m4-1.4.18.tar.bz2 && rm -rfv /m4-1.4.18
RUN wget http://ftp.gnu.org/pub/gnu/gettext/gettext-0.19.3.tar.gz && tar -xzvf gettext-0.19.3.tar.gz
RUN cd gettext-0.19.3 && ./configure --prefix=/opt/usr --disable-static &&  make -j 8 && make install && rm /gettext-0.19.3.tar.gz && rm -rfv /gettext-0.19.3
RUN git clone https://github.com/Kitware/CMake
RUN cd CMake && ./configure --prefix=/opt/usr && make && make install && rm -rfv /CMake
#Build newer gstreamer for sound stack
RUN wget 'https://gstreamer.freedesktop.org/src/gstreamer/gstreamer-1.10.2.tar.xz' && tar -xvf gstreamer-1.10.2.tar.xz
RUN cd gstreamer-1.10.2 && ./configure --prefix=/opt/usr --disable-static --enable-shared --enable-gst-debug && make && make install && rm /gstreamer-1.10.2.tar.xz && rm -rfv /gstreamer-1.10.2
RUN wget 'https://gstreamer.freedesktop.org/src/gst-plugins-base/gst-plugins-base-1.10.2.tar.xz' && tar -xvf gst-plugins-base-1.10.2.tar.xz
RUN cd gst-plugins-base-1.10.2 && ./configure --prefix=/opt/usr --disable-static --enable-shared --enable-gst-debug && make && make install && rm /gst-plugins-base-1.10.2.tar.xz && rm -rfv /gst-plugins-base-1.10.2
RUN wget 'https://gstreamer.freedesktop.org/src/gst-plugins-good/gst-plugins-good-1.10.2.tar.xz' && tar -xvf gst-plugins-good-1.10.2.tar.xz
RUN cd gst-plugins-good-1.10.2 && ./configure --prefix=/opt/usr --disable-static --enable-shared --enable-gst-debug && make && make install && rm /gst-plugins-good-1.10.2.tar.xz && rm -rfv /gst-plugins-good-1.10.2
# # Build Qt5.7 and install to /opt/usr
RUN wget http://qt.mirrors.tds.net/qt/archive/qt/5.7/5.7.1/single/qt-everywhere-opensource-src-5.7.1.tar.gz && tar -zxvf qt-everywhere-opensource-src-5.7.1.tar.gz
RUN cd qt-everywhere-opensource-src-5.7.1 && ./configure -v -release -opensource -confirm-license -dbus -qt-xcb -feature-accessibility -opengl es2 -system-sqlite -nomake examples -nomake tests -prefix /opt/usr && make && make install
RUN rm /qt-everywhere-opensource-src-5.7.1.tar.gz && rm -rfv /qt-everywhere-opensource-src-5.7.1
RUN wget http://download.qt.io/community_releases/5.7/5.7.1/qtwebkit-opensource-src-5.7.1.tar.xz && tar -xvf qtwebkit-opensource-src-5.7.1.tar.xz
RUN cd qtwebkit-opensource-src-5.7.1 && Tools/Scripts/build-webkit --qt --qmakearg="PREFIX+=/opt/usr" && qmake PREFIX=/opt/usr WebKit.pro && make && make install
RUN rm /qtwebkit-opensource-src-5.7.1.tar.xz && rm -rfv /qtwebkit-opensource-src-5.7.1
# Various external Qt relelated modules addons
RUN git clone http://code.qt.io/qt/qtstyleplugins.git
RUN cd qtstyleplugins && qmake PREFIX=/opt/usr . && make && make install && rm -rfv /qtstyleplugins
RUN git clone https://code.qt.io/cgit/qt/qtquick1.git
RUN cd qtquick1 && qmake PREFIX=/opt/usr . && make && make install && rm -rfv /qtquick1
RUN git clone https://code.qt.io/qt/qtspeech.git
RUN cd qtspeech && qmake PREFIX=/opt/usr . && make && make install && rm -rfv /qtspeech
RUN git clone https://github.com/flavio/qjson
RUN cd qjson &&  cmake -DCMAKE_INSTALL_PREFIX:PATH=/opt/usr && make && make install && rm -rfv /qjson
RUN bzr branch lp:libdbusmenu-qt
RUN cd libdbusmenu-qt &&  cmake -DCMAKE_INSTALL_PREFIX:PATH=/opt/usr && make && make install && rm -rfv /libdbusmenu-qt
RUN wget 'https://gstreamer.freedesktop.org/src/qt-gstreamer/qt-gstreamer-1.2.0.tar.xz' && tar -xvf qt-gstreamer-1.2.0.tar.xz
RUN cd qt-gstreamer-1.2.0 &&  cmake -DCMAKE_INSTALL_PREFIX:PATH=/opt/usr -DQT_VERSION=5 -DCMAKE_REQUIRED_INCLUDES=/opt/usr/include/gstreamer-1.0/ \
-DQTGSTREAMER_STATIC=OFF -DQTGSTREAMER_EXAMPLES=OFF && make && make install && rm /qt-gstreamer-1.2.0.tar.xz && rm -rfv /qt-gstreamer-1.2.0
RUN git clone https://github.com/steveire/grantlee
RUN cd grantlee && mkdir build && cd build && cmake -DCMAKE_INSTALL_PREFIX:PATH=/opt/usr .. && cmake --build . && cmake --build . --target install && rm -rfv /grantlee
RUN wget https://poppler.freedesktop.org/poppler-0.51.0.tar.xz && tar -xvf poppler-0.51.0.tar.xz
RUN cd poppler-0.51.0 && mkdir build && cd build && ../configure --prefix=/opt/usr -sysconfdir=/opt/etc --disable-static --enable-build-type=release \
--enable-cmyk --enable-xpdf-headers --enable-poppler-qt5 && make && make install && rm /poppler-0.51.0.tar.xz && rm -rfv /poppler-0.51.0
RUN wget http://sourceforge.net/projects/pyqt/files/sip/sip-4.16.5/sip-4.16.5.tar.gz && tar -zxvf sip-4.16.5.tar.gz
RUN cd sip-4.16.5 && python configure.py && make && make install
RUN wget https://downloads.sourceforge.net/project/pyqt/PyQt5/PyQt-5.3.2/PyQt-gpl-5.3.2.tar.gz && tar -zxvf PyQt-gpl-5.3.2.tar.gz
RUN sudo ln -s /usr/include/python2.7 /usr/local/include/python2.7
RUN sed -i "s#'webkitwidgets'#'webkitwidgets', 'printsupport'#g" PyQt-gpl-5.3.2/configure.py
RUN cd PyQt-gpl-5.3.2 && python configure.py --confirm-license --destdir /opt/usr --sip-incdir ../sip-4.16.5/siplib && make && make install
RUN rm -rfv python-qt5 && rm sip-4.16.5.tar.gz && rm -rfv sip-4.16.5
RUN wget http://download.kde.org/stable/qca/2.1.1/src/qca-2.1.1.tar.xz && tar -xvf qca-2.1.1.tar.xz
RUN cd qca-2.1.1 && mkdir build && cd build && cmake -DCMAKE_INSTALL_PREFIX:PATH=/opt/usr .. && cmake --build . && cmake --build . --target install && rm /qca-2.1.1.tar.xz && rm -rfv /qca-2.1.1
RUN git clone https://github.com/ayoy/qoauth
RUN cd qoauth && qmake '"PREFIX = /opt/usr" "QT += widgets" "QT += webkitwidgets" "CONFIG += crypto" "DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x000000"' src/src.pro && make && make install && rm -rfv /qoauth
#GPG stack for appimage signing
RUN wget https://www.gnupg.org/ftp/gcrypt/libgpg-error/libgpg-error-1.26.tar.bz2
RUN tar -jxvf libgpg-error-1.26.tar.bz2
RUN cd libgpg-error-1.26 && autoreconf --force --install && mkdir builddir && cd builddir && ../configure --prefix=/opt/usr --enable-static &&  make -j 8 && make install
RUN rm /libgpg-error-1.26.tar.bz2 && rm -rfv /libgpg-error-1.26
RUN wget https://www.gnupg.org/ftp/gcrypt/libksba/libksba-1.3.5.tar.bz2
RUN tar -jxvf libksba-1.3.5.tar.bz2
RUN cd libksba-1.3.5 && autoreconf --force --install && mkdir builddir && cd builddir && ../configure --prefix=/opt/usr &&  make -j 8 && make install
RUN rm /libksba-1.3.5.tar.bz2 && rm -rfv /libksba-1.3.5
RUN wget https://www.gnupg.org/ftp/gcrypt/libassuan/libassuan-2.4.3.tar.bz2
RUN tar -jxvf libassuan-2.4.3.tar.bz2
RUN cd libassuan-2.4.3 && autoreconf --force --install && mkdir builddir && cd builddir && ../configure --prefix=/opt/usr &&  make -j 8 && make install
RUN rm /libassuan-2.4.3.tar.bz2 && rm -rfv /libassuan-2.4.3
RUN wget https://www.gnupg.org/ftp/gcrypt/npth/npth-1.3.tar.bz2
RUN tar -jxvf npth-1.3.tar.bz2
RUN cd npth-1.3 && autoreconf --force --install && mkdir builddir && cd builddir && ../configure --prefix=/opt/usr &&  make -j 8 && make install
RUN rm /npth-1.3.tar.bz2 && rm -rfv /npth-1.3
RUN git clone git://git.gnupg.org/gpgme.git
RUN cd gpgme && autoreconf --force --install && mkdir builddir && cd builddir && ../configure --prefix=/opt/usr &&  make -j 8 && make install
RUN rm -rfv /gpgme
RUN wget https://www.gnupg.org/ftp/gcrypt/libgcrypt/libgcrypt-1.7.5.tar.bz2 && tar -jxvf libgcrypt-1.7.5.tar.bz2
RUN cd libgcrypt-1.7.5 && autoreconf --force --install && mkdir builddir && cd builddir && ../configure --prefix=/opt/usr &&  make -j 8 && make install
RUN rm /libgcrypt-1.7.5.tar.bz2 && rm -rfv /libgcrypt-1.7.5
RUN wget https://www.gnupg.org/ftp/gcrypt/gnupg/gnupg-2.1.17.tar.bz2 && tar -jxvf gnupg-2.1.17.tar.bz2
RUN cd gnupg-2.1.17 && autoreconf --force --install && mkdir builddir && cd builddir && ../configure --prefix=/opt/usr &&  make -j 8 && make install
RUN rm /gnupg-2.1.17.tar.bz2 && rm -rfv /gnupg-2.1.17
RUN echo 'eval "$(rbenv init -)"' >> /etc/profile
ENV PATH /opt/usr/bin:/root/.rbenv/bin:/root/.rbenv/shims:$PATH
 # Install rbenv and ruby-build
RUN git clone https://github.com/sstephenson/rbenv.git /root/.rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git /root/.rbenv/plugins/ruby-build
RUN echo 'eval "$(rbenv init -)"' >> /.bashrc && rbenv init -
ENV CONFIGURE_OPTS --disable-install-doc
ADD ./versions.txt /home/jenkins/versions.txt
ADD ./Gemfile /Gemfile
RUN xargs -L 1 rbenv install < /home/jenkins/versions.txt
 # Install Bundler for each version of ruby
RUN echo 'gem: --no-rdoc --no-ri' >> /home/jenkins/.gemrc
RUN bash -l -c 'for v in $(cat /home/jenkins/versions.txt); do rbenv global $v; gem install bundler; done' && eval "$(rbenv init -)" && cd / && bundle install && rbenv local 2.3.1


USER root
