# Nextcloud Deploy

Portable Nextcloud deployment bundle for a future Linux machine. This does not install anything on the current PC.

## What It Includes

- Nextcloud (Apache image)
- MariaDB
- Redis
- Optional Caddy reverse proxy for automatic HTTPS on a real domain
- Persistent bind mounts under `./data`
- `.env` template and a helper script to generate secrets
- Band workspace template generator

## Requirements On The Future Machine

- Docker with Compose, or Podman with Compose support
- Enough disk space for your shared files
- A reachable port such as `8080`, or a real domain later if you want HTTPS

## First Run

1. Copy this folder to the new machine.
2. Generate secrets and data folders:

```bash
./scripts/init-env.sh
```

3. Review `.env` and adjust these values if needed:

- `NEXTCLOUD_PORT`
- `APP_BIND`
- `NEXTCLOUD_TRUSTED_DOMAINS`
- `OVERWRITEHOST`
- `OVERWRITEPROTOCOL`

4. Start the stack:

```bash
docker compose up -d
```

5. Open:

```text
http://localhost:8080
```

If you changed `NEXTCLOUD_PORT`, use that port instead.

## LAN-Only Band Setup

This is the simplest setup for a private shared machine on a rehearsal-space or home network.

1. Copy `.env.lan.example` values into `.env` as needed.
2. Set `NEXTCLOUD_TRUSTED_DOMAINS` to your LAN IP or hostname.
3. Leave `OVERWRITEPROTOCOL=http`.
4. Start with:

```bash
docker compose up -d
```

Example access URL:

```text
http://192.168.1.10:8080
```

## Real Domain With HTTPS

For internet access or a cleaner domain setup, use the optional Caddy reverse proxy.

1. Set up DNS for your domain, such as `cloud.example.com`, to point to the future server.
2. Merge `.env.proxy.example` values into `.env`.
3. Start with:

```bash
docker compose -f docker-compose.yml -f docker-compose.proxy.yml up -d
```

4. Open:

```text
https://cloud.example.com
```

Caddy will request and renew certificates automatically when the domain resolves correctly.

## Sharing With Band Members

- Create one folder per song or release
- Use shared links for demos and lyrics
- Add the `Deck`, `Calendar`, and `Talk` apps after login for collaboration
- For a ready-made folder skeleton, run `./scripts/create-band-structure.sh`

Suggested structure:

- `Songs/`
- `Demos/`
- `Lyrics/`
- `Setlists/`
- `Artwork/`
- `Gig Docs/`

## Useful Commands

Start:

```bash
docker compose up -d
```

Stop:

```bash
docker compose down
```

Start with HTTPS proxy:

```bash
docker compose -f docker-compose.yml -f docker-compose.proxy.yml up -d
```

View logs:

```bash
docker compose logs -f
```

Update later:

```bash
docker compose pull
docker compose up -d
```

## Notes

- `.env` is intentionally ignored by git because it contains secrets.
- `./data` is also ignored because it contains the actual database and uploaded files.
- `APP_BIND=0.0.0.0` makes the app reachable on the LAN. Set `APP_BIND=127.0.0.1` when using the HTTPS proxy on the same host.
- For public internet access, open ports `80` and `443` to the server and use the proxy compose file.
