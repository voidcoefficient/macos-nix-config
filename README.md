# nix config for macos

This is a repository not meant to be used by others, but you are free to read it.

## Install

```bash
curl \
  --proto '=https' \
  --tlsv1.2 \
  -sSf \
  -L https://install.determinate.systems/nix \
  | sh -s -- install
nix-shell -p git
mkdir -p ~/.config/nix
git clone https://github.com/voidcoefficient/macos-nix-config ~/.config/nix
nix run nix-darwin -- switch --flake ~/.config/nix
```
