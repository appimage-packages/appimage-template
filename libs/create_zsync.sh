#!/bin/bash
DATE=$(date +"%Y%m%d")
cd appimage/
FILE = $(ls)
 zsinkcmake
  echo "Embedding update information into ${FILE}..."
  # Clear ISO 9660 Volume Descriptor #1 field "Application Used"
  # (contents not defined by ISO 9660) and write URL there
  dd if=/dev/zero of="${FILE}" bs=1 seek=33651 count=512 conv=notrunc
  # Example for next line: Subsurface-_latestVersion-x86_64.AppImage
  NAMELATESTVERSION=$(echo $(basename ${FILE}) | sed -e "s|${VERSION}|_latestVersion|g")
  # Example for next line: bintray-zsync|probono|AppImages|Subsurface|Subsurface-_latestVersion-x86_64.AppImage.zsync
  LINE="s3-zsync|${NAMELATESTVERSION}.zsync"
  echo "${LINE}" | dd of="${FILE}" bs=1 seek=33651 count=512 conv=notrunc
  echo ""
  echo "Uploading and publishing zsync file for ${FILE}..."
  # Workaround for:
  # https://github.com/probonopd/zsync-curl/issues/1
zsyncmake -u https://s3-eu-central-1.amazonaws.com/ds9-apps/$(basename ${FILE}) ${FILE} -o ${FILE}.zsync
