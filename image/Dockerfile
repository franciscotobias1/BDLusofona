# ---------------------------------------------------------------------------
# Class SQL Server image.
#
# This is a MUCH thinner image than the desktop 1.1.0 one. It no longer:
#   * COPYs the init scripts        -> they live in the repo and are run by
#                                      db/seed.sh, so students can read and
#                                      edit them without rebuilding anything
#   * COPYs entrypoint.sh           -> the stock entrypoint is used; seeding
#                                      is sequenced from the workspace
#                                      container after the healthcheck passes
#   * sed's CRLF out of the scripts -> .gitattributes forces LF at checkout
#
# All it adds is mssql-tools18, which the base 2022 image dropped. That is
# needed for the compose healthcheck, for `bcp`, and for server-side
# BULK INSERT demos where students shell into this container directly.
#
# Build and publish via .github/workflows/build-image.yml — do NOT build this
# on each student's machine; that is the several-minute cost we are avoiding.
# ---------------------------------------------------------------------------
FROM mcr.microsoft.com/mssql/server:2022-latest

USER root

ENV ACCEPT_EULA=Y \
    MSSQL_PID=Developer \
    PATH="$PATH:/opt/mssql-tools18/bin"

RUN apt-get update \
 && apt-get install -y --no-install-recommends curl gnupg apt-transport-https ca-certificates \
 && curl -fsSL https://packages.microsoft.com/keys/microsoft.asc \
      | gpg --dearmor -o /usr/share/keyrings/microsoft-prod.gpg \
 && echo "deb [arch=amd64,armhf,arm64 signed-by=/usr/share/keyrings/microsoft-prod.gpg] https://packages.microsoft.com/ubuntu/22.04/prod jammy main" \
      > /etc/apt/sources.list.d/mssql-release.list \
 && apt-get update \
 && ACCEPT_EULA=Y apt-get install -y --no-install-recommends mssql-tools18 unixodbc \
 && apt-get remove -y gnupg \
 && apt-get autoremove -y \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Back to the unprivileged user the base image defines. The desktop compose
# used `user: "0:0"` to work around Windows bind-mount permissions; with a
# named volume that is unnecessary, and running SQL Server as root is not
# something to teach.
USER mssql

EXPOSE 1433
