#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
base_dir="$repo_root/band-templates"

mkdir -p "$base_dir/Songs" \
         "$base_dir/Demos" \
         "$base_dir/Lyrics" \
         "$base_dir/Setlists" \
         "$base_dir/Artwork" \
         "$base_dir/Gig Docs" \
         "$base_dir/Merch" \
         "$base_dir/Contracts"

cat > "$base_dir/README.txt" <<'EOF'
Suggested shared folders for a band Nextcloud workspace:

- Songs: one subfolder per song, with stems, drafts, and notes
- Demos: rehearsal captures and rough mixes
- Lyrics: editable lyric sheets and revisions
- Setlists: current and past live setlists
- Artwork: flyers, logos, promo photos, release art
- Gig Docs: booking info, tech riders, schedules
- Merch: designs, pricing, inventory sheets
- Contracts: agreements and admin documents

Copy these folders into Nextcloud after first login if you want a ready-made structure.
EOF

printf 'Created %s\n' "$base_dir"
