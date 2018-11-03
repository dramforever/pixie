FROM alpine:edge as FETCHER

ADD bootstrap.sh nix.conf /tmp/
RUN sh -e /tmp/bootstrap.sh

FROM scratch

COPY --from=FETCHER /etc/group /etc/group
COPY --from=FETCHER /etc/passwd /etc/passwd
COPY --from=FETCHER /etc/shadow /etc/shadow
COPY --from=FETCHER /nix /nix
COPY --from=FETCHER /root /root
COPY --from=FETCHER /tmp /tmp

ENV \
  NIX_PATH=nixpkgs=/root/.nix-defexpr/channels/nixpkgs:/root/.nix-defexpr/channels \
  NIX_SSL_CERT_FILE=/root/.nix-profile/etc/ssl/certs/ca-bundle.crt \
  PAGER=/root/.nix-profile/bin/less \
  PATH=/root/.nix-profile/bin

RUN ["/root/.nix-profile/bin/ln", "-s", "/root/.nix-profile/bin", "/bin"]

RUN \
  ln -s /root/.nix-profile/etc/protocols /etc/protocols && \
  ln -s /root/.nix-profile/etc/services /etc/services && \
  ln -s /root/.nix-profile/etc/ssl /etc/ssl && \
  ln -s /root/.nix-profile/lib /lib && \
  ln -s /root/.nix-profile/sbin /sbin && \
  ln -s /root/.nix-profile/share /share && \
  mkdir /opt && \
  mkdir -p /usr/local && \
  ln -s /root/.nix-profile/bin /usr/bin && \
  ln -s /root/.nix-profile/lib /usr/lib && \
  ln -s /root/.nix-profile/sbin /usr/sbin && \
  ln -s /root/.nix-profile/share /usr/share && \
  ln -s /root/.nix-profile/bin /usr/local/bin && \
  ln -s /root/.nix-profile/lib /usr/local/lib && \
  ln -s /root/.nix-profile/sbin /usr/local/sbin && \
  ln -s /root/.nix-profile/share /usr/local/share

WORKDIR /root
CMD ["/root/.nix-profile/bin/bash"]
