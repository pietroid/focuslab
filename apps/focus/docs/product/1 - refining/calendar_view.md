# Why

The calendar view is the core interface of the app. It gives a spatial, visual representation of time that makes it possible to see, plan, and adjust the day without losing the big picture. Everything else in the system feeds into or out of this view.

# What

- Full-screen calendar occupying the entire display (TV and Desktop)
- Multiple days displayed side-by-side in columns (horizontal axis = days, vertical axis = time of day)
- Zoom in/out to adjust time density (e.g., zoom in to see 15-min slots, zoom out to see a full week at a glance)
- Two user timelines rendered simultaneously in each day column (for household use)
- Slots displayed as colored blocks with title and time range
- Tasks displayed within their parent slot as a list or compact chips
- Tap/click on empty space to open a quick-add form for a new event
- Drag-and-drop to move events between times and days

Acceptance criteria:
- All visible time from wake-up to sleep is represented (not just 9–5)
- Two users' timelines are visually distinct but readable in the same column
- Scroll is smooth and performant even with 100+ events visible
- Adding a new event requires no more than 2 taps from the calendar view

Open design questions:
- How are the two user timelines laid out within one day column? Side-by-side sub-columns, or overlapping with opacity?
- What does a slot look like visually vs a task?
- How does zoom interact with recurring slots — do they collapse or stack?

# How

- Build a custom Flutter widget using a `CustomScrollView` with a `SliverList` or `CustomPainter` for the time grid
- Horizontal scrolling for day navigation (`PageView` or `ListView.horizontal`)
- Vertical scroll locked to the time axis
- Use `InteractiveViewer` or a custom gesture handler for pinch-to-zoom on the time axis
- Reference: `table_calendar` and `flutter_calendar_carousel` packages for grid layout patterns, but likely build custom to meet the specific requirements
- Planned widget tree: `CalendarPage` → `CalendarGrid` → `DayColumn` → `SlotBlock` / `TaskChip`
