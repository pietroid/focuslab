# Why

Real-time sync across TV, Desktop, and eventually Mobile is essential for the system to feel like one coherent thing rather than multiple disconnected apps.

# What

- Real-time data sync for slots, tasks, and user state across all devices
- User authentication supporting at least 2 users (household members)
- Data layer abstracted behind repository interfaces so the underlying provider can be swapped without touching feature code

Acceptance criteria:
- Any change made on one device is reflected on all other connected devices within 2 seconds
- Data persists offline and syncs when connectivity is restored
- The repository interface is the only point of contact with Firebase — no direct Firestore calls in UI or business logic layers

# How

**Decided**: Use Firebase (Firestore + Auth) for the initial version.

Rationale: familiarity, proven real-time streaming, minimal infra overhead for prototyping. Cost is acceptable short-term; plan to migrate to a self-hosted solution (Supabase or Pocketbase) within 2–3 months if costs rise or control becomes important.

Implementation steps:
1. Initialize Firebase project and run `flutterfire configure` for macOS and Linux targets
2. Define Firestore collection structure (see `data_model.md`)
3. Implement `FirestoreSlotRepository` and `FirestoreTaskRepository` behind abstract `SlotRepository` / `TaskRepository` interfaces
4. Set up Firebase Auth with email/password — no social login needed initially
5. Add Firestore security rules: users can only read/write their own documents, with an exception for shared household documents

Open questions:
- How to model shared household data vs per-user data in Firestore? (e.g., a shared `household/{id}/slots` collection vs each user owning their own)
- Should we use a single shared account for the household, or two separate accounts with shared document access?
