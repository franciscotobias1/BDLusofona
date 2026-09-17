#!/usr/bin/env bash
# Runs ONCE, when the codespace is first created (and on Rebuild Container).
set -euo pipefail

log() { printf '\033[1;36m[setup]\033[0m %s\n' "$*"; }

# ---------------------------------------------------------------------------
# 1. sqlcmd in the workspace container
# ---------------------------------------------------------------------------
if ! command -v sqlcmd >/dev/null 2>&1; then
  log "Installing mssql-tools18 ..."

  # NOTE: do NOT use Microsoft's published prod.list here. That file contains a
  # plain `deb [arch=...]` line with no `signed-by=`, so apt looks for the key
  # in the legacy trusted keyring, ignores the one written below, and fails
  # with:  NO_PUBKEY EB3E94ADBE1229CF / "repository is not signed".
  # Writing the sources line ourselves, with signed-by, is what image/Dockerfile
  # already does.
  curl -fsSL https://packages.microsoft.com/keys/microsoft.asc \
    | sudo gpg --dearmor --yes -o /usr/share/keyrings/microsoft-prod.gpg
  sudo chmod 0644 /usr/share/keyrings/microsoft-prod.gpg

  echo "deb [arch=amd64,armhf,arm64 signed-by=/usr/share/keyrings/microsoft-prod.gpg] https://packages.microsoft.com/ubuntu/22.04/prod jammy main" \
    | sudo tee /etc/apt/sources.list.d/mssql-release.list >/dev/null

  sudo apt-get update -qq
  sudo ACCEPT_EULA=Y apt-get install -y -qq mssql-tools18 unixodbc-dev >/dev/null

  command -v /opt/mssql-tools18/bin/sqlcmd >/dev/null 2>&1 \
    || { printf '\033[1;31m[setup]\033[0m sqlcmd did not install.\n' >&2; exit 1; }

  # Put sqlcmd/bcp on PATH for every future shell.
  echo 'export PATH="$PATH:/opt/mssql-tools18/bin"' | sudo tee /etc/profile.d/mssql-tools.sh >/dev/null
  sudo chmod +x /etc/profile.d/mssql-tools.sh
fi
export PATH="$PATH:/opt/mssql-tools18/bin"

# ---------------------------------------------------------------------------
# 2. Convenience aliases so students are not typing connection strings all day
# ---------------------------------------------------------------------------
BASHRC="$HOME/.bashrc"
if ! grep -q 'DB25 aliases' "$BASHRC" 2>/dev/null; then
  cat >> "$BASHRC" <<'EOF'

# --- DB25 aliases ---
export PATH="$PATH:/opt/mssql-tools18/bin"
# sql            -> interactive sqlcmd session against the class server
# sql -d BikeStores  -> ...against a specific database
alias sql='sqlcmd -S "$MSSQL_HOST,1433" -U sa -P "$MSSQL_SA_PASSWORD" -C -b'
alias db-reset='bash "$(git rev-parse --show-toplevel)/db/reset.sh"'
alias db-seed='bash "$(git rev-parse --show-toplevel)/db/seed.sh"'
EOF
fi

# ---------------------------------------------------------------------------
# 3. Seed
# ---------------------------------------------------------------------------
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
bash "$REPO_ROOT/db/seed.sh"

log "Ready. Open the SQL Server panel in the sidebar, or run 'sql' in a terminal."
