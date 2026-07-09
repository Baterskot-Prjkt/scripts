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
git clone https://github.com/Baterskot-Prjkt/Heaven vendor/lineage-priv/keys

# Clone DolbyAtmos
git clone https://github.com/swiitch-OFF-Lab/packages_apps_DolbyUI.git packages/apps/DolbyUI -b 16.0 --depth 1
git clone https://github.com/swiitch-OFF-Lab/hardware_dolby.git hardware/dolby -b sony-1.5 --depth 1

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
