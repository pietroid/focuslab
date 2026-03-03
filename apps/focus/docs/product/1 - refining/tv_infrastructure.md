# Why

The TV is the primary interface for the system — always on, large screen, omnipresent during work-from-home. Getting the app running stably on the TV is the prerequisite for everything else to have value.

# What

The TV must run the Flutter app continuously, without depending on the development Mac being on or connected.

Acceptance criteria:
- The Flutter Linux build runs on the dedicated Linux PC connected to the TV
- App auto-starts on boot
- A new build can be deployed from the dev Mac without physical access to the Linux machine
- Sound playback works (needed for notifications)

# How

**Decided**: Option B — dedicated Linux PC connected to the TV, running the Flutter Linux build.

Rationale: independent from the dev Mac, always-on, full system access for sound and notifications. The dev Mac (Option A) was only for initial testing.

**Deployment strategy** (to be finalized — pick one):

- **Option 1 (binary sync via script)**: CI or a local script builds the Linux binary on the dev Mac, transfers it via `scp` to the Linux machine, and restarts the app via SSH. Simple, no cloud dependency. Recommended for first iteration.

- **Option 2 (Dart VM remote debug)**: Run the Dart VM server on the Linux machine and connect the debugger from the dev Mac. Enables fast iteration without rebuilding and redeploying. Good for active development phases but not a production deployment strategy.

Implementation steps once deployment strategy is chosen:
1. Confirm Flutter Linux build runs on the target Linux machine
2. Confirm audio output works (`audioplayers` or system sound via `Process.run`)
3. Write a deploy script (build → scp → ssh restart) for Option 1
4. Set up systemd service to auto-start the app on boot
5. Test the full deploy cycle end-to-end
