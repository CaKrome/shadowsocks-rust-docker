FROM almalinux/8-base
LABEL maintainer="CaKrome <cakrome@protonmail.com>"

WORKDIR /root
COPY server_block_local.acl /root/server_block_local.acl
COPY sample_conf.json /etc/shadowsocks-rust/config.json

RUN set -ex \
	&& dnf install -y xz wget binutils \
	&& wget https://github.com/shadowsocks/shadowsocks-rust/releases/download/v1.14.1/shadowsocks-v1.14.1.aarch64-unknown-linux-gnu.tar.xz \
	&& wget https://github.com/shadowsocks/v2ray-plugin/releases/download/v1.3.1/v2ray-plugin-linux-arm64-v1.3.1.tar.gz \
	&& tar -xvf shadowsocks-v1.14.1.aarch64-unknown-linux-gnu.tar.xz \
	&& tar -xvf v2ray-plugin-linux-arm64-v1.3.1.tar.gz \
	&& rm shadowsocks-v1.14.1.aarch64-unknown-linux-gnu.tar.xz \
	&& rm v2ray-plugin-linux-arm64-v1.3.1.tar.gz \
	&& strip ss* \
	&& mv ss* /usr/bin \
	&& mv v2ray-plugin_linux_arm64 v2ray-plugin \
	&& mv v2ray-plugin /usr/bin \
	&& dnf remove -y xz wget binutils

VOLUME /etc/shadowsocks-rust
ENV TZ=America/Toronto
CMD [ "ssserver", "-c", "/etc/shadowsocks-rust/config.json", "--acl", "/root/server_block_local.acl" ]
