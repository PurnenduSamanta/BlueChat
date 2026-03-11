# BlueChat Agent Context

## Project Goal
Build a **minimal Flutter Bluetooth chat app** for learning Flutter with agentic AI workflows.

Core user flow:
1. Device Listing Screen (discover + select nearby Bluetooth devices)
2. Chat Screen (send/receive text messages with selected device)

This file is the single source of truth for project context so any agent can resume work quickly.

## Scope (MVP)
- Flutter app with exactly 2 primary screens:
  - Device listing
  - Chat
- Target platforms: Android and iOS
- Chat model in MVP: one-to-one only (exactly two devices connected in a session)
- Optional join enhancement: QR code scan from Device Listing screen
- Basic Bluetooth flow:
  - Check Bluetooth availability/state
  - Request runtime permissions
  - Scan/list devices
  - Connect to selected device
  - Exchange plain text messages
- Keep architecture simple and readable for learning

## Out of Scope (for now)
- Media/file transfer
- Multi-device/group chat (beyond two devices)
- Message persistence/database
- Background service reliability tuning
- Production-grade encryption/security hardening

## Proposed Tech Choices
- Framework: Flutter (stable)
- Language: Dart
- Bluetooth package (candidate): `flutter_bluetooth_serial` or `flutter_blue_plus`(Better choice because it has more download)
- State management: `provider` (selected)
- Architecture pattern: MVVM
- Navigation: Flutter Navigator 2-screen flow
- Native integration strategy: use Flutter platform channels when plugin limitations appear, to improve robustness on Android/iOS

Note: Final package choice should be confirmed before coding due API/platform differences.

## Functional Requirements
### Device Listing Screen
- Show Bluetooth state (on/off/unsupported)
- Button to start/stop scan
- Render discovered devices in list
- Tap device to connect and navigate to Chat Screen
- Loading/error/empty states
- Optional action: scan QR code to join/connect quickly(We will implment later when thigs working as intended)

### Chat Screen
- Header with connected device name/address + connection status
- Message list (local + incoming)
- Input field + send button
- Basic disconnect action
- Minimal UX feedback for sending/connection errors
- Restrict chat session to two devices only in MVP

## Non-Functional Requirements
- Keep code small and easy to understand
- Favor explicit naming over abstraction
- Add lightweight logging for Bluetooth events
- Document assumptions in this file as work progresses
- Prepare for future dark mode support from the start
- Do not use random/hardcoded ad-hoc colors in UI components
- Define and use a consistent app color palette (theme tokens) before building screens
- Keep a clear boundary so critical Bluetooth operations can be moved to platform channels if needed

## Platform Notes
### Android
- Add Bluetooth + location/runtime permissions (depends on Android SDK level)
- Handle Android 12+ Bluetooth permission model (`BLUETOOTH_SCAN`, `BLUETOOTH_CONNECT`)

### iOS
- Add required Bluetooth usage descriptions in `Info.plist`
- Verify plugin iOS support before implementation

## Agentic Workflow Guidelines
- Before each coding session:
  - Read `agent.md` first
  - Check `Daily Progress Log` and `Next Actions`
- After each meaningful change:
  - Update `Daily Progress Log` with date/time + what changed
  - Update `Current Status`, `Risks`, and `Next Actions`
- When blocked:
  - Add blocker under `Open Questions / Blockers`
  - Propose at least one fallback path

## Open Questions / Blockers
1. Which Bluetooth plugin should be used for this MVP?
2. Any platform-specific UX differences to keep between Android and iOS?
3. Future extension approach for multi-device chat after MVP
4. QR payload design: what device/session info should be encoded for reliable join?

## Risks
- Bluetooth plugin behavior can vary by device/OS version
- Permission handling can consume most initial setup time
- Emulator support for Bluetooth is limited; real-device testing is likely required

## Current Status
- Global app theme and color palette are set with light/dark mode support.
- MVVM project structure is scaffolded for both MVP features (`device_listing` and `chat`).
- `provider` is added and wired through app-level `MultiProvider`.
- Bluetooth plugin is not integrated yet; a mock Bluetooth service is used as a temporary implementation.
- App orientation is locked to portrait (`portraitUp` and `portraitDown`) at startup for Android and iOS.
- App icon setup is complete for Android and iOS, including adaptive Android icon layers.

## Next Actions
1. Finalize Bluetooth plugin choice (`flutter_blue_plus` vs `flutter_bluetooth_serial`) and lock one.
2. Replace mock Bluetooth service with real scan/connect/send/receive implementation.
3. Add Android and iOS Bluetooth permission handling and platform config.
4. Add connection state and disconnect flow in chat screen.
5. Add lightweight logging for Bluetooth events and errors.
6. Verify portrait orientation behavior on real Android and iOS devices.


---

## Daily Progress Log

### 2026-03-06
- Created `agent.md` as project context and continuity file.
- Captured MVP scope (2 screens), architecture direction, workflow, and next actions.
- Waiting for user review before scaffolding implementation.
- Updated state management decision to `provider`.
- Added theming rule: choose a consistent app color palette first and keep dark mode in mind for future support.
- Marked iOS as required target platform (not optional).
- Corrected target platforms to Android and iOS.
- Locked MVP chat scope to one-to-one (two devices only), with multi-device support deferred.
- Added strategy to leverage platform channels for robustness when plugin behavior is insufficient.
- Set architecture to MVVM and removed temporary project-structure section.
- Added optional QR-code join path on Device Listing, and noted QR payload design as an open question.

### 2026-03-09 17:33
- Added `provider` dependency and wired app-level `MultiProvider`.
- Replaced flat starter setup with MVVM scaffolding:
  - `core/services` for Bluetooth service interface and mock implementation
  - `features/device_listing/{model,view_model,view,widget}`
  - `features/chat/{model,view_model,view,widget}`
- Switched app entrypoint to `BlueChatApp` and set Device Listing as initial screen.
- Removed default counter-template flow and replaced with MVP-aligned screen skeletons.
- Updated widget test to target the new app structure.
- Verified with `flutter analyze` (no issues).

### 2026-03-10
- Locked app orientation to portrait only (`portraitUp`, `portraitDown`) in `main.dart`.
- Applied via `SystemChrome.setPreferredOrientations` before app startup so it affects both Android and iOS.
- Added dark/light theme toggle in Device Listing AppBar.
- Added theme state controller with `provider`.
- Added `shared_preferences` and persisted selected theme mode.

### 2026-03-11
- Added custom app icon assets and configured `flutter_launcher_icons`.
- Generated Android launcher icons including adaptive foreground/background and monochrome support.
- Generated iOS app icons and enabled `remove_alpha_ios: true` to satisfy App Store requirements.
- Verified icon update on app launch.

---

## Handoff Checklist (for any agent)
- Read this file top-to-bottom
- Check latest entry in `Daily Progress Log`
- Confirm unresolved items in `Open Questions / Blockers`
- Continue from `Next Actions` in order unless priorities changed
