#!/usr/bin/env bash
# ---------------------------------------------------------------------------
# Blow both class databases away and rebuild them from db/init/.
# For the week-3 moment when a student has mangled the schema beyond repair.
#
# WHY IT DROPS EVERYTHING FIRST:
# The init scripts are idempotent as a CHAIN but not individually.
# 04-HR-ddl-fk.sql issues bare ALTER TABLE ... ADD CONSTRAINT with no
# existence check; it only succeeds because 02 dropped and recreated the
# tables first. 07-BS-ddl.sql has an unguarded CREATE SCHEMA, safe only
# because 06 dropped it. So: always run all eight, never a subset.
#
# Usage:  bash db/reset.sh          (asks for confirmation)
#         bash db/reset.sh --force  (no prompt)
# ---------------------------------------------------------------------------
set -euo pipefail

export PATH="$PATH:/opt/mssql-tools18/bin"

HOST="${MSSQL_HOST:-db},1433"
PASS="${MSSQL_SA_PASSWORD:?MSSQL_SA_PASSWORD is not set}"
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

c_info() { printf '\033[1;36m[reset]\033[0m %s\n' "$*"; }
c_warn() { printf '\033[1;33m[reset]\033[0m %s\n' "$*"; }

if [ "${1:-}" != "--force" ]; then
  c_warn "This DROPS ULHT_DB26 and BikeStores. All your changes will be lost."
  read -r -p "Type 'yes' to continue: " reply
  [ "$reply" = "yes" ] || { c_info "Cancelled."; exit 0; }
fi

sql() { sqlcmd -S "$HOST" -U sa -P "$PASS" -C -b "$@"; }

for db in ULHT_DB26 BikeStores; do
  c_info "Dropping $db (if present) ..."
  # SINGLE_USER + ROLLBACK IMMEDIATE kicks off any open session — otherwise
  # the drop blocks forever on the student's own idle query window.
  sql -l 30 -Q "
    IF DB_ID(N'$db') IS NOT NULL
    BEGIN
      ALTER DATABASE [$db] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
      DROP DATABASE [$db];
    END"
done

c_info "Re-seeding ..."
bash "$HERE/seed.sh"
