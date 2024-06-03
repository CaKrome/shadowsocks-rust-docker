# shadowsocks-rust-docker

Docker deployment solution of [shadowsocks-rust](https://github.com/shadowsocks/shadowsocks-rust)

# Usage

## Clone the repo

```bash
git clone https://github.com/CaKrome/shadowsocks-rust-docker.git
```

## Create a .env file

```bash
cp .env.sample .env
```

## Create a config.json file

```bash
cp config.json.sample config.json
```

Now edit the .env file and config.json to the configuation you like. Note that both files must use the same port.

## Build the docker image

```bash
docker compose build
```

## Bring shadowsocks-rust up

```bash
docker compose up -d
```
