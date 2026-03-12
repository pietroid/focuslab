# Why

We need a todo list feature to store tasks and things that needs prioritization but still don't have a clear day/time pinned down.

# What

- A menu bar to the right side, as would be a day in the calendar, but it's fixed. It can have even the grids because we can have a "budget" of time visibility, meaning we can know how many hours this list will be completed.
- Any events can be dragged from this "day" to any other day.
- All events behave the same as they behave in any other day of the calendar - so they can be dragged, etc.

# How

- Use the same DayColumn structure - make only the necessary adapatations.
- Put this column above all the calendar structure - it's just a sheet that scrolls from the side - left to right.
- Create a bottom menu where we will have multiple icons in the future - for now, just the todo list icon - which we can tap and the sheet will open or close. 
