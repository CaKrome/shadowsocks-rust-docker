# shadowsocks-rust-docker
Docker/Podman deployment solution of [shadowsocks-rust](https://github.com/shadowsocks/shadowsocks-rust)

# Usage

```bash
git clone https://github.com/CaKrome/shadowsocks-rust-docker.git

#If your server is using amd64 architecture
cd shadowsocks-rust-docker/amd64

#If your server is using arm64 architecture
cd shadowsocks-rust-docker/arm64

#Build the docker image
docker build . -t cakrome/ss-rust

#Now create a file called config.json in /etc/shadowsocks-rust and put your configuration there, we have a sample configuation file(sample_conf.json) for reference

#Run the built docker image
docker run -d -p [port]:[port] -p [port]:[port]/udp --name ss-rust --restart=always -v /etc/shadowsocks-rust:/etc/shadowsocks-rust cakrome/ss-rust
```
When using podman, replace `docker` with `podman`


