# shadowsocks-rust-docker
Docker/Podman deployment solution of shadowsocks-rust

# Usage

```bash
git clone https://github.com/CaKrome/shadowsocks-rust-docker.git
cd shadowsocks-rust-docker
docker build . -t cakrome/ss-rust
docker run -d -p [port]:[port] -p [port]:[port]/udp --name ss-rust --restart=always -v /etc/shadowsocks-rust:/etc/shadowsocks-rust cakrome/ss-rust
```
When using podman, replace `docker` with `podman`


