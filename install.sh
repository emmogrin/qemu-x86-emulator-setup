#!/data/data/com.termux/files/usr/bin/bash

echo "[1/3] Updating Termux..."
pkg update -y && pkg upgrade -y

echo "[2/3] Installing QEMU and wget..."
pkg install -y qemu-system-x86_64 wget curl unzip

echo "[3/3] Downloading Ubuntu x86_64 image..."
mkdir -p qemu-ubuntu && cd qemu-ubuntu
wget https://cloud-images.ubuntu.com/minimal/releases/focal/release/ubuntu-20.04-minimal-cloudimg-amd64.img

echo "Booting with QEMU..."
qemu-system-x86_64 \
  -m 2048 \
  -smp cores=2 \
  -hda ubuntu-20.04-minimal-cloudimg-amd64.img \
  -net nic -net user \
  -enable-kvm \
  -nographic

echo "Use CTRL+A X to exit QEMU session."
