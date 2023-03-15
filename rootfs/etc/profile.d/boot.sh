#!/bin/bash

# Update APK
sudo apk update
sudo apk upgrade

# Temporary fix
# Required for alpine abuild bug #4727
# https://bugs.alpinelinux.org/issues/4727
#
# Description:
# On BTRFS volumes the journal might not have catched up on writing the
# changes to disk, this results in the scenario that when packaging some APK,
# the package size of its meta gets set to 0.
#
# This will have the result that when you install the APK,
# the files are present within the apk file but are not placed on the target
# because apk thinks its a virtual package due to a size of 0 within its metadata.
#
# Permanent fix submitted on github:
# https://github.com/alpinelinux/aports/pull/814
#sudo sed "s|local size=\$(du|local size=\$(sync\;du|" -i /usr/bin/abuild

# EOF