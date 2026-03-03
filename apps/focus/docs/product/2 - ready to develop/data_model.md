# Why

Before any UI can display real data, the core entities must be defined in code and in Firestore. The data model is the contract that all features depend on — getting it right early prevents costly refactors later.

# What

Two primary entities:

**Slot** — a recurring or one-off time block (the structural unit of the day)
- `id`: String
- `title`: String
- `startTime`: TimeOfDay (hour + minute)
- `endTime`: TimeOfDay (hour + minute)
- `color`: Color (hex string)
- `recurrenceRule`: String? (iCal RRULE format, null if one-off)
- `userId`: String
- `householdId`: String

**Task** — a specific item of work assigned to a slot on a given day
- `id`: String
- `title`: String
- `slotId`: String (reference to parent Slot)
- `userId`: String
- `date`: DateTime (the calendar day this task belongs to)
- `status`: enum (pending, done, skipped)
- `notes`: String?

**User** — basic profile
- `id`: String (matches Firebase Auth UID)
- `displayName`: String
- `householdId`: String

Firestore collection structure:
```
/households/{householdId}/
  /slots/{slotId}
  /tasks/{taskId}
/users/{userId}
```

Acceptance criteria:
- Dart model classes exist for `Slot`, `Task`, and `User` with `fromJson`/`toJson`
- Models are immutable (use `freezed`)
- Repository interfaces exist: `SlotRepository`, `TaskRepository`
- Firestore implementations exist for both repositories
- Unit tests cover serialization round-trips for all models

# How

1. Add `freezed`, `freezed_annotation`, `json_annotation`, `build_runner` to `pubspec.yaml`
2. Create `lib/data/models/slot.dart`, `task.dart`, `user.dart` with `@freezed` annotation
3. Run `dart run build_runner build` to generate `.freezed.dart` and `.g.dart` files
4. Create `lib/data/repositories/slot_repository.dart` and `task_repository.dart` as abstract interfaces
5. Create `lib/data/repositories/firestore_slot_repository.dart` and `firestore_task_repository.dart` implementing the interfaces
6. Write unit tests in `test/data/models/` covering `fromJson`/`toJson` for each model
