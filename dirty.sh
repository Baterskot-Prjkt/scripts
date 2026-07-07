#!/bin/bash

#fix
rm -rf packages/apps/Settings
git clone --depth=1 https://github.com/Baterskot-Prjkt/android_packages_apps_Settings packages/apps/Settings

export BUILD_USERNAME=Butterscotch
export BUILD_HOSTNAME=Heaven 

# Build
. build/envsetup.sh
breakfast fog
m pixelos

# Upload files to gofile
echo "Upload to gofile will be started..."
if [ -f out/target/product/fog/*.zip ]; then
  wget https://raw.githubusercontent.com/lordgaruda/GoFile-Upload/refs/heads/master/upload.sh
  chmod +x upload.sh ; ./upload.sh out/target/product/fog/*202607*.zip
fi
