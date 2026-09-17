#!/usr/bin/env bash
# Runs on EVERY start, including after the codespace was stopped and resumed.
# The named volume normally survives, so this is a no-op. It exists to cover
# the case where the volume was lost but the container was not recreated.
set -euo pipefail

export PATH="$PATH:/opt/mssql-tools18/bin"
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

command -v sqlcmd >/dev/null 2>&1 || exit 0

# Wait briefly for the server to accept logins after resume.
for _ in $(seq 1 30); do
  if sqlcmd -S "${MSSQL_HOST:-db},1433" -U sa -P "$MSSQL_SA_PASSWORD" -C -b -l 5 \
       -Q "SELECT 1" >/dev/null 2>&1; then
    break
  fi
  sleep 2
done

MISSING=$(sqlcmd -S "${MSSQL_HOST:-db},1433" -U sa -P "$MSSQL_SA_PASSWORD" -C -h -1 -W -l 10 \
  -Q "SET NOCOUNT ON; SELECT COUNT(*) FROM sys.databases WHERE name IN ('ULHT_DB26','BikeStores');" \
  2>/dev/null | tr -d '[:space:]' || echo "0")

if [ "$MISSING" != "2" ]; then
  printf '\033[1;33m[setup]\033[0m Databases missing after restart — re-seeding.\n'
  bash "$REPO_ROOT/db/seed.sh"
fi
