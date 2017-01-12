FROM ubuntu:14.04
RUN echo "deb-src http://us.archive.ubuntu.com/ubuntu/ trusty main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb-src http://ca.archive.ubuntu.com/ubuntu/ trusty main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://ca.archive.ubuntu.com/ubuntu/ trusty-updates main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb-src http://ca.archive.ubuntu.com/ubuntu/ trusty-updates main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://us.archive.ubuntu.com/ubuntu/ trusty-backports main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb-src http://us.archive.ubuntu.com/ubuntu/ trusty-backports main restricted universe multiverse" >> /etc/apt/sources.list
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN apt-get update && apt-get -y upgrade && apt-get -y install \
 # QT stack deps
 autogen \
 automake \
 bison \
 build-essential \
 bzr \
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
 libasound2-dev \
 libassuan-dev \
 libatspi2.0-dev \
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
 libevent-dev \
 libflac-dev \
 libfontconfig1-dev \
 libfreetype6-dev \
 libfuse-dev \
 libgbm-dev \
 libgcrypt11-dev \
 libgl1-mesa-dev \
 libgles2-mesa-dev \
 libglib2.0-dev \
 libglu-dev \
 libglu1-mesa-dev \
 libgpg-error-dev \
 libgtk-3-dev \
 libharfbuzz-dev \
 libicu-dev \
 libjack-dev \
 libjpeg-dev \
 libjsoncpp-dev \
 libmagickcore-dev \
 libmagickwand-dev \
 libmtdev-dev \
 libmysqlclient-dev \
 libnss3-dev \
 libogg-dev \
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
 libsoup2.4-dev \
 libspeex-dev \
 libsqlite3-dev \
 libsrtp0-dev \
 libssl-dev \
 libtag1-dev \
 libtheora-dev \
 libudev-dev \
 libvisual-0.4-dev  \
 libvorbis-dev \
 libvorbisidec-dev \
 libvpx-dev \
 libwavpack-dev \
 libwayland-dev \
 libwayland-egl1-mesa \
 libwayland-server0 \
 libwebp-dev \
 libx11-dev \
 libx11-xcb-dev \
 libxcb-icccm4-dev \
 libxcb-image0-dev \
 libxcb-keysyms1-dev \
 libxcb-randr0-dev \
 libxcb-render-util0-dev \
 libxcb-render0-dev \
 libxcb-shape0-dev \
 libxcb-shm0-dev \
 libxcb-sync-dev \
 libxcb-xfixes0-dev \
 libxcb-xinerama0-dev \
 libxcb-xkb-dev \
 libxcb1-dev \
 libxcomposite-dev \
 libxcursor-dev \
 libxdamage-dev \
 libxext-dev \
 libxi-dev \
 libxkbcommon-dev \
 libxkbcommon-x11-dev \
 libxrandr-dev \
 libxrender-dev \
 libxss-dev \
 libxtst-dev \
 libxv-dev \
 ninja-build \
 publicsuffix \
 python \
 software-properties-common \
 texinfo \
 unixodbc-dev \
 wget \
 yasm \
 zlib1g-dev
RUN sudo add-apt-repository -y ppa:wayland.admin/daily-builds && sudo apt-get update && sudo apt-get -y install libinput-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install --reinstall linux-image-4.4.0-57
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
RUN echo 'eval "$(rbenv init -)"' >> /etc/profile # or /etc/profile
ENV LD_LIBRARY_PATH /opt/usr/lib:/opt/usr/lib/x86_64-linux-gnu:/usr/lib:/usr/lib64
ENV PATH /opt/usr/bin:/home/jenkins/.rbenv/bin:/home/jenkins/.rbenv/shims:$PATH
ENV PKG_CONFIG_PATH /opt/usr/lib/pkgconfig:/opt/usr/lib/x86_64-linux-gnu/pkgconfig:/usr/lib/pkgconfig:/usr/share/pkgconfig:/usr/lib/x86_64-linux-gnu/pkgconfig
#Build gpgme stack
RUN wget http://ftp.x.org/pub/individual/util/util-macros-1.19.0.tar.bz2
RUN tar -jxvf util-macros-1.19.0.tar.bz2
RUN cd util-macros-1.19.0 && ./configure --prefix /opt/usr && make install
RUN wget http://ftp.gnu.org/gnu/m4/m4-1.4.18.tar.bz2
RUN tar -jxvf m4-1.4.18.tar.bz2
RUN cd m4-1.4.18  && autoreconf --force --install && mkdir builddir && cd builddir && ../configure --prefix=/opt/usr --disable-static &&  make -j 8 && make install
RUN wget http://ftp.gnu.org/pub/gnu/gettext/gettext-0.19.3.tar.gz
RUN tar -xzvf gettext-0.19.3.tar.gz
RUN cd gettext-0.19.3 && ./configure --prefix=/opt/usr --disable-static &&  make -j 8 && make install
#Build newer gstreamer for sound stack
RUN wget 'https://gstreamer.freedesktop.org/src/gstreamer/gstreamer-1.10.2.tar.xz'
RUN tar -xvf gstreamer-1.10.2.tar.xz
RUN cd gstreamer-1.10.2 && ./configure --prefix=/opt/usr --disable-static --enable-shared --enable-gst-debug && make && make install
RUN wget 'https://gstreamer.freedesktop.org/src/gst-plugins-base/gst-plugins-base-1.10.2.tar.xz'
RUN tar -xvf gst-plugins-base-1.10.2.tar.xz
RUN cd gst-plugins-base-1.10.2 && ./configure --prefix=/opt/usr --disable-static --enable-shared --enable-gst-debug && make && make install
RUN wget 'https://gstreamer.freedesktop.org/src/gst-plugins-good/gst-plugins-good-1.10.2.tar.xz'
RUN tar -xvf gst-plugins-good-1.10.2.tar.xz
RUN cd gst-plugins-good-1.10.2 && ./configure --prefix=/opt/usr --disable-static --enable-shared --enable-gst-debug && make && make install
# # Build Qt5.7 and install to /opt/usr
RUN wget http://download.qt.io/snapshots/qt/5.7/5.7.1/latest_src/qt-everywhere-opensource-src-5.7.1.tar.xz
RUN tar -xvf qt-everywhere-opensource-src-5.7.1.tar.xz
RUN cd qt-everywhere-opensource-src-5.7.1 && ./configure -v -release -opensource -confirm-license -dbus -qt-xcb -feature-accessibility -opengl es2 -system-sqlite -nomake examples -nomake tests -prefix /opt/usr && make && make install
RUN git clone http://code.qt.io/qt/qtstyleplugins.git
RUN cd qtstyleplugins && qmake PREFIX=/opt/usr . && make && make install
RUN git clone https://code.qt.io/cgit/qt/qtquick1.git
RUN cd qtquick1 && qmake PREFIX=/opt/usr . && make && make install
RUN git clone https://code.qt.io/qt/qtspeech.git
RUN cd qtspeech && qmake PREFIX=/opt/usr . && make && make install
RUN git clone https://github.com/Kitware/CMake
RUN cd CMake && ./configure --prefix=/opt/usr && make && make install
RUN git clone https://github.com/flavio/qjson
RUN cd qjson &&  cmake -DCMAKE_INSTALL_PREFIX:PATH=/opt/usr
RUN bzr branch lp:libdbusmenu-qt
RUN cd libdbusmenu-qt &&  cmake -DCMAKE_INSTALL_PREFIX:PATH=/opt/usr
RUN wget https://www.gnupg.org/ftp/gcrypt/libgpg-error/libgpg-error-1.26.tar.bz2
RUN tar -jxvf libgpg-error-1.26.tar.bz2
RUN cd libgpg-error-1.26 && autoreconf --force --install && mkdir builddir && cd builddir && ../configure --prefix=/opt/usr --enable-static &&  make -j 8 && make install
RUN wget https://www.gnupg.org/ftp/gcrypt/libksba/libksba-1.3.5.tar.bz2
RUN tar -jxvf libksba-1.3.5.tar.bz2
RUN cd libksba-1.3.5 && autoreconf --force --install && mkdir builddir && cd builddir && ../configure --prefix=/opt/usr &&  make -j 8 && make install
RUN wget https://www.gnupg.org/ftp/gcrypt/libassuan/libassuan-2.4.3.tar.bz2
RUN tar -jxvf libassuan-2.4.3.tar.bz2
RUN cd libassuan-2.4.3 && autoreconf --force --install && mkdir builddir && cd builddir && ../configure --prefix=/opt/usr &&  make -j 8 && make install
RUN wget https://www.gnupg.org/ftp/gcrypt/npth/npth-1.3.tar.bz2
RUN tar -jxvf npth-1.3.tar.bz2
RUN cd npth-1.3 && autoreconf --force --install && mkdir builddir && cd builddir && ../configure --prefix=/opt/usr &&  make -j 8 && make install
RUN git clone git://git.gnupg.org/gpgme.git
RUN cd gpgme && autoreconf --force --install && mkdir builddir && cd builddir && ../configure --prefix=/opt/usr &&  make -j 8 && make install
RUN wget https://www.gnupg.org/ftp/gcrypt/libgcrypt/libgcrypt-1.7.5.tar.bz2
RUN tar -jxvf libgcrypt-1.7.5.tar.bz2
RUN cd libgcrypt-1.7.5 && autoreconf --force --install && mkdir builddir && cd builddir && ../configure --prefix=/opt/usr &&  make -j 8 && make install
RUN wget https://www.gnupg.org/ftp/gcrypt/gnupg/gnupg-2.1.17.tar.bz2
RUN tar -jxvf gnupg-2.1.17.tar.bz2
RUN cd gnupg-2.1.17 && autoreconf --force --install && mkdir builddir && cd builddir && ../configure --prefix=/opt/usr &&  make -j 8 && make install
RUN wget 'https://gstreamer.freedesktop.org/src/qt-gstreamer/qt-gstreamer-1.2.0.tar.xz'
RUN tar -xvf qt-gstreamer-1.2.0.tar.xz
RUN cd qt-gstreamer-1.2.0 &&  cmake -DCMAKE_INSTALL_PREFIX:PATH=/opt/usr -DQT_VERSION=5 -DCMAKE_REQUIRED_INCLUDES=/opt/usr/include/gstreamer-1.0/ -DQTGSTREAMER_STATIC=OFF -DQTGSTREAMER_EXAMPLES=OFF && make && make install
USER jenkins
# Install rbenv and ruby-build
RUN echo 'eval "$(rbenv init -)"' >> ~/.bashrc
RUN git clone https://github.com/sstephenson/rbenv.git /home/jenkins/.rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git /home/jenkins/.rbenv/plugins/ruby-build

ENV CONFIGURE_OPTS --disable-install-doc
ADD ./versions.txt /home/jenkins/versions.txt
ADD ./Gemfile /home/jenkins/Gemfile
RUN xargs -L 1 rbenv install < /home/jenkins/versions.txt

# Install Bundler for each version of ruby
RUN echo 'gem: --no-rdoc --no-ri' >> /home/jenkins/.gemrc
RUN bash -l -c 'for v in $(cat /home/jenkins/versions.txt); do rbenv global $v; gem install bundler; done' && eval "$(rbenv init -)" && cd /home/jenkins && bundle install && rbenv local 2.3.1

USER root
