FROM quay.io/almalinux/almalinux:9 AS compile-image

ENV SHADOWSOCKS_VER=1.15.2
ENV V2RAY_PLUGIN_VER=1.3.2

WORKDIR /root

RUN dnf install -y xz wget binutils
RUN set -ex && wget https://github.com/shadowsocks/shadowsocks-rust/releases/download/v${SHADOWSOCKS_VER}/shadowsocks-v${SHADOWSOCKS_VER}.aarch64-unknown-linux-gnu.tar.xz
RUN set -ex && wget https://github.com/shadowsocks/v2ray-plugin/releases/download/v${V2RAY_PLUGIN_VER}/v2ray-plugin-linux-arm64-v${V2RAY_PLUGIN_VER}.tar.gz
RUN tar -xvf shadowsocks-v${SHADOWSOCKS_VER}.x86_64-unknown-linux-gnu.tar.xz
RUN tar -xvf v2ray-plugin-linux-amd64-v${V2RAY_PLUGIN_VER}.tar.gz
RUN strip ss*
RUN mv v2ray-plugin_linux_amd64 v2ray-plugin

FROM quay.io/almalinux/almalinux:9 AS runtime-image

RUN useradd --create-home appuser

WORKDIR /home/appuser

USER appuser

COPY server_block_local.acl .
COPY --from=compile-image /root/ss* /usr/bin/
COPY --from=compile-image /root/v2ray-plugin /usr/bin/

VOLUME /etc/shadowsocks-rust
ENV TZ=America/Toronto
CMD [ "ssservice", "server", "-c", "/etc/shadowsocks-rust/config.json", "--acl", "server_block_local.acl" ]
