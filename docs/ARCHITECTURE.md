# Architecture

OwOCloak is organized as a frontend-first Flutter desktop client.

## Layers

- `lib/app` — app shell, theme, and top-level navigation
- `lib/core` — shared models and mock data
- `lib/features` — feature screens and sections

## Design goals

- Keep the simple mode uncluttered
- Keep advanced controls available without forcing them on casual users
- Make backend integration additive, not a rewrite

## Later integration points

- Real VPN connection engine
- Server provisioning workflow
- Account and subscription API
- Device management and invite links
