# Android kernel build scripts for Planet Computers devices

These scripts facilitate configuring and compiling the Android kernel, particularly for the Astro Slide.

The process is Dockerised for ease of use, and to allow reproducible builds.

They can be run within this repo, or the built Docker image can used elsewhere.

A boot image contains more than just the kernel, so this utilises an existing boot image, replacing the kernel within it.

## Configure

To configure the kernel, run:

```bash
./auto/menuconfig
```

## Build

To build the kernel, run:

```bash
./auto/build
```

The boot image is output to `out/boot.img`.
