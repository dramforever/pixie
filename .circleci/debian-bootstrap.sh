#!/bin/sh -e

export DEBIAN_FRONTEND=noninteractive

apt update
apt full-upgrade -y
apt install -y \
  bzip2 \
  ca-certificates \
  curl

addgroup --system --gid 30000 nixbld

for i in $(seq 1 32); do
    useradd --home-dir /var/empty --gid nixbld --groups nixbld --no-create-home --no-user-group --system --shell /usr/sbin/nologin --uid $((30000 + i)) nixbld$i
done

mkdir -p -m 0755 \
  /nix/var/log/nix/drvs \
  /nix/var/nix/db \
  /nix/var/nix/gcroots \
  /nix/var/nix/profiles \
  /nix/var/nix/temproots \
  /nix/var/nix/userpool
mkdir -p -m 1777 \
  /nix/var/nix/gcroots/per-user \
  /nix/var/nix/profiles/per-user
mkdir -p -m 1775 /nix/store
chgrp nixbld /nix/store
mkdir -p -m 0755 /nix/var/nix/profiles/per-user/root
mkdir -p -m 0700 /root/.nix-defexpr
mkdir -p -m 0555 /etc/nix

mkdir -p \
  /root/.config/nix \
  /root/.nixpkgs
mv /tmp/nix.conf /root/.config/nix/nix.conf
echo "{ allowUnfree = true; }" > /root/.nixpkgs/config.nix

cd /tmp
curl https://nixos.org/releases/nix/nix-2.1.3/nix-2.1.3-x86_64-linux.tar.bz2 | tar xjf -
cd nix-2.1.3-x86_64-linux
USER=root ./install --no-daemon

export NIX_PATH=nixpkgs=/root/.nix-defexpr/channels/nixpkgs:/root/.nix-defexpr/channels
export NIX_SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
export PATH=/root/.nix-profile/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

apt purge -y \
  bzip2 \
  curl
apt autoremove --purge -y
rm -rf /var/lib/apt/lists/*
nix-channel --remove nixpkgs
rm -rf /nix/store/*-nixpkgs*
nix-collect-garbage -d
nix-store --verify --check-contents
nix optimise-store
rm -rf /tmp/*
