#!/bin/bash
set -euo pipefail

if [ -z "${1:-}" ]; then
  echo "Usage: $0 \"commit message\""
  exit 1
fi

# Ensure CLI is available (local devDep). Comment this line if you prefer global/npx download each time.
npm pkg get devDependencies.sitemap-generator-cli >/dev/null 2>&1 || npm i -D sitemap-generator-cli

# Generate sitemap
npx sitemap-generator-cli https://auragan.fr -o sitemap.xml --quiet || {
  echo "Primary generator failed; trying explicit package call..."
  npx --yes -p sitemap-generator-cli -c 'sitemap-generator-cli https://auragan.fr -o sitemap.xml --quiet'
}

git add .
git commit -m "$1"
git push
