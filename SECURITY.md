# Security Policy

## Reporting a vulnerability

Please **do not** open a public issue for security problems.

Use GitHub's private vulnerability reporting (Security tab > "Report a vulnerability") or email the maintainers at `contact@eware.dev`.

Include a description, reproduction steps and the potential impact. We aim to acknowledge reports within 5 working days.

## Secrets

This repository must never contain real credentials. Use the `*.example` templates and keep real values in git-ignored files or environment variables. If you find a leaked secret, report it so it can be revoked.
