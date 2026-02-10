#!/usr/bin/env bash
set -euo pipefail

sleep 2

systemctl is-active --quiet httpd

code="$(curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1/health.html || true)"
if [[ "$code" != "200" ]]; then
  echo "ValidateService failed: /health.html HTTP $code"
  journalctl -u httpd --no-pager -n 50 || true
  exit 1
fi

echo "ValidateService OK: /health.html HTTP $code"
exit 0
