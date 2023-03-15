#!/bin/bash

# Update APK
sudo apk update
sudo apk upgrade --force-overwrite --no-cache --prune --purge

echo "Upgrade complete"
