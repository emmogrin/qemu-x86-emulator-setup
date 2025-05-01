#!/data/data/com.termux/files/usr/bin/bash

echo "[1/4] Updating Termux..."
pkg update -y && pkg upgrade -y

echo "[2/4] Installing QEMU and dependencies..."
pkg install -y qemu-system-x86_64 wget curl unzip proot pulseaudio

echo "[3/4] Downloading Debian x86_64 image..."
mkdir -p qemu-debian && cd qemu-debian

# Download rootfs
wget https://dl-cdn.alpinelinux.org/alpine/v3.18/releases/x86_64/alpine-minirootfs-3.18.4-x86_64.tar.gz -O rootfs.tar.gz

echo "[4/4] Setting up QEMU boot..."
# Download a minimal Linux kernel
wget https://github.com/dhruvvyas90/qemu-rpi-kernel/raw/master/kernel-qemu-4.4.34-jessie -O vmlinuz

# Create QEMU launch script
cat > start.sh << 'EOF'
#!/bin/bash
qemu-system-x86_64 \
  -m 2048 \
  -kernel vmlinuz \
  -initrd initrd.img \
  -hda rootfs.img \
  -append "root=/dev/sda console=ttyS0" \
  -nographic \
  -net nic -net user
EOF

chmod +x start.sh

echo "Done! To start Debian x86_64, run:"
echo "cd ~/qemu-x86-emulator-setup/qemu-debian && ./start.sh"
