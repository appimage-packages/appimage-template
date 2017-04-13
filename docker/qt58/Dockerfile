FROM ubuntu:14.04
RUN echo "deb http://us.archive.ubuntu.com/ubuntu/ trusty main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb-src http://ca.archive.ubuntu.com/ubuntu/ trusty main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://ca.archive.ubuntu.com/ubuntu/ trusty-updates main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb-src http://ca.archive.ubuntu.com/ubuntu/ trusty-updates main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://us.archive.ubuntu.com/ubuntu/ trusty-backports main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb-src http://us.archive.ubuntu.com/ubuntu/ trusty-backports main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://apt.llvm.org/trusty/ llvm-toolchain-trusty-3.8 main" >> /etc/apt/sources.list
RUN echo "deb-src http://apt.llvm.org/trusty/ llvm-toolchain-trusty-3.8 main" >> /etc/apt/sources.list

#link to bash
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN ln -s -f /bin/true /usr/bin/chfn
RUN apt-get update && apt-get -y upgrade && apt-get -y build-dep libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libgstreamer-plugins-good1.0-dev python3-dev
RUN apt-get -y --force-yes install \
'^libxcb.*-dev' \
bzr \
clang-3.8 \
festival \
festival-dev \
firebird-dev \
freeglut3-dev \
freetds-dev \
fuse \
gdb \
git \
gperf \
guile-2.0-dev \
intltool \
libasound2-dev \
libatkmm-1.6-dev \
libatomic-ops-dev \
libatspi2.0-dev \
libboost-all-dev \
libcap-dev \
libclang-3.8-dev \
libcups2-dev \
libdbus-1-dev \
libdouble-conversion-dev \
libfontconfig1-dev \
libfreetype6-dev \
libgbm-dev \
libgl1-mesa-dev \
libgles2-mesa-dev \
libglew-dev \
libglew1.5-dev \
libglib2.0-dev \
libglm-dev \
libglu1-mesa-dev \
libgtk-3-dev \
libharfbuzz-dev \
libicu-dev \
libjpeg-dev \
libmtdev-dev \
libmysqlclient-dev \
libopus-dev \
libpcre3-dev \
libpng-dev \
libpq-dev \
libproxy-dev \
libreadline-dev \
libsndfile1-dev \
libsqlite3-dev \
libssl-dev \
libsystemd-journal-dev \
libudev-dev \
libunistring-dev \
libunwind8-dev \
libvorbis-dev \
libx11-xcb-dev \
libxext-dev \
libxi-dev \
libxi-dev \
libxkbcommon-dev \
libxkbcommon-x11-dev \
libxrender-dev \
libxrender-dev \
libxslt-dev \
lldb-3.8 \
llvm-3.8-dev \
llvm-3.8 \
ml-lex \
publicsuffix \
python-dev \
ruby \
software-properties-common \
subversion \
texinfo \
unixodbc-dev \
wget \
x11proto-dri3-dev \
x11proto-present-dev \
yasm \
zlib1g-dev \
zsync
# # Rebuild kernel, needed for fuse.
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install --reinstall linux-image-4.4.0-72

## Rebuild pam to allow su
# Rebuild pam with --disable-audit flag
# Fixes: https://github.com/docker/docker/issues/5899
##
RUN apt-get -y build-dep pam \
    && cd /tmp/ \
    && export CONFIGURE_OPTS=--disable-audit \
    && apt-get -b source pam \
    && dpkg -i libpam-doc*.deb libpam-modules*.deb libpam-runtime*.deb libpam0g*.deb \
    && rm -rf /tmp/* \
&& unset CONFIGURE_OPTS

#Oddballs from ppas
RUN add-apt-repository -y ppa:wayland.admin/daily-builds && sudo apt-get update && sudo apt-get -y install libinput-dev  libwayland-dev \
 libwayland-server0 libwayland0 && add-apt-repository -y -r ppa:wayland.admin/daily-builds
RUN add-apt-repository -y ppa:jonathonf/mysql && sudo apt-get update && apt-get -y install mysql-server-core-5.7 mysql-client-5.7 && add-apt-repository -y -r ppa:jonathonf/mysql
RUN add-apt-repository -y ppa:george-edison55/cmake-3.x  && sudo apt-get update && apt-get -y install cmake
RUN add-apt-repository -y ppa:jonathonf/gtk3.18 && sudo apt-get update && sudo apt-get -y install libglib2.0-dev && add-apt-repository -y -r ppa:jonathonf/gtk3.18

# Set up for GCC options ( try gcc6 )
RUN add-apt-repository -y ppa:ubuntu-toolchain-r/test && apt-get update && apt-get -y install gcc-4.9 g++-4.9 gcc-5 g++-5 gcc-6 g++-6 && \
update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.9 10 && \
update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-5 20 && \
update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-6 30 && \
update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.9 10 && \
update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-5 20 && \
update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-6 30 && \
update-alternatives --set gcc "/usr/bin/gcc-6" && \
update-alternatives --set g++ "/usr/bin/g++-6" && \
update-alternatives --install /usr/bin/cc cc /usr/bin/gcc 40 && \
update-alternatives --set cc /usr/bin/gcc && \
update-alternatives --install /usr/bin/c++ c++ /usr/bin/g++ 40 && \
update-alternatives --set c++ /usr/bin/g++ && \
gcc --version && \
cc --version && \
g++ --version && apt-get -y upgrade

 #Set ENV
ENV LD_LIBRARY_PATH /opt/usr/lib:/opt/usr/lib/gstreamer-1.0:/opt/usr/lib/x86_64-linux-gnu:/usr/lib:/usr/lib64:/lib
ENV PATH /opt/usr/bin:/home/jenkins/.rbenv/bin:/home/jenkins/.rbenv/shims:$PATH
ENV PKG_CONFIG_PATH /opt/usr/lib/pkgconfig:/opt/usr/lib/x86_64-linux-gnu/pkgconfig:/usr/lib/pkgconfig:/usr/share/pkgconfig:/usr/lib/x86_64-linux-gnu/pkgconfig
ENV CXXFLAGS -std=c++11
ENV CPATH /opt/usr/include/gstreamer-1.0:/opt/usr/include:$CPATH
ENV SOURCES /

#Newer toolchain
RUN cd $SOURCES && wget http://ftp.x.org/pub/individual/util/util-macros-1.19.0.tar.bz2 && tar -jxvf util-macros-1.19.0.tar.bz2 && \
cd $SOURCES/util-macros-1.19.0 && ./configure --prefix /usr && make install && rm $SOURCES/util-macros-1.19.0.tar.bz2 && rm -rfv $SOURCES/util-macros-1.19.0
RUN cd $SOURCES && wget http://ftp.gnu.org/gnu/m4/m4-1.4.18.tar.bz2 && tar -jxvf m4-1.4.18.tar.bz2 && \
cd $SOURCES/m4-1.4.18  && mkdir builddir && cd builddir && ../configure --prefix=/usr --enable-shared &&  make -j 8 && make install \
&& rm $SOURCES/m4-1.4.18.tar.bz2 && rm -rfv $SOURCES/m4-1.4.18
RUN cd $SOURCES && wget http://ftp.gnu.org/gnu/autoconf/autoconf-2.69.tar.xz && tar -xvf autoconf-2.69.tar.xz && \
cd $SOURCES/autoconf-2.69 && mkdir builddir && cd builddir && ../configure --prefix=/usr &&  make -j 8 && make install && \
rm $SOURCES/autoconf-2.69.tar.xz && rm -rfv $SOURCES/autoconf-2.69
RUN cd $SOURCES && wget https://ftp.gnu.org/gnu/automake/automake-1.15.tar.xz && tar -xvf automake-1.15.tar.xz && \
cd $SOURCES/automake-1.15 && mkdir builddir && cd builddir && ../configure --prefix=/usr &&  make -j 8 && make install && \
rm $SOURCES/automake-1.15.tar.xz && rm -rfv $SOURCES/automake-1.15
RUN cd $SOURCES && wget https://ftp.gnu.org/gnu/autogen/rel5.18.12/autogen-5.18.12.tar.xz && tar -xvf autogen-5.18.12.tar.xz && \
cd $SOURCES/autogen-5.18.12 && mkdir builddir && cd builddir && ../configure --prefix=/usr &&  make -j 8 && make install && \
rm $SOURCES/autogen-5.18.12.tar.xz && rm -rfv $SOURCES/autogen-5.18.12
RUN cd $SOURCES && wget http://ftp.gnu.org/pub/gnu/gettext/gettext-0.19.3.tar.gz && tar -xzvf gettext-0.19.3.tar.gz && \
cd $SOURCES/gettext-0.19.3 && ./configure --prefix=/usr &&  make -j 8 && make install && rm $SOURCES/gettext-0.19.3.tar.gz && rm -rfv $SOURCES/gettext-0.19.3
RUN cd $SOURCES && wget http://www.cups.org/software/1.7.5/cups-1.7.5-source.tar.bz2 && tar -jxvf cups-1.7.5-source.tar.bz2 && \
cd $SOURCES/cups-1.7.5 && aclocal -I config-scripts && autoconf -I config-scripts && ./configure --prefix=/usr &&  make -j 8 && make install && \
rm -rfv $SOURCES/cups-1.7.5 && rm $SOURCES/cups-1.7.5-source.tar.bz2

# Newer xlibs
ADD Xlibs.sh $SOURCES/
RUN cd $SOURCES && /bin/bash -x Xlibs.sh
#New dbus
RUN sudo apt-get -y remove 'libdbus-1-dev'
RUN cd $SOURCES && wget http://dbus.freedesktop.org/releases/dbus/dbus-1.10.16.tar.gz && tar -xvf dbus-1.10.16.tar.gz
RUN cd $SOURCES/dbus-1.10.16 && autoreconf --force --install && mkdir builddir && cd builddir && ../configure --prefix=/usr &&  make -j 8 && make install && \
rm $SOURCES/dbus-1.10.16.tar.gz && rm -rfv $SOURCES/dbus-1.10.16
RUN cd $SOURCES && wget http://dbus.freedesktop.org/releases/dbus-glib/dbus-glib-0.108.tar.gz && tar -xvf dbus-glib-0.108.tar.gz
RUN cd $SOURCES/dbus-glib-0.108 && autoreconf --force --install && mkdir builddir && cd builddir && ../configure --prefix=/usr &&  make -j 8 && make install && \
rm $SOURCES/dbus-glib-0.108.tar.gz && rm -rfv $SOURCES/dbus-glib-0.108
#New pulseaudio
RUN cd $SOURCES && wget http://freedesktop.org/software/pulseaudio/releases/pulseaudio-10.0.tar.xz && tar -xvf pulseaudio-10.0.tar.xz
RUN cd $SOURCES/pulseaudio-10.0 && mkdir builddir && cd builddir && ../configure --prefix=/usr &&  make -j 8 && make install && \
rm $SOURCES/pulseaudio-10.0.tar.xz && rm -rfv $SOURCES/pulseaudio-10.0

# Create jenkins user
RUN groupadd -g 1000 jenkins
RUN useradd -m -u 1000 -g 1000 -d /home/jenkins jenkins
RUN modprobe fuse
RUN usermod -a -G fuse jenkins
RUN chgrp fuse /dev/fuse
RUN mkdir -p /{appimages,app.Dir,source}
RUN chown jenkins.jenkins /appimages && chown jenkins.jenkins /app.Dir &&  chown jenkins.jenkins /source &&  chown jenkins.jenkins /opt
RUN echo 'jenkins:1234' | chpasswd #changeme
RUN adduser jenkins sudo
RUN echo 'jenkins ALL=NOPASSWD: ALL' >> /etc/sudoers
RUN echo 'bundler ALL=NOPASSWD: /home/jenkins/.rbenv/bin/bundler' >> /etc/sudoers
RUN echo 'eval "$(rbenv init -)"' >> /etc/profile
# Cpan perl lib needed by kf5
RUN cd $SOURCES && cpan URI::Escape
# Everythin else as jenkins user ( NOT WORKING, disabled for now.)
#USER jenkins

 #Set ENV
ENV LD_LIBRARY_PATH /opt/usr/lib:/opt/usr/lib/gstreamer-1.0:/opt/usr/lib/x86_64-linux-gnu:/usr/lib:/usr/lib64:/lib
ENV PATH /opt/usr/bin:/root/.rbenv/bin:/root/.rbenv/shims:$PATH
ENV PKG_CONFIG_PATH /opt/usr/lib/pkgconfig:/opt/usr/lib/x86_64-linux-gnu/pkgconfig:/usr/lib/pkgconfig:/usr/share/pkgconfig:/usr/lib/x86_64-linux-gnu/pkgconfig
ENV CXXFLAGS -std=c++11 -fPIC
ENV CPATH /opt/usr/include/gstreamer-1.0:/opt/usr/include:$CPATH
ENV SOURCES /source

#GPG stack for gpgme
RUN cd $SOURCES && wget https://www.gnupg.org/ftp/gcrypt/libgpg-error/libgpg-error-1.26.tar.bz2 && tar -jxvf libgpg-error-1.26.tar.bz2 && \
cd $SOURCES/libgpg-error-1.26 && autoreconf --force --install && mkdir builddir && cd builddir && ../configure --prefix=/opt/usr &&  make -j 8 && make install && \
rm $SOURCES/libgpg-error-1.26.tar.bz2 && rm -rfv $SOURCES/libgpg-error-1.26
RUN cd $SOURCES && wget https://www.gnupg.org/ftp/gcrypt/libksba/libksba-1.3.5.tar.bz2 && tar -jxvf libksba-1.3.5.tar.bz2 && \
cd  $SOURCES/libksba-1.3.5 && autoreconf --force --install && mkdir builddir && cd builddir && ../configure --prefix=/opt/usr &&  make -j 8 && make install && \
rm  $SOURCES/libksba-1.3.5.tar.bz2 && rm -rfv $SOURCES/libksba-1.3.5
RUN cd  $SOURCES && wget https://www.gnupg.org/ftp/gcrypt/libassuan/libassuan-2.4.3.tar.bz2 && tar -jxvf libassuan-2.4.3.tar.bz2 && \
cd $SOURCES/libassuan-2.4.3 && autoreconf --force --install && mkdir builddir && cd builddir && ../configure --prefix=/opt/usr &&  make -j 8 && make install && \
rm $SOURCES/libassuan-2.4.3.tar.bz2 && rm -rfv $SOURCES/libassuan-2.4.3
RUN cd $SOURCES && wget https://www.gnupg.org/ftp/gcrypt/npth/npth-1.3.tar.bz2 && tar -jxvf npth-1.3.tar.bz2 && \
cd $SOURCES/npth-1.3 && autoreconf --force --install && mkdir builddir && cd builddir && ../configure --prefix=/opt/usr &&  make -j 8 && make install && \
rm $SOURCES/npth-1.3.tar.bz2 && rm -rfv $SOURCES/npth-1.3
RUN cd $SOURCES && wget https://www.gnupg.org/ftp/gcrypt/libgcrypt/libgcrypt-1.7.5.tar.bz2 && tar -jxvf libgcrypt-1.7.5.tar.bz2 && \
cd $SOURCES/libgcrypt-1.7.5 && autoreconf --force --install && mkdir builddir && cd builddir && ../configure --prefix=/opt/usr &&  make -j 8 && make install && \
rm $SOURCES/libgcrypt-1.7.5.tar.bz2 && rm -rfv $SOURCES/libgcrypt-1.7.5
RUN cd $SOURCES && wget http://ftp.gnu.org/gnu/libtasn1/libtasn1-4.10.tar.gz && tar -zxvf libtasn1-4.10.tar.gz && \
cd $SOURCES/libtasn1-4.10 && autoreconf --force --install && mkdir builddir && cd builddir && ../configure --prefix=/opt/usr &&  make -j 8 && make install &&\
 rm $SOURCES/libtasn1-4.10.tar.gz && rm -rfv $SOURCES/libtasn1-4.10
RUN cd $SOURCES && wget https://ftp.gnu.org/gnu/nettle/nettle-3.3.tar.gz && tar -zxvf nettle-3.3.tar.gz && \
cd $SOURCES/nettle-3.3 && autoreconf --force --install && mkdir builddir && cd builddir && ../configure --prefix=/opt/usr &&  make -j 8 && make install && \
rm $SOURCES/nettle-3.3.tar.gz && rm -rfv $SOURCES/nettle-3.3
RUN cd $SOURCES && wget http://p11-glue.freedesktop.org/releases/p11-kit-0.23.2.tar.gz && tar -zxvf p11-kit-0.23.2.tar.gz && \
cd $SOURCES/p11-kit-0.23.2 && autoreconf --force --install && mkdir builddir && cd builddir && ../configure --prefix=/opt/usr &&  make -j 8 && make install && \
rm $SOURCES/p11-kit-0.23.2.tar.gz && rm -rfv $SOURCES/p11-kit-0.23.2
RUN cd $SOURCES && wget ftp://ftp.gnutls.org/gcrypt/gnutls/v3.5/gnutls-3.5.10.tar.xz && tar -xvf gnutls-3.5.10.tar.xz && \
cd $SOURCES/gnutls-3.5.10 && autoreconf --force --install && mkdir builddir && cd builddir && ../configure --prefix=/opt/usr --with-included-libtasn1 &&  make -j 8 && make install && \
rm $SOURCES/gnutls-3.5.10.tar.xz && rm -rfv $SOURCES/gnutls-3.5.10
RUN cd $SOURCES && wget http://downloads.sourceforge.net/pcre/pcre-8.35.tar.bz2 && tar -jxvf pcre-8.35.tar.bz2 && \
cd $SOURCES/pcre-8.35 && ./configure --prefix=/opt/usr && make && make install && \
rm $SOURCES/pcre-8.35.tar.bz2 && rm -rfv $SOURCES/pcre-8.35
RUN cd $SOURCES && git clone git://git.gnupg.org/gpgme.git && \
cd $SOURCES/gpgme && autoreconf --force --install && mkdir builddir && cd builddir && ../configure --prefix=/opt/usr &&  make -j 8 && make install && rm -rfv $SOURCES/gpgme

 # Install rbenv and ruby-build
ADD ./Gemfile /Gemfile
RUN echo 'gem: --no-rdoc --no-ri' >> ~/.gemrc
RUN git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
RUN rbenv install 2.3.1
RUN echo 'eval "$(rbenv init -)"' >> ~/.bashrc && rbenv init -
ADD Gemfile /home/jenkins/
RUN cd ~ && rbenv local 2.3.1 && gem install bundler && bundle install --binstubs && bundle show rspec

#New python3
RUN sudo apt-get -y remove 'python3.*' 'sip.*'
RUN cd $SOURCES && wget https://www.python.org/ftp/python/3.5.3/Python-3.5.3.tar.xz && tar -xvf Python-3.5.3.tar.xz
RUN cd $SOURCES/Python-3.5.3 && ./configure --prefix=/opt/usr --enable-shared --enable-static &&  make -j 8 && make install && rm $SOURCES/Python-3.5.3.tar.xz && rm -rfv $SOURCES/Python-3.5.3
RUN cd $SOURCES && wget https://sourceforge.net/projects/pyqt/files/sip/sip-4.19.1/sip-4.19.1.tar.gz && tar -zxvf sip-4.19.1.tar.gz
RUN cd $SOURCES/sip-4.19.1 && python3 configure.py --destdir /opt/usr --incdir /opt/usr/include/python3.5 && make && make install
RUN pip3 install Sphinx clang PyOpenGL PyOpenGL_accelerate
ENV PYTHONPATH /opt/usr/lib/python3.5/site-packages:$PYTHONPATH

#FFMPEG deps
ADD x264.sh $SOURCES/
RUN cd $SOURCES && /bin/bash -x x264.sh
ADD x265.sh $SOURCES/
RUN cd $SOURCES && /bin/bash -x x265.sh

#FFMPEG non existant in trusty
ADD ffmpeg.sh $SOURCES/
RUN cd $SOURCES && /bin/bash -x ffmpeg.sh

# #Build newer gstreamer for sound stack
RUN sudo apt-get -y remove 'gstreamer.*'
RUN cd $SOURCES && wget 'https://gstreamer.freedesktop.org/src/gstreamer/gstreamer-1.10.4.tar.xz' && tar -xvf gstreamer-1.10.4.tar.xz && \
cd $SOURCES/gstreamer-1.10.4 && ./configure --prefix=/opt/usr --enable-shared --enable-gst-debug && make && make install && rm $SOURCES/gstreamer-1.10.4.tar.xz && rm -rfv $SOURCES/gstreamer-1.10.4
RUN cd $SOURCES && wget 'https://gstreamer.freedesktop.org/src/gst-plugins-base/gst-plugins-base-1.10.4.tar.xz' && tar -xvf gst-plugins-base-1.10.4.tar.xz && \
cd $SOURCES/gst-plugins-base-1.10.4 && ./configure --prefix=/opt/usr --enable-shared --enable-gst-debug && make && make install && rm $SOURCES/gst-plugins-base-1.10.4.tar.xz && rm -rfv $SOURCES/gst-plugins-base-1.10.4
RUN cd $SOURCES && wget 'https://gstreamer.freedesktop.org/src/gst-plugins-good/gst-plugins-good-1.10.4.tar.xz' && tar -xvf gst-plugins-good-1.10.4.tar.xz && \
cd $SOURCES/gst-plugins-good-1.10.4 && ./configure --prefix=/opt/usr --enable-shared --enable-gst-debug && make && make install && rm $SOURCES/gst-plugins-good-1.10.4.tar.xz && rm -rfv $SOURCES/gst-plugins-good-1.10.4

# # Build Qt5 from git and install to /opt/usr ( developer buid )
RUN sudo apt-get -y remove 'qt.*'
RUN wget http://qt.mirrors.tds.net/qt/archive/qt/5.8/5.8.0/single/qt-everywhere-opensource-src-5.8.0.tar.gz && tar -zxvf qt-everywhere-opensource-src-5.8.0.tar.gz
RUN cd qt-everywhere-opensource-src-5.8.0 && ./configure -v -release -opensource -confirm-license -dbus -openssl -rpath -qt-xcb -feature-accessibility -opengl desktop -system-sqlite -nomake examples -nomake tests -prefix /opt/usr && make && make install
RUN rm /qt-everywhere-opensource-src-5.8.0.tar.gz && rm -rfv /qt-everywhere-opensource-src-5.8.0
RUN wget http://download.qt.io/community_releases/5.8/5.8.0-final/qtwebkit-opensource-src-5.8.0.tar.xz && tar -xvf qtwebkit-opensource-src-5.8.0.tar.xz
RUN cd qtwebkit-opensource-src-5.8.0 && mkdir build && cd build && qmake PREFIX=/opt/usr ../WebKit.pro && make && make install
RUN rm /qtwebkit-opensource-src-5.8.0.tar.xz && rm -rfv /qtwebkit-opensource-src-5.8.0

# # Various external Qt relelated modules addons
RUN cd $SOURCES && git clone git://code.qt.io/qt/qtdeclarative.git && cd $SOURCES/qtdeclarative && git checkout 5.9 && \
cd $SOURCES/qtdeclarative &&  qmake PREFIX=/opt/usr . && make && make install && rm -rfv $SOURCES/qtdeclarative
RUN cd $SOURCES && git clone http://code.qt.io/qt/qtstyleplugins.git && \
cd $SOURCES/qtstyleplugins && qmake PREFIX=/opt/usr . && make && make install && rm -rfv $SOURCES/qtstyleplugins
RUN cd $SOURCES && git clone https://code.qt.io/cgit/qt/qtquick1.git && \
cd $SOURCES/qtquick1 && qmake PREFIX=/opt/usr . && make && make install && rm -rfv $SOURCES/qtquick1
RUN cd $SOURCES && git clone https://github.com/flavio/qjson && \
cd $SOURCES/qjson &&  cmake -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX:PATH=/opt/usr && make && make install && rm -rfv $SOURCES/qjson
RUN cd $SOURCES && wget 'https://gstreamer.freedesktop.org/src/qt-gstreamer/qt-gstreamer-1.2.0.tar.xz' && tar -xvf qt-gstreamer-1.2.0.tar.xz && \
cd $SOURCES/qt-gstreamer-1.2.0 &&  cmake -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX:PATH=/opt/usr -DQT_VERSION=5 -DCMAKE_REQUIRED_INCLUDES=/opt/usr/include/gstreamer-1.0/ \
-DQTGSTREAMER_STATIC=OFF -DQTGSTREAMER_EXAMPLES=OFF && make && make install && rm $SOURCES/qt-gstreamer-1.2.0.tar.xz && rm -rfv $SOURCES/qt-gstreamer-1.2.0
# RUN cd $SOURCES && wget https://www.riverbankcomputing.com/static/Downloads/PyQt5/PyQt5_gpl-5.8.3.dev1704051437.tar.gz && tar -zxvf PyQt5_gpl-5.8.3.dev1704051437.tar.gz && \
# cd $SOURCES/PyQt5_gpl-5.8.3.dev1704051437 && /opt/usr/bin/python3 configure.py --confirm-license --verbose --destdir /opt/usr --sip /opt/usr/bin/sip --sip-incdir /opt/usr/include/python3.5/ \
# -q /opt/usr/bin/qmake -c -j 4 LIBDIR_QT=/opt/usr/lib STRIP="" MOC=/usr/bin/moc --qmake="/opt/usr/bin/qmake" \
# LIBS_OPENGL="" LIBS_X11="" LIBS_THREAD="" -m /opt/usr/lib/python3.5/config-3.5m \
# -d /opt/usr/lib/python3.5/dist-packages	--dbus /usr/include/dbus-1.0 --no-designer-plugin --no-qml-plugin && make -j8 && make install && \
# rm -rfv $SOURCES/PyQt5_gpl-5.8.3.dev1704051437 && rm $SOURCES/PyQt5_gpl-5.8.3.dev1704051437.tar.gz && rm $SOURCES/sip-4.19.1.tar.gz && rm -rfv $SOURCES/sip-4.19.1
RUN cd $SOURCES && wget http://download.kde.org/stable/qca/2.1.1/src/qca-2.1.1.tar.xz && tar -xvf qca-2.1.1.tar.xz && \
cd $SOURCES/qca-2.1.1 && mkdir build && cd build && cmake -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX:PATH=/opt/usr .. && cmake --build . && cmake --build . --target install && \
rm $SOURCES/qca-2.1.1.tar.xz && rm -rfv $SOURCES/qca-2.1.1
RUN cd $SOURCES && git clone https://github.com/ayoy/qoauth && \
cd $SOURCES/qoauth && sed s#/usr#/opt/usr# -i src/src.pro  && sed s#/lib64#/lib# -i src/src.pro&& qmake ' "QT += widgets" "QT += webkitwidgets" "CONFIG += crypto" "DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x000000"' src/src.pro \
&& make -j8 && make install && rm -rfv $SOURCES/qoauth
RUN cd $SOURCES && svn export svn://svn.code.sf.net/p/qwt/code/branches/qwt-6.1 && cd $SOURCES/qwt-6.1 && qmake -set prefix '/opt' && qmake qwt.pro && \
make -j8 && INSTALL_ROOT=/opt make install && rm -rfv $SOURCES/qwt-6.1 && \
mv /opt/usr/local/qwt-6.1.4-svn/include/* /opt/usr/include/ && \
mv /opt/usr/local/qwt-6.1.4-svn/lib/* /opt/usr/lib/ && \
mv /opt/usr/local/qwt-6.1.4-svn/plugins/designer/* /opt/usr/plugins/designer/ && rmdir /opt/usr/local/qwt-6.1.4-svn/plugins/designer
RUN cd $SOURCES && git clone https://github.com/steveire/grantlee && \
cd $SOURCES/grantlee && mkdir build && cd build && cmake -DCMAKE_INSTALL_PREFIX:PATH=/opt/usr CMAKE_BUILD_TYPE=Release .. && cmake --build . && cmake --build . --target install \
&& rm -rfv $SOURCES/grantlee
RUN cd $SOURCES && wget https://poppler.freedesktop.org/poppler-0.51.0.tar.xz && tar -xvf poppler-0.51.0.tar.xz && \
cd $SOURCES/poppler-0.51.0 && mkdir build && cd build && ../configure --prefix=/opt/usr -sysconfdir=/opt/etc --disable-static --enable-build-type=release \
--enable-cmyk --enable-xpdf-headers --enable-poppler-qt5 && make && make install && rm $SOURCES/poppler-0.51.0.tar.xz && rm -rfv $SOURCES/poppler-0.51.0
RUN wget https://www.gnupg.org/ftp/gcrypt/gnupg/gnupg-2.1.17.tar.bz2 && tar -jxvf gnupg-2.1.17.tar.bz2
RUN cd gnupg-2.1.17 && autoreconf --force --install && mkdir builddir && cd builddir && ../configure --prefix=/opt/usr &&  make -j 8 && make install && rm /gnupg-2.1.17.tar.bz2 && rm -rfv /gnupg-2.1.17
# RUN git clone http://code.qt.io/qt/qtwebkit.git && cd qtwebkit && git checkout 5.9 && \
# mkdir build && cd build && qmake ' "CONFIG += shared" ' ../WebKit.pro && make && make install && rm -rfv /source/qtwebkit
