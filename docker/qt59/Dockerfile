FROM ubuntu:14.04
RUN echo "deb http://us.archive.ubuntu.com/ubuntu/ trusty main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb-src http://ca.archive.ubuntu.com/ubuntu/ trusty main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://ca.archive.ubuntu.com/ubuntu/ trusty-updates main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb-src http://ca.archive.ubuntu.com/ubuntu/ trusty-updates main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://us.archive.ubuntu.com/ubuntu/ trusty-backports main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb-src http://us.archive.ubuntu.com/ubuntu/ trusty-backports main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://apt.llvm.org/trusty/ llvm-toolchain-trusty-3.8 main" >> /etc/apt/sources.list
RUN echo "deb-src http://apt.llvm.org/trusty/ llvm-toolchain-trusty-3.8 main" >> /etc/apt/sources.list
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main" >> /etc/apt/sources.list


#link to bash
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN ln -s -f /bin/true /usr/bin/chfn
RUN apt-get update && apt-get -y install wget
RUN wget -q -O- https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN apt-get update && apt-get -y upgrade && apt-get -y build-dep libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libgstreamer-plugins-good1.0-dev python3-dev
RUN apt-get update && apt-get -y --force-yes install \
'^libxcb.*-dev' \
bison \
bzr \
chrpath \
clang-3.8 \
festival \
festival-dev \
firebird-dev \
flex \
freeglut3-dev \
freetds-dev \
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
libdouble-conversion-dev \
libfontconfig1-dev \
libfreetype6-dev \
libgbm-dev \
libgit2-dev \
libgl1-mesa-dev \
libgles2-mesa-dev \
libglew-dev \
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
libwayland-client0 \
libwayland-dev \
libwayland-egl1-mesa \
libwayland-server0 \
libwebp-dev \
libx11-xcb-dev \
libxcomposite-dev \
libxext-dev \
libxi-dev \
libxkbcommon-dev \
libxkbcommon-x11-dev \
libxml2-dev \
libxrender-dev \
libxslt1-dev \
lldb-3.8 \
llvm-3.8 \
llvm-3.8-dev \
mesa-common-dev \
ml-lex \
pkg-config \
postgresql-9.4 \
postgresql-contrib-9.4 \
postgresql-server-dev-9.4 \
publicsuffix \
python-dev \
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

# Set up for GCC options ( try gcc6 )
RUN add-apt-repository -y ppa:ubuntu-toolchain-r/test && apt-get update && apt-get -y install gcc-4.9 g++-4.9 gcc-5 g++-5 gcc-6 g++-6 && \
update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.9 10 && \
update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-5 20 && \
update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-6 30 && \
update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.9 10 && \
update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-5 20 && \
update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-6 30 && \
update-alternatives --set gcc "/usr/bin/gcc-5" && \
update-alternatives --set g++ "/usr/bin/g++-5" && \
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
ENV CPATH /opt/usr/include/gstreamer-1.0:/opt/usr/include:/opt/usr/include/dbus-1.0:$CPATH
ENV SOURCES /
ENV ACLOCAL_PATH = /opt/usr/share/aclocal:/usr/share/aclocal

# Create jenkins user
RUN groupadd -g 1000 jenkins
RUN useradd -m -u 1000 -g 1000 -d /home/jenkins jenkins
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
ENV CPATH /opt/usr/include/gstreamer-1.0:/opt/usr/include:/opt/usr/include/python3.5:$CPATH
ENV SOURCES /source
ENV QMAKE_CFLAGS_ISYSTEM ''
ENV PYTHONPATH /opt/usr/lib/python3.5/site-packages:$PYTHONPATH

 # Install rbenv and ruby-build
ADD ./Gemfile /Gemfile
RUN echo 'gem: --no-rdoc --no-ri' >> ~/.gemrc
RUN git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
RUN rbenv install 2.3.1
RUN echo 'eval "$(rbenv init -)"' >> ~/.bashrc && rbenv init -
ADD Gemfile /home/jenkins/
RUN cd ~ && rbenv local 2.3.1 && gem install bundler && bundle install --binstubs && bundle show rspec

RUN https://raw.githubusercontent.com/appimage-packages/appimage-template/master/docker/qt59/deps.sh
RUN chown -R root:root deps.sh
ADD deps.sh $SOURCES/
RUN cd $SOURCES && /bin/bash -x deps.sh

# # Build Qt5 from git and install to /opt/usr ( developer buid )
RUN sudo apt-get -y remove 'qt.*'
RUN wget https://raw.githubusercontent.com/appimage-packages/appimage-template/master/docker/qt59/qt5.sh && chown root:root qt5.sh
RUN chown -R root:root qt5.sh
ADD qt5.sh $SOURCES/
RUN cd $SOURCES && /bin/bash -x qt5.sh
RUN wget https://raw.githubusercontent.com/appimage-packages/appimage-template/master/docker/qt59/qt5deps.sh && chown root:root qt5deps.sh
RUN chown -R root:root qt5deps.sh
ADD qt5deps.sh $SOURCES/
RUN cd $SOURCES && /bin/bash -x qt5deps.sh
RUN find . -type f -executable -exec strip {} \;
