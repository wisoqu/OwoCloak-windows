# Architecture

OwOCloak is a Flutter Windows client with a replaceable tunnel backend. The
Flutter layer owns presentation and user intent; it does not own sockets,
routes, keys, or process management.

## Layers

- `lib/app` — app shell, theme, and dependency scope
- `lib/core/models` — transport-neutral domain models
- `lib/core/catalog` — development catalog and seed data
- `lib/core/services` — ports for native integrations and temporary adapters
- `lib/core/state` — one application controller for shared state and events
- `lib/features` — feature screens; widgets render state and dispatch intents

## Design goals

- Keep the simple mode uncluttered
- Keep advanced controls available without forcing them on casual users
- Make backend integration additive, not a rewrite

## Important decisions

- Connection state is not kept in a screen-local `bool`; every screen observes
  `AppController.tunnel`.
- `ConnectionEngine` is the boundary for a real Windows service. The current
  `DemoConnectionEngine` is deliberately named and logs that it is a demo.
- UI navigation can remain local to the advanced rail, while connection,
  settings, server selection, and logs stay in the controller.
- Secrets must not be stored in the catalog or ordinary preferences. The real
  backend should use Windows Credential Manager/DPAPI and expose only masked
  metadata to Flutter.
- A production tunnel must be a separate native process/service with an
  explicit lifecycle, health stream, kill-switch ordering, and rollback on
  failed route/DNS setup. Flutter must never launch shell commands directly.

## Integration points

- Native Windows connection engine implementing `ConnectionEngine`
- Server provisioning workflow behind a separate `ProvisioningService`
- Account and subscription API
- Device management and invite links behind repositories

## Current limitation

The app is still a client shell: `DemoConnectionEngine` simulates a successful
connection so UI and state transitions can be tested. It does not create a VPN
tunnel and must not be shipped as a production backend.
