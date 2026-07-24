# OwOCloak Windows

Windows VPN client shell built with Flutter, with a replaceable tunnel backend.

## What is included

- Simple mode with one main connect action
- Advanced mode with self-hosted and team infrastructure paths
- Personal cabinet section with local seed data
- Shared application controller and connection-engine boundary
- Dark desktop UI aligned with the OwOCloak reference design

## Current scope

The current build uses `DemoConnectionEngine`: it simulates connection
transitions for UI development and does not create a VPN tunnel. A native
Windows engine must implement `ConnectionEngine` before release.

Secrets must be handled by the native layer using Windows Credential Manager or
DPAPI. Flutter screens should receive masked metadata only.

## Suggested next step

After unzipping, open the folder in VS Code or Positron and commit the scaffold:

```bash
git add .
git commit -m "Initial Flutter scaffold"
```

Run checks and the desktop app with Flutter:

```bash
flutter pub get
flutter run -d windows
```
