#!/bin/bash

for package in libkdegames kirigmi libbluedevil libkpeople libqapt libqgit2 networkmanager-qt purpose \
libgravatar libkcddb libkcompactdisc libkdcraw libkdepim libkeduvocdocument libkexiv2 libkface libkgapi libkgeomap libkipi \
libkleo libmahjongg libkomparediff2 libksane akonadi-calendar akonadi-calendar-tools akonadi-contacts akonadi-import-wizard \
akonadi-mime akonadi-notes akonadi-search akonadiconsole akonadi pimcommon libksieve
do
  git clone http://anongit.kde.org/$package
  cd $package
  case $package in
   'breeze' )
     if mkdir build && cd build && cmake -DCMAKE_INSTALL_PREFIX:PATH=/opt/usr/ -DCMAKE_BUILD_TYPE=RelWithDebInfo -DBUILD_TESTING=FALSE -DBINARY_ICONS_RESOURCE=ON ../; then
       make -j8
       make install
     else
       error_exit "$LINENO: An error has occurred.. Aborting."
     fi
    ;;
    'breeze-icons' )
    if mkdir build && cd build && cmake -DCMAKE_INSTALL_PREFIX:PATH=/opt/usr/ -DCMAKE_BUILD_TYPE=RelWithDebInfo -DBUILD_TESTING=FALSE -DBINARY_ICONS_RESOURCE=ON \
     -DWITH_DECORATIONS=OFF ../; then
      make -j8
      make install
    else
      error_exit "$LINENO: An error has occurred.. Aborting."
    fi
    ;;
    'phonon-gstreamer' )
    if mkdir build && cd build && cmake -DCMAKE_INSTALL_PREFIX:PATH=/opt/usr/ -DCMAKE_BUILD_TYPE=RelWithDebInfo -DBUILD_TESTING=FALSE  -DPHONON_LIBRARY_PATH=/opt/usr/plugins \
    -DBUILD_TESTING=OFF -DPHONON_BUILD_PHONON4QT5=ON \
    -DPHONON_INSTALL_QT_EXTENSIONS_INTO_SYSTEM_QT=TRUE ../; then
      make -j8
      make install
    else
      error_exit "$LINENO: An error has occurred.. Aborting."
    fi
    ;;
    'phonon' )
    if mkdir build && cd build && cmake -DCMAKE_INSTALL_PREFIX:PATH=/opt/usr/ -DCMAKE_BUILD_TYPE=RelWithDebInfo -DBUILD_TESTING=FALSE  -DPHONON_LIBRARY_PATH=/opt/usr/plugins \
    -DBUILD_TESTING=OFF -DPHONON_BUILD_PHONON4QT5=ON \
    -DPHONON_INSTALL_QT_EXTENSIONS_INTO_SYSTEM_QT=TRUE ../; then
      make -j8
      make install
    else
      error_exit "$LINENO: An error has occurred.. Aborting."
    fi
    ;;
    * )
    if mkdir build && cd build && cmake -DCMAKE_INSTALL_PREFIX:PATH=/opt/usr/ -DCMAKE_BUILD_TYPE=RelWithDebInfo -DBUILD_TESTING=FALSE ../; then
      make -j8
      make install
    else
      error_exit "$LINENO: An error has occurred.. Aborting."
    fi
    ;;
  esac
  cd ../..
  rm -rf $package
done
