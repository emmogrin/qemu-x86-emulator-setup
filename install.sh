#!/data/data/com.termux/files/usr/bin/bash

# Step 1: Update Termux and install dependencies
echo "[1/5] Updating Termux..."
pkg update -y && pkg upgrade -y

echo "[2/5] Installing QEMU and dependencies..."
pkg install -y qemu-system-x86_64 wget curl unzip proot pulseaudio

# Step 2: Set up QEMU environment
echo "[3/5] Setting up QEMU environment..."
mkdir -p ~/qemu-debian && cd ~/qemu-debian

# Step 3: Download minimal Debian ISO and SeaBIOS
echo "[3.1] Downloading minimal Debian ISO..."
wget -q --show-progress https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-12.5.0-amd64-netinst.iso -O debian.iso

echo "[3.2] Downloading SeaBIOS..."
wget -q --show-progress https://github.com/bmaron/qemu-seabios-android/releases/download/v1.0/bios.bin -O bios.bin

# Step 4: Create the start script for running QEMU
echo "[4/5] Creating one-click boot script..."
cat > start.sh << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash
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

# Completion message
echo
echo "✅ Done! To boot into Debian:"
echo "cd ~/qemu-debian && ./start.sh"
