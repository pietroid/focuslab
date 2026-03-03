# Why

Mobile app provides input and notification access when the user is away from the primary TV/Desktop interface. Without it, the system is blind and deaf to the user while they're on the go.

# What

Questions still to be answered before scoping:

- What inputs are most critical on mobile that can't wait until returning to TV/Desktop?
- Should the mobile app share Flutter code with the TV/Desktop app or be a separate, simpler shell?
- What is the minimum viable mobile experience — read-only view + quick task entry + notifications?
- How do we handle screen space constraints without duplicating complex TV layout logic?

# How

Research needed before implementation:

- iOS push notification limitations without a paid Apple Developer account (confirm if background notifications work at all)
- Flutter `flutter_local_notifications` vs FCM for cross-platform notification delivery
- Evaluate whether a single Flutter codebase can adapt the calendar layout from TV (widescreen) to mobile (portrait) without a full redesign
- Look at how other productivity apps (Fantastical, Structured) handle the mobile-first calendar view as design reference
