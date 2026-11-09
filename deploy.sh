#!/usr/bin/env bash
# Pulls the latest dashboard code, rebuilds the image, and restarts the
# container. Run this from a clone of the repo on the server; re-run it
# any time you want to pick up new commits.
set -euo pipefail

cd "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Pulling latest changes"
git pull

# Version shown in the page footer (APP_VERSION in index.html)
APP_VERSION="$(sed -n 's/.*var APP_VERSION = "\([^"]*\)".*/\1/p' index.html | head -n 1)"
export APP_VERSION="${APP_VERSION:-dev}"
echo "==> Dashboard version: v${APP_VERSION}"

echo "==> Building image (refreshing the nginx base image)"
docker compose build --pull

echo "==> Restarting container"
docker compose up -d --remove-orphans

echo "==> Checking the container is serving v${APP_VERSION}"
for i in 1 2 3 4 5 6 7 8 9 10; do
  if curl -fsS http://127.0.0.1:8080/ 2>/dev/null | grep -q "var APP_VERSION = \"${APP_VERSION}\""; then
    echo "==> Done. Dashboard v${APP_VERSION} is live at http://$(hostname -I | awk '{print $1}'):8080/"
    exit 0
  fi
  sleep 2
done
echo "!! The container did not serve v${APP_VERSION} within 20 seconds. Check: docker compose logs ccs-dashboard" >&2
exit 1
