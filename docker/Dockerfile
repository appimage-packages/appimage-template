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
 bison \
 build-essential \
 firebird-dev \
 flex \
 freetds-dev \
 fuse \
 gdb \
 git \
 gperf \
 graphviz \
 gyp \
 libtheora-dev \
 libasound2-dev \
 libatspi2.0-dev \
 libavcodec-dev \
 libavformat-dev \
 libavutil-dev \
 libbz2-dev \
 libcap-dev \
 libcups2-dev \
 libdbus-1-dev \
 libdrm-dev \
 libegl1-mesa-dev \
 libevent-dev \
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
 libpq-dev \
 libproxy-dev \
 libpulse-dev \
 libreadline-dev \
 libsoup2.4-dev \
 libsqlite3-dev \
 libsrtp0-dev \
 libssl-dev \
 libudev-dev \
 libvisual-0.4-dev  \
 libvorbis-dev \
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
 unixodbc-dev \
 wget \
 zlib1g-dev
RUN sudo add-apt-repository -y ppa:wayland.admin/daily-builds && sudo apt-get update && sudo apt-get -y install libinput-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install --reinstall linux-image-4.4.0-51
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
#Build newer gstreamer for sound stack
RUN wget 'https://gstreamer.freedesktop.org/src/gstreamer/gstreamer-1.10.2.tar.xz'
RUN tar -xvf gstreamer-1.10.2.tar.xz'
RUN cd gstreamer-1.10.2 && ./configure --prefix=/opt/usr && make && make install
RUN wget 'https://gstreamer.freedesktop.org/src/gst-plugins-base/gst-plugins-base-1.10.2.tar.xz'
RUN tar -xvf gst-plugins-base-1.10.2'
RUN cd gst-plugins-base-1.10.2 && ./configure --prefix=/opt/usr && make && make install
RUN wget 'https://gstreamer.freedesktop.org/src/gst-plugins-good/gst-plugins-good-1.10.2.tar.xz'
RUN tar -xvf gst-plugins-good-1.10.2.tar.xz'
RUN cd gst-plugins-good-1.10.2 && ./configure --prefix=/opt/usr && make && make install
RUN wget 'https://gstreamer.freedesktop.org/src/gst-plugins-bad/gst-plugins-bad-1.10.2.tar.xz'
RUN tar -xvf gst-plugins-bad-1.10.2.tar.xz'
RUN cd gst-plugins-bad-1.10.2 && ./configure --prefix=/opt/usr && make && make install
RUN wget 'https://gstreamer.freedesktop.org/src/gst-plugins-ugly/gst-plugins-ugly-1.10.2.tar.xz'
RUN tar -xvf gst-plugins-ugly-1.10.2.tar.xz'
RUN cd gst-plugins-ugly-1.10.2 && ./configure --prefix=/opt/usr && make && make install
RUN wget 'https://gstreamer.freedesktop.org/src/gst-libav/gst-libav-1.10.2.tar.xz'
RUN tar -xvf gst-libav-1.10.2.tar.xz'
RUN cd gst-libav-1.10.2 && ./configure --prefix=/opt/usr && make && make install
ENV LD_LIBRARY_PATH /app/usr/lib:/app/usr/lib/x86_64-linux-gnu:/opt/usr/lib:/opt/usr/lib/x86_64-linux-gnu:/usr/lib64:/usr/lib
ENV PATH /opt/usr/bin:/home/jenkins/.rbenv/bin:/home/jenkins/.rbenv/shims:$PATH
RUN wget 'https://gstreamer.freedesktop.org/src/qt-gstreamer/qt-gstreamer-1.2.0.tar.xz'
# Build Qt5.7 and install to /opt/usr
RUN rm -rfv /opt/usr
RUN wget http://download.qt.io/snapshots/qt/5.7/5.7.1/latest_src/qt-everywhere-opensource-src-5.7.1.tar.xz
RUN tar -xvf qt-everywhere-opensource-src-5.7.1.tar.xz
RUN cd qt-everywhere-opensource-src-5.7.1 && ./configure -v -release -opensource -confirm-license -dbus -qt-xcb -feature-accessibility -system-sqlite -nomake examples -nomake tests -prefix /opt/usr && make && make install
RUN tar -xvf qt-gstreamer-1.2.0.tar.xz
RUN cd qt-gstreamer-1.2.0 &&  '-DCMAKE_INSTALL_PREFIX:PATH=/opt/usr -DQT_VERSION=5 -DCMAKE_REQUIRED_INCLUDES=/opt/usr/include/gstreamer-1.0/ \
-DQTGSTREAMER_STATIC=OFF -DQTGSTREAMER_EXAMPLES=OFF' && make && make install
RUN git clone http://code.qt.io/qt/qtstyleplugins.git
RUN cd qtstyleplugins && qmake PREFIX=/opt/usr . && make && make install
RUN git clone https://code.qt.io/cgit/qt/qtquick1.git
RUN cd qtquick1 && qmake PREFIX=/opt/usr . && make && make install
RUN git clone https://code.qt.io/qt/qtspeech.git
RUN cd qtspeech && qmake PREFIX=/opt/usr . && make && make install
RUN git clone https://github.com/Kitware/CMake
RUN cd CMake && ./configure --prefix=/opt/usr && make && make install
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
