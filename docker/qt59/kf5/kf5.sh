#!/bin/bash
git clone https://github.com/libgit2/libgit2
cd libgit2 && mkdir build && cd builld && \
cmake .. -DCMAKE_INSTALL_PREFIX=/opt/usr
cmake --build . --target install

for package in extra-cmake-modules attica kconfig kwidgetsaddons karchive kcompletion kcoreaddons kcodecs kauth kwindowsystem kcrash \
ki18n kdoctools kdbusaddons kglobalaccel kguiaddons kidletime kimageformats kitemmodels kjs kplotting syntax-highlighting \
kconfigwidgets kitemviews kiconthemes sonnet kwayland prison threadweaver kcrash kdnssd kpty \
kservice ktextwidgets kxmlgui kbookmarks solid kjobwidgets phonon phonon-gstreamer knotifications kwallet kio kinit kded kparts \
kactivities kdesignerplugin kunitconversion kpackage kdeclarative kcmutils kdesu  kdewebkit kemoticons kjsembed kmediaplayer \
kdelib4support knewstuff knotifications knotifyconfig kross ktexteditor framework-integration kapidox \
khtml plasma-framework kdecoration krunner
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

find . -type f -executable -exec strip {} \; || true
