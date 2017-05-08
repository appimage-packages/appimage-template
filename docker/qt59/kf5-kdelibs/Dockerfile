FROM sgclark/trusty-qt59-kf5

RUN apt-get -y install libpolkit-gobject-1-dev libpolkit-backend-1-dev libpolkit-agent-1-dev libperl-dev libjpeg-dev libgif-dev libpng12-dev \
libperl-dev libpcre3-dev libxcb-keysyms1-dev libgit2-dev libacl1-dev libkrb5-dev libxml2-dev libxslt1-dev zlib1g-dev \
libx11-xcb-dev libcap-dev libxcb1-dev libxcb-keysyms1-dev libxcb-xtest0-dev libepoxy-dev libutempter-dev \
libaspell-dev libhunspell-dev hspell libvoikko-dev bzip2 liblzma-dev media-player-info libavahi-common-dev libgamin-dev \
libqrencode-dev libxtables10 libatm1 libdmtx-dev
# KF5
RUN rm kf5*
RUN wget https://raw.githubusercontent.com/appimage-packages/appimage-template/master/docker/qt59/kf5-kdelibs/kf5.sh
RUN chown -R root:root kf5.sh
RUN cd $SOURCES && /bin/bash -x kf5.sh
RUN rm kf5.sh
