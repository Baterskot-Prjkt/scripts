#!/bin/bash

#fix
rm -rf packages/apps/Settings
git clone --depth=1 https://github.com/Baterskot-Prjkt/android_packages_apps_Settings packages/apps/Settings

export BUILD_USERNAME=Butterscotch
export BUILD_HOSTNAME=Heaven 

# Build
. build/envsetup.sh
breakfast fog
make installclean
m pixelos

# Upload files to gofile
echo "Upload to gofile will be started..."

wget -q https://raw.githubusercontent.com/lordgaruda/GoFile-Upload/refs/heads/master/upload.sh
chmod +x upload.sh

for file in out/target/product/fog/*.zip; do
  if [ -f "$file" ]; then
    echo "Uploading: $file"
    ./upload.sh "$file"
  fi
done
