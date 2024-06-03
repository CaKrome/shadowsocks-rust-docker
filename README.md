# shadowsocks-rust-docker

Docker deployment solution of [shadowsocks-rust](https://github.com/shadowsocks/shadowsocks-rust)

# Usage

```bash
git clone https://github.com/CaKrome/shadowsocks-rust-docker.git

# Create a .env file
cp .env.sample .env

# Create a config.json file
cp config.json.sample config.json

# Now edit the .env file and config.json to the configuation you like. Note that both files must use the sample port.

# Build the docker image
docker compose build

# Bring the service up
docker compose up -d
```
