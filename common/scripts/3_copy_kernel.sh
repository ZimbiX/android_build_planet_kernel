#!/usr/bin/env bash

set -Eeuo pipefail

# unpack boot.img
mkdir -p /var/tmp/bootimg
cp "${1:-/opt/common/files/android_boot_a_astro.img}" /var/tmp/bootimg/boot.img
/opt/unpackbootimg/unpackbootimg -i /var/tmp/bootimg/boot.img -o /var/tmp/bootimg

# overwrite kernel
cp \
  /usr/src/kernel/out/arch/arm64/boot/Image.gz \
  /var/tmp/bootimg/boot.img-kernel

# repack boot.img
/opt/unpackbootimg/mkbootimg \
  --base "$(cat /var/tmp/bootimg/boot.img-base)" \
  --board "$(cat /var/tmp/bootimg/boot.img-board)" \
  --cmdline "$(cat /var/tmp/bootimg/boot.img-cmdline)" \
  --dtb /var/tmp/bootimg/boot.img-dtb \
  --dtb_offset "$(cat /var/tmp/bootimg/boot.img-dtb_offset)" \
  --hashtype "$(cat /var/tmp/bootimg/boot.img-hashtype)" \
  --header_version "$(cat /var/tmp/bootimg/boot.img-header_version)" \
  --kernel /var/tmp/bootimg/boot.img-kernel \
  --kernel_offset "$(cat /var/tmp/bootimg/boot.img-kernel_offset)" \
  --os_patch_level "$(cat /var/tmp/bootimg/boot.img-os_patch_level)" \
  --os_version "$(cat /var/tmp/bootimg/boot.img-os_version)" \
  --pagesize "$(cat /var/tmp/bootimg/boot.img-pagesize)" \
  --ramdisk /var/tmp/bootimg/boot.img-ramdisk \
  --ramdisk_offset "$(cat /var/tmp/bootimg/boot.img-ramdisk_offset)" \
  --second_offset "$(cat /var/tmp/bootimg/boot.img-second_offset)" \
  --tags_offset "$(cat /var/tmp/bootimg/boot.img-tags_offset)" \
  --output /out/boot.img
