FROM quay.io/almalinuxorg/almalinux:9 AS compile-image

ENV SHADOWSOCKS_VER=1.23.4
ENV RUST_VER=1.87.0

WORKDIR /root

RUN set -ex && dnf upgrade -y && dnf install -y binutils wget make gcc xz

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain=${RUST_VER} -y
ENV PATH="/root/.cargo/bin:$PATH"

RUN wget https://github.com/shadowsocks/shadowsocks-rust/archive/refs/tags/v${SHADOWSOCKS_VER}.tar.gz
RUN tar -xf v${SHADOWSOCKS_VER}.tar.gz

RUN set -ex \
	&& cd shadowsocks-rust-${SHADOWSOCKS_VER} \
	&& TARGET=release make build

RUN strip /root/shadowsocks-rust-${SHADOWSOCKS_VER}/target/release/ssservice
RUN mv /root/shadowsocks-rust-${SHADOWSOCKS_VER}/target/release/ssservice /root/

FROM quay.io/almalinuxorg/almalinux:9 AS runtime-image

RUN set -ex && dnf upgrade -y && dnf clean all

RUN useradd --create-home serviceuser

WORKDIR /home/serviceuser

USER serviceuser

COPY server_block_local.acl .
COPY --from=compile-image /root/ssservice /usr/local/bin/

ENV TZ=America/Toronto

CMD [ "ssservice", "server", "-c", "/etc/shadowsocks-rust/config.json", "--acl", "server_block_local.acl" ]
