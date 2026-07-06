#!/usr/bin/env bash
# Pulls the latest dashboard code, rebuilds the image, and restarts the
# container. Run this from a clone of the repo on the server; re-run it
# any time you want to pick up new commits.
set -euo pipefail

cd "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Pulling latest changes"
git pull

echo "==> Building image"
docker compose build

echo "==> Restarting container"
docker compose up -d

echo "==> Done. Dashboard should be live at http://$(hostname -I | awk '{print $1}'):8080/"
