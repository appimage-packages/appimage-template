FROM ubuntu:14.04
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN apt-get update && apt-get -y upgrade && apt-get -y install \
 software-properties-common \
 wget \
 git \
 build-essential \
 libreadline-dev \
 libmagickcore-dev \
 libmagickwand-dev \
 fuse \
 fuseiso \
 libfuse-dev \
 # QT deps
 firebird-dev \
 freetds-dev \
 gdb \
 libasound2-dev \
 libatspi2.0-dev \
 libcups2-dev \
 libdbus-1-dev \
 libfontconfig1-dev \
 libfreetype6-dev \
 libgbm-dev \
 libgl1-mesa-dev \
 libgles2-mesa-dev \
 libglib2.0-dev \
 libglu-dev \
 libglu1-mesa-dev \
 libgstreamer-plugins-base1.0-dev \
 libgstreamer1.0-dev \
 libgtk-3-dev \
 libharfbuzz-dev \
 libicu-dev \
 libjpeg-dev \
 libmtdev-dev \
 libmysqlclient-dev \
 libpcre3-dev \
 libpng-dev \
 libpq-dev \
 libproxy-dev \
 libpulse-dev \
 libsqlite3-dev \
 libssl-dev \
 libudev-dev \
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
 libxext-dev \
 libxi-dev \
 libxkbcommon-dev \
 libxkbcommon-x11-dev \
 libxrender-dev \
 pkg-kde-tools \
 publicsuffix \
 unixodbc-dev \
 zlib1g-dev
RUN sudo add-apt-repository -y ppa:wayland.admin/daily-builds && sudo apt-get update && sudo apt-get -y install libinput-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install --reinstall linux-image-4.4.0-36
RUN groupadd -g 1000 jenkins
RUN useradd -m -u 1000 -g 1000 -d /home/jenkins jenkins
RUN mkdir -p /{appimage,app,out}
RUN chown jenkins.jenkins /appimage
RUN chown jenkins.jenkins /app
RUN chown jenkins.jenkins /out
RUN echo 'jenkins:1234' | chpasswd #changeme
RUN adduser jenkins sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN modprobe fuse
RUN usermod -a -G fuse jenkins
RUN chgrp fuse /dev/fuse
RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
RUN echo 'eval "$(rbenv init -)"' >> /etc/profile # or /etc/profile
# Build Qt5.7 and install to /opt/qt5
RUN wget http://download.qt.io/archive/qt/5.7/5.7.0/single/qt-everywhere-opensource-src-5.7.0.tar.xz
RUN tar -xvf qt-everywhere-opensource-src-5.7.0.tar.xz
RUN cd qt-everywhere-opensource-src-5.7.0 && ./configure -v -release -opensource -confirm-license -no-sql-sqlite -no-gif -qt-libjpeg -skip qt3d -no-qml-debug -no-sql-odbc -qt-xcb -no-compile-examples -nomake examples -prefix /opt/usr && make && make install
RUN git clone git://gitorious.org/qt/qtquick1.git
RUN cd qtquick1 && qmake PREFIX=/opt/usr . && make
RUN git clone https://github.com/Kitware/CMake
RUN cd CMake && ./configure --prefix=/opt/usr && make && make install
USER jenkins
# Install rbenv and ruby-build
RUN echo 'eval "$(rbenv init -)"' >> ~/.bashrc
ENV PATH /opt/usr/bin:/home/jenkins/.rbenv/bin:/home/jenkins/.rbenv/shims:$PATH
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
