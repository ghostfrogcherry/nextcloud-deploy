#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"

if [[ -f "$repo_root/.env" ]]; then
  echo ".env already exists"
  exit 0
fi

mkdir -p \
  "$repo_root/data/db" \
  "$repo_root/data/redis" \
  "$repo_root/data/nextcloud" \
  "$repo_root/data/caddy/data" \
  "$repo_root/data/caddy/config"

root_pw="$(openssl rand -hex 18)"
db_pw="$(openssl rand -hex 18)"
admin_pw="$(openssl rand -hex 18)"

sed \
  -e "s/^MYSQL_ROOT_PASSWORD=.*/MYSQL_ROOT_PASSWORD=${root_pw}/" \
  -e "s/^MYSQL_PASSWORD=.*/MYSQL_PASSWORD=${db_pw}/" \
  -e "s/^NEXTCLOUD_ADMIN_PASSWORD=.*/NEXTCLOUD_ADMIN_PASSWORD=${admin_pw}/" \
  "$repo_root/.env.example" > "$repo_root/.env"

echo "Created $repo_root/.env"
echo "Nextcloud admin password: $admin_pw"
echo "Save it somewhere safe."
echo "Use .env.lan.example or .env.proxy.example as references for LAN or HTTPS mode."
