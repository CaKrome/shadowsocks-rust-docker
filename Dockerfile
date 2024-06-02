FROM quay.io/almalinux/almalinux:9 AS compile-image

ENV SHADOWSOCKS_VER=1.19.2
ENV V2RAY_PLUGIN_VER=1.3.2

WORKDIR /root

RUN set -ex && dnf upgrade -y && dnf install -y binutils wget make gcc xz

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

RUN wget https://github.com/shadowsocks/shadowsocks-rust/archive/refs/tags/v${SHADOWSOCKS_VER}.tar.gz
RUN tar -xf v${SHADOWSOCKS_VER}.tar.gz

RUN set -ex \
	&& source "$HOME/.cargo/env" \
	&& cd shadowsocks-rust-${SHADOWSOCKS_VER} \
	&& TARGET=release make build

RUN strip /root/shadowsocks-rust-${SHADOWSOCKS_VER}/target/release/sslocal
RUN strip /root/shadowsocks-rust-${SHADOWSOCKS_VER}/target/release/ssmanager
RUN strip /root/shadowsocks-rust-${SHADOWSOCKS_VER}/target/release/ssserver
RUN strip /root/shadowsocks-rust-${SHADOWSOCKS_VER}/target/release/ssservice
RUN strip /root/shadowsocks-rust-${SHADOWSOCKS_VER}/target/release/ssurl

RUN mv /root/shadowsocks-rust-${SHADOWSOCKS_VER}/target/release/sslocal /root/
RUN mv /root/shadowsocks-rust-${SHADOWSOCKS_VER}/target/release/ssmanager /root/
RUN mv /root/shadowsocks-rust-${SHADOWSOCKS_VER}/target/release/ssserver /root/
RUN mv /root/shadowsocks-rust-${SHADOWSOCKS_VER}/target/release/ssservice /root/
RUN mv /root/shadowsocks-rust-${SHADOWSOCKS_VER}/target/release/ssurl /root/

FROM quay.io/almalinux/almalinux:9 AS runtime-image

RUN set -ex && dnf upgrade -y && dnf clean all

RUN useradd --create-home appuser

WORKDIR /home/appuser

USER appuser

COPY server_block_local.acl .
COPY --from=compile-image /root/sslocal /usr/bin/
COPY --from=compile-image /root/ssmanager /usr/bin/
COPY --from=compile-image /root/ssserver /usr/bin/
COPY --from=compile-image /root/ssservice /usr/bin/
COPY --from=compile-image /root/ssurl /usr/bin/


ENV TZ=America/Toronto

CMD [ "ssservice", "server", "-c", "/etc/shadowsocks-rust/config.json", "--acl", "server_block_local.acl" ]