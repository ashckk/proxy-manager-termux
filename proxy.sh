#!/data/data/com.termux/files/usr/bin/bash

# ============================================
#   Proxy Manager - Termux Proxy Toggle
# ============================================

# Proxy Configuration
PROXY_IP="151.247.123.128"
PROXY_PORT="49155"
PROXY_USER="theninthroomagency09hVp"
PROXY_PASS="S7bbJfgCE2"
PROXY_FULL="socks5://${PROXY_USER}:${PROXY_PASS}@${PROXY_IP}:${PROXY_PORT}"

# Status File
STATUS_FILE="$HOME/.proxy_status"

# Colors
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
NC='\033[0m'

show_menu() {
    clear
    echo -e "${CYAN}╔══════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║       Proxy Manager - Termux             ║${NC}"
    echo -e "${CYAN}╠══════════════════════════════════════════╣${NC}"
    echo -e "${CYAN}║  Server: ${PROXY_IP}:${PROXY_PORT}        ║${NC}"
    echo -e "${CYAN}╠══════════════════════════════════════════╣${NC}"

    if [ -f "$STATUS_FILE" ]; then
        STATUS=$(cat "$STATUS_FILE")
    else
        STATUS="OFF"
    fi

    if [ "$STATUS" = "ON" ]; then
        echo -e "${CYAN}║  Status: ${GREEN}● ON${NC}                        ${CYAN}║${NC}"
    else
        echo -e "${CYAN}║  Status: ${RED}○ OFF${NC}                       ${CYAN}║${NC}"
    fi

    echo -e "${CYAN}╠══════════════════════════════════════════╣${NC}"
    echo -e "${CYAN}║  ${GREEN}1)${NC} ON    - Enable proxy                ${CYAN}║${NC}"
    echo -e "${CYAN}║  ${RED}2)${NC} OFF   - Disable proxy               ${CYAN}║${NC}"
    echo -e "${CYAN}║  ${YELLOW}3)${NC} STATUS - Show current status         ${CYAN}║${NC}"
    echo -e "${CYAN}║  ${CYAN}4)${NC} TEST   - Test proxy connection        ${CYAN}║${NC}"
    echo -e "${CYAN}║  ${CYAN}5)${NC} EXIT   - Exit                         ${CYAN}║${NC}"
    echo -e "${CYAN}╚══════════════════════════════════════════╝${NC}"
    echo ""
}

enable_proxy() {
    echo -e "${YELLOW}[*] Enabling proxy...${NC}"

    export http_proxy="$PROXY_FULL"
    export https_proxy="$PROXY_FULL"
    export all_proxy="$PROXY_FULL"
    export HTTP_PROXY="$PROXY_FULL"
    export HTTPS_PROXY="$PROXY_FULL"
    export ALL_PROXY="$PROXY_FULL"

    # Save to curl config
    echo "proxy = $PROXY_FULL" > ~/.curlrc

    # Save to shell profile
    PROFILE="$HOME/.bashrc"
    if [ -f "$HOME/.zshrc" ]; then
        PROFILE="$HOME/.zshrc"
    fi

    # Remove old proxy lines
    sed -i '/# ProxyManager START/,/# ProxyManager END/d' "$PROFILE" 2>/dev/null

    # Add new proxy lines
    cat >> "$PROFILE" << 'EOF'
# ProxyManager START
export http_proxy="socks5://theninthroomagency09hVp:S7bbJfgCE2@151.247.123.128:49155"
export https_proxy="socks5://theninthroomagency09hVp:S7bbJfgCE2@151.247.123.128:49155"
export all_proxy="socks5://theninthroomagency09hVp:S7bbJfgCE2@151.247.123.128:49155"
export HTTP_PROXY="socks5://theninthroomagency09hVp:S7bbJfgCE2@151.247.123.128:49155"
export HTTPS_PROXY="socks5://theninthroomagency09hVp:S7bbJfgCE2@151.247.123.128:49155"
export ALL_PROXY="socks5://theninthroomagency09hVp:S7bbJfgCE2@151.247.123.128:49155"
# ProxyManager END
EOF

    echo "ON" > "$STATUS_FILE"

    echo -e "${GREEN}[✓] Proxy enabled successfully!${NC}"
    echo -e "${GREEN}    all_proxy = $PROXY_FULL${NC}"
}

disable_proxy() {
    echo -e "${YELLOW}[*] Disabling proxy...${NC}"

    unset http_proxy
    unset https_proxy
    unset all_proxy
    unset HTTP_PROXY
    unset HTTPS_PROXY
    unset ALL_PROXY

    # Remove from curl config
    rm -f ~/.curlrc

    # Remove from shell profile
    PROFILE="$HOME/.bashrc"
    if [ -f "$HOME/.zshrc" ]; then
        PROFILE="$HOME/.zshrc"
    fi
    sed -i '/# ProxyManager START/,/# ProxyManager END/d' "$PROFILE" 2>/dev/null

    echo "OFF" > "$STATUS_FILE"

    echo -e "${RED}[✓] Proxy disabled successfully!${NC}"
}

show_status() {
    echo ""
    if [ -f "$STATUS_FILE" ] && [ "$(cat "$STATUS_FILE")" = "ON" ]; then
        echo -e "${GREEN}● Proxy Status: ON${NC}"
        echo -e "  all_proxy = ${all_proxy:-not set}"
    else
        echo -e "${RED}○ Proxy Status: OFF${NC}"
    fi
}

test_proxy() {
    echo -e "${YELLOW}[*] Testing proxy connection...${NC}"
    echo ""

    if [ -f "$STATUS_FILE" ] && [ "$(cat "$STATUS_FILE")" = "ON" ]; then
        echo -e "${GREEN}[*] Testing with curl:${NC}"
        curl -x "$PROXY_FULL" -s -o /dev/null -w "HTTP Status: %{http_code}\nTime: %{time_total}s\n" https://httpbin.org/ip 2>&1

        echo ""
        echo -e "${GREEN}[*] Your IP through proxy:${NC}"
        curl -x "$PROXY_FULL" -s https://httpbin.org/ip 2>&1
    else
        echo -e "${RED}[!] Proxy is not enabled. Enable it first.${NC}"
    fi
    echo ""
}

while true; do
    show_menu
    read -p "  Select [1-5]: " choice
    case $choice in
        1)
            enable_proxy
            sleep 2
            ;;
        2)
            disable_proxy
            sleep 2
            ;;
        3)
            show_status
            read -p "  Press Enter..."
            ;;
        4)
            test_proxy
            read -p "  Press Enter..."
            ;;
        5)
            echo -e "${CYAN}[*] Exiting...${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}[!] Invalid option!${NC}"
            sleep 1
            ;;
    esac
done
