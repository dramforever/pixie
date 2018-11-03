# `pixie`

[![CircleCI](https://circleci.com/gh/TerrorJack/pixie/tree/master.svg?style=shield)](https://circleci.com/gh/TerrorJack/pixie/tree/master)
![Docker Pulls](https://img.shields.io/docker/pulls/terrorjack/pixie.svg)

Yet another Docker image for Nix.

## Notes

* `terrorjack/pixie:latest` only contains Nix; `terrorjack/pixie:debian` is a Nix/Debian hybrid image, so you can still `apt install` something in case it's not in `nixpkgs` (or too old).
* `nixpkgs` and `apt` repositories are stripped from the images. Run `nix-channel --add https://nixos.org/channels/nixpkgs-unstable && nix-channel --update` to retrieve the latest release of `nixpkgs`, `apt update` to update `apt` repositories.
* For basic usage on CircleCI, install `nixpkgs.{gitMinimal,openssh}` before `checkout`. Additionally, CircleCI caching require `nixpkgs.{gnutar,gzip}`.
* For `fontconfig` to find the default config file, set `FONTCONFIG_FILE=$(nix eval --raw nixpkgs.fontconfig.out.outPath)/etc/fonts/fonts.conf`.
* For `nix-env -q` to work, install `nixpkgs.less`.
* For manpages to work, install `nixpkgs.{gzip,less,man}`.
