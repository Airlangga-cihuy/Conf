#!/usr/bin/env bash
set -euo pipefail

install_pkgs() {
  if command -v dnf >/dev/null 2>&1; then
    dnf -y install httpd curl
  elif command -v yum >/dev/null 2>&1; then
    yum -y install httpd curl
  else
    echo "No supported package manager found (dnf/yum)."
    exit 1
  fi
}

install_pkgs

# Apache service name is httpd on Amazon Linux
systemctl enable httpd

# Ownership: user/group biasanya apache
chown -R apache:apache /var/www/html || true

exit 0
