#!/bin/bash

# Clean up
rm -rf .repo/local_manifests
rm -rf device/xiaomi/fog
rm -rf device/xiaomi/fog-kernel
rm -rf vendor/xiaomi/fog
rm -rf hardware/xiaomi

# Init Source
repo init --depth=1 -u https://github.com/Baterskot-Prjkt/pixelos_manifest.git -b sixteen-qpr2 --git-lfs
/opt/crave/resync.sh

# Device Specific
git clone https://github.com/Baterskot-Prjkt/device_xiaomi_fog.git -b pixelos-16qpr2 device/xiaomi/fog
git clone https://github.com/Baterskot-Prjkt/device_xiaomi_fog-kernel.git -b motregen device/xiaomi/fog-kernel
git clone https://github.com/Baterskot-Prjkt/vendor_xiaomi_fog.git -b baklava-and-beyond vendor/xiaomi/fog 
git clone https://github.com/LineageOS/android_hardware_xiaomi.git -b lineage-23.2 hardware/xiaomi

export BUILD_USERNAME=Butterscotch
export BUILD_HOSTNAME=Heaven 

# Build
. build/envsetup.sh
breakfast fog
make installclean
m pixelos

# Upload files to gofile
echo "Upload to gofile will be started..."
if [ -f out/target/product/fog/*.zip ]; then
  wget https://raw.githubusercontent.com/lordgaruda/GoFile-Upload/refs/heads/master/upload.sh
  chmod +x upload.sh ; ./upload.sh out/target/product/fog/*.zip
fi
