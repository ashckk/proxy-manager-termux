# Proxy Manager - Termux

A simple SOCKS5 proxy toggle script for Termux with ON/OFF functionality.

## Quick Install

```bash
curl -fsSL https://raw.githubusercontent.com/ashckk/proxy-manager-termux/main/install.sh | bash
```

Or manual install:

```bash
git clone https://github.com/ashckk/proxy-manager-termux.git
cd proxy-manager-termux
chmod +x proxy.sh
./proxy.sh
```

## Usage

```bash
proxy-manager
```

## Menu Options

| Option | Description |
|--------|-------------|
| `1` | **ON** - Enable proxy |
| `2` | **OFF** - Disable proxy |
| `3` | **STATUS** - Show current status |
| `4` | **TEST** - Test proxy connection |
| `5` | **EXIT** - Exit script |

## Features

- Enable/disable SOCKS5 proxy with one command
- Persists proxy settings in `.bashrc` / `.zshrc`
- Saves proxy status for quick toggles
- Test proxy connection directly from menu
- Works with curl, apt, and other tools

## License

MIT
