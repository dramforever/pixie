FROM debian:unstable

ADD debian-bootstrap.sh nix.conf /tmp/
RUN sh -e /tmp/debian-bootstrap.sh

ENV \
  DEBIAN_FRONTEND=noninteractive \
  LANG=C.UTF-8 \
  NIX_PATH=nixpkgs=/root/.nix-defexpr/channels/nixpkgs:/root/.nix-defexpr/channels \
  NIX_SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt \
  PAGER=/usr/bin/less \
  PATH=/root/.nix-profile/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

WORKDIR /root
CMD ["/bin/bash"]
