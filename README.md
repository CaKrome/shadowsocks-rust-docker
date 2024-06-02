# shadowsocks-rust-docker
Docker deployment solution of [shadowsocks-rust](https://github.com/shadowsocks/shadowsocks-rust)

# Usage

```bash
git clone https://github.com/CaKrome/shadowsocks-rust-docker.git

# Build the docker image
docker compose build

# Now edit the file config.json to the configuation you like and also port in docker-compose.yml if you changed the default port.

# Bring the service up
docker compose up -d
```
