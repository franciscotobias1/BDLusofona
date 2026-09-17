#!/usr/bin/env bash
# ---------------------------------------------------------------------------
# Runs every script in db/init/ in filename order against the class server.
#
# Replaces the sequencing logic that used to live in entrypoint.sh. It is
# simpler because it runs from OUTSIDE the SQL Server container: no PID 1
# juggling, no signal trapping, no background sqlservr to babysit.
#
# -b makes sqlcmd exit non-zero on any SQL error, and `set -e` stops the run
# there. A half-seeded database is worse than no database, so we fail loudly
# on script 02 rather than cascading garbage into 03 and 04.
# ---------------------------------------------------------------------------
set -euo pipefail

export PATH="$PATH:/opt/mssql-tools18/bin"

HOST="${MSSQL_HOST:-db},1433"
PASS="${MSSQL_SA_PASSWORD:?MSSQL_SA_PASSWORD is not set}"
INIT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/init"

c_ok()   { printf '\033[1;32m  ok\033[0m   %s\n' "$*"; }
c_run()  { printf '\033[1;36m  run\033[0m  %s\n' "$*"; }
c_info() { printf '\033[1;36m[seed]\033[0m %s\n' "$*"; }
c_err()  { printf '\033[1;31m[seed]\033[0m %s\n' "$*" >&2; }

# -f 65001 tells sqlcmd the input files are UTF-8. Several scripts contain
# accented Portuguese text (and a © in the BikeStores headers); without this
# they are read as the default codepage and the characters are mangled.
sql() { sqlcmd -S "$HOST" -U sa -P "$PASS" -C -b -f 65001 "$@"; }

# --- wait for the server -----------------------------------------------------
c_info "Waiting for SQL Server at $HOST ..."
for i in $(seq 1 90); do
  if sql -l 5 -Q "SELECT 1" >/dev/null 2>&1; then
    c_info "Server is accepting logins."
    break
  fi
  [ "$i" -eq 90 ] && { c_err "Timed out after ~3 minutes."; exit 1; }
  sleep 2
done

# --- run the scripts ---------------------------------------------------------
shopt -s nullglob
SCRIPTS=("$INIT_DIR"/*.sql)
if [ ${#SCRIPTS[@]} -eq 0 ]; then
  c_err "No .sql files found in $INIT_DIR"
  exit 1
fi

c_info "Executing ${#SCRIPTS[@]} scripts from db/init/ ..."
START=$(date +%s)

for f in "${SCRIPTS[@]}"; do
  name="$(basename "$f")"
  c_run "$name"
  # -I enables QUOTED_IDENTIFIER, required by some DDL.
  # No -d: every script sets its own USE, and 01/05 must run against master.
  if ! sql -l 60 -I -i "$f"; then
    c_err "FAILED on $name — stopping."
    c_err "Fix the script, then re-run the FULL chain with:  bash db/reset.sh"
    exit 1
  fi
  c_ok "$name"
done

ELAPSED=$(( $(date +%s) - START ))
c_info "Seed complete in ${ELAPSED}s."

sql -Q "SET NOCOUNT ON;
        SELECT name AS [database], state_desc AS [state]
        FROM sys.databases
        WHERE name IN ('ULHT_DB26','BikeStores');"
