# Why

The drag mechanics of the calendar is working decently but it has some things to round off, and the code is not looking the best.

# What

- The current time bar is in the hour level. It must be at the day level, and above everything else on the stack.
- When a user does a gesture there are many things at play that are conflicting, in multiple layers. We must have a single, unified drag handler in a unified widget that decides everything and delegates its actions to other parts of the application.

# How

- Use the day column as the single source of truth for the day. Calculating offsets by hourUnitHeight is a good approach and we can stick to this.
- The day column should have three surfaces: the top one is concering drag handling. We use the unified dragHandler widget with a unified drag_handler_bloc
    - It must detect mouse down after holding for a little longer (as it does currently). 
    - If this start is within a region of an event this hold indicates that the event is selected and we can drag it
    - If this start is outside a region of an event, this indicates that the user wants to create a new event by measuring the difference of location of drag start and drag end (as it's done today)
    - If this start is by the border of an event (but just within that event region), it indicates that the user can change the event duration via determining the drag end.
- Use this drag handler bloc _just_ to determine the drags events, etc. But the logic of event changing must be passed to another bloc, via BlocListener on the UI layer.