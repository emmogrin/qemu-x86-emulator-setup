#!/data/data/com.termux/files/usr/bin/bash

echo "[1/4] Updating Termux..."
pkg update -y && pkg upgrade -y

echo "[2/4] Installing QEMU and dependencies..."
pkg install -y qemu-system-x86_64 wget curl unzip proot pulseaudio

echo "[3/4] Downloading Debian x86_64 image (minimal)..."
mkdir -p ~/qemu-debian && cd ~/qemu-debian

# Download prebuilt Debian disk image
wget https://dl-cdn.alpinelinux.org/alpine/v3.18/releases/x86_64/alpine-extended-3.18.4-x86_64.iso -O debian.iso

# Download SeaBIOS (to help QEMU boot ISO)
wget https://github.com/bmaron/qemu-seabios-android/releases/download/v1.0/bios.bin -O bios.bin

echo "[4/4] Creating launch script..."
cat > start.sh << 'EOF'
#!/bin/bash
qemu-system-x86_64 \
  -bios bios.bin \
  -m 2048 \
  -cdrom debian.iso \
  -boot d \
  -nographic \
  -net nic -net user \
  -vga std
EOF

chmod +x start.sh

echo
echo "✅ Done! To boot Debian ISO:"
echo "cd ~/qemu-debian && ./start.sh"
