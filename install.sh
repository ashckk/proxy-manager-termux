#!/data/data/com.termux/files/usr/bin/bash

# Proxy Manager - Quick Installer

GREEN='\033[1;32m'
RED='\033[1;31m'
NC='\033[0m'

echo -e "${GREEN}[*] Installing Proxy Manager...${NC}"

# Install dependencies
pkg install -y curl git

# Clone the repo
cd "$HOME"
rm -rf proxy-manager-termux
git clone https://github.com/ashckk/proxy-manager-termux.git

# Make executable
chmod +x ~/proxy-manager-termux/proxy.sh

# Create symlink
ln -sf ~/proxy-manager-termux/proxy.sh /data/data/com.termux/files/usr/bin/proxy-manager

echo ""
echo -e "${GREEN}[✓] Proxy Manager installed successfully!${NC}"
echo -e "${GREEN}[*] Run 'proxy-manager' to start${NC}"
echo ""
