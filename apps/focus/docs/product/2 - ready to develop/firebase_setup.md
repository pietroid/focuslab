# Why

Firebase must be initialized in the Flutter app before any data feature can be built or tested. This is a one-time setup task that unblocks all backend work.

# What

- Firebase project created and connected to the Flutter app
- `firebase_core` initialized in `bootstrap.dart` before `runApp`
- Firestore enabled in the Firebase console
- Firebase Auth enabled with email/password provider
- Platforms configured: macOS (primary dev) and Linux (TV)

Acceptance criteria:
- App launches without Firebase initialization errors on macOS
- A test Firestore write and read succeeds from the running app
- Firebase Auth sign-in with email/password returns a valid user

# How

1. Create a Firebase project at console.firebase.google.com
2. Install the FlutterFire CLI: `dart pub global activate flutterfire_cli`
3. From `apps/focus/`, run: `flutterfire configure` and select macOS + Linux targets
4. Add dependencies to `pubspec.yaml`:
   ```yaml
   firebase_core: ^3.x.x
   firebase_auth: ^5.x.x
   cloud_firestore: ^5.x.x
   ```
5. In `bootstrap.dart`, add before `runApp`:
   ```dart
   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
   ```
6. Enable macOS network entitlements in `macos/Runner/DebugProfile.entitlements` and `Release.entitlements`:
   ```xml
   <key>com.apple.security.network.client</key>
   <true/>
   ```
7. Enable Firestore and Auth (email/password) in the Firebase console
8. Write a smoke test: sign in anonymously or with a test account and write a document to `households/test`
