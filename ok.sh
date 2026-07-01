#!/bin/bash

# init source
repo init -u https://github.com/Baterskot-Prjkt/pixelos_manifest.git -b sixteen-qpr2 --git-lfs
git clone https://github.com/Baterskot-Prjkt/local_manifest -b lineage-23.0-v .repo/local_manifests
/opt/crave/resync.sh # crave repo sync


export BUILD_USERNAME=Dityay 
export BUILD_HOSTNAME=crave 

# build start
. build/envsetup.sh
breakfast fog
m pixelos

# Upload files to gofile
echo "Upload to gofile will be started..."
if [ -f out/target/product/fog/*.zip ]; then
  wget https://raw.githubusercontent.com/lordgaruda/GoFile-Upload/refs/heads/master/upload.sh
  chmod +x upload.sh ; ./upload.sh out/target/product/fog/202607.zip
fi
