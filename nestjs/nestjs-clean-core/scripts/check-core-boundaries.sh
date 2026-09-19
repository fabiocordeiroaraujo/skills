#!/usr/bin/env bash
set -euo pipefail

core_target="${1:-src/app/core}"

if [[ ! -d "$core_target" ]]; then
  echo "Core target not found: $core_target" >&2
  exit 2
fi

forbidden_pattern="from[[:space:]]+['\"](@nestjs/|@prisma/client|[^'\"]*/(api|database|infra|integration)/)"

if rg -n --glob '*.ts' "$forbidden_pattern" "$core_target"; then
  echo "Clean Architecture boundary violations found in: $core_target" >&2
  exit 1
fi

echo "Core boundary check passed: $core_target"
