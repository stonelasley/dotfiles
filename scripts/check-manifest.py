#!/usr/bin/env python3
"""Validate packages.yml, the package manifest.

Schema: a mapping of tool name -> {manager: package name}, where manager is
one of KNOWN_MANAGERS. Every value must be a non-empty string.
"""

import sys
from pathlib import Path

import yaml

KNOWN_MANAGERS = {"apt", "brew", "scoop", "pip", "npm"}

MANIFEST = Path(__file__).resolve().parent.parent / "packages.yml"


def main() -> int:
    manifest = yaml.safe_load(MANIFEST.read_text())
    errors = []

    if not isinstance(manifest, dict):
        print(f"error: {MANIFEST.name} must be a mapping of tool -> managers")
        return 1

    for tool, managers in manifest.items():
        if not isinstance(managers, dict) or not managers:
            errors.append(f"{tool}: must map to a non-empty {{manager: name}} dict")
            continue
        for manager, name in managers.items():
            if manager not in KNOWN_MANAGERS:
                errors.append(
                    f"{tool}: unknown manager {manager!r} (expected one of {sorted(KNOWN_MANAGERS)})"
                )
            if not isinstance(name, str) or not name.strip():
                errors.append(f"{tool}.{manager}: package name must be a non-empty string")

    if errors:
        print(f"{MANIFEST.name}: {len(errors)} problem(s)")
        for error in errors:
            print(f"  - {error}")
        return 1

    print(f"{MANIFEST.name}: OK ({len(manifest)} tools)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
