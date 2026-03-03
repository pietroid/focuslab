# Why

Notifications trigger the cognitive circuits that close the feedback loop between the plan and the person. Without them, the system becomes passive — something you check instead of something that guides you.

# What

Scopes identified, but platform support is still unconfirmed:

- **TV notifications**: Sound + overlay widget appearing on screen. Likely achievable since it runs Flutter on Linux with full system access.
- **Desktop (macOS) notifications**: Unclear if a Flutter macOS app can send local notifications without a paid Apple Developer account. Needs testing.
- **iOS notifications**: Known limitations without a paid Apple Developer account (no background push). If critical, adding the $99/year Apple Developer account is an option — but this should be the last platform tested.

Notification triggers to support:
- Reminders: user-set alarms tied to specific slots/tasks
- Slot transitions: alert when a time slot is about to end and the next one begins
- Urgent items: manually flagged tasks that surface proactively

# How

Research and testing needed:

- Test Flutter `local_notifications` package on macOS without a Developer account — confirm if permissions can be granted from a debug/sideloaded build
- Test Flutter local notifications on Linux (TV) — expected to work but confirm sound playback
- Evaluate Firebase Cloud Messaging (FCM) vs local-only approach for cross-device delivery
- Decide: should notifications be generated on-device (each device checks independently) or server-triggered (a backend job fires notifications to all registered devices)?
