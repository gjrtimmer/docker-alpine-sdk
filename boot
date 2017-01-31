#!/bin/bash

# Update APK
sudo apk update
sudo apk upgrade

sed "s|local size=\$(du|local size=\$(sync\;du|" -i /usr/bin/abuild

# EOF