import 'dart:async';

import 'package:flutter/material.dart';
import 'package:focus/events/models/event_model.dart';

/// Height of the media player pill — taller than the regular action pill to
/// accommodate the progress bar, time labels, and event name.
const double kMediaPlayerPillHeight = 72;

/// Width of the media player pill — matches the collapsed action pill width.
const double kMediaPlayerPillWidth = 300;

/// {@template action_media_player_pill}
/// A pill-shaped media-player bar shown at the bottom of the screen whenever
/// an [Event] is currently in progress.
///
/// Displays:
/// - A **play/pause** button that freezes or resumes the live countdown.
/// - An **elapsed / remaining** time row above a thin progress bar.
/// - The **event name** below the progress bar.
/// - The current **clock time** (HH:mm) on the right, prominently highlighted.
///
/// The widget is purely presentational — it receives a snapshot of [now] and
/// [isPaused] from its parent, which owns the tick [Timer] and the pause
/// toggle state. Call [onTogglePause] to flip the paused state.
/// {@endtemplate}
class ActionMediaPlayerPill extends StatelessWidget {
  /// {@macro action_media_player_pill}
  const ActionMediaPlayerPill({
    required this.event,
    required this.now,
    required this.isPaused,
    required this.onTogglePause,
    super.key,
  });

  /// The event currently in progress.
  final Event event;

  /// The current point in time, updated every second by the parent's ticker.
  ///
  /// When [isPaused] is `true` the parent stops updating this value,
  /// effectively freezing the displayed elapsed time and progress.
  final DateTime now;

  /// Whether the countdown display is paused.
  ///
  /// Does not affect the underlying [Event] — the event keeps running. Only
  /// the on-screen timer is frozen.
  final bool isPaused;

  /// Called when the user taps the play/pause button.
  final VoidCallback onTogglePause;

  /// Formats a [Duration] as `mm:ss` (or `h:mm:ss` for durations ≥ 1 hour).
  String _formatDuration(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return h > 0 ? '$h:$m:$s' : '$m:$s';
  }

  /// Formats a [DateTime] as a zero-padded `HH:mm` clock string.
  String _formatClock(DateTime dt) {
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  @override
  Widget build(BuildContext context) {
    final total = event.endDate.difference(event.startDate);
    final elapsed = now.difference(event.startDate);
    final remaining = event.endDate.difference(now);
    final progress = (elapsed.inSeconds / total.inSeconds).clamp(0.0, 1.0);

    return Container(
      height: kMediaPlayerPillHeight,
      width: kMediaPlayerPillWidth,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 0, 29, 52),
        borderRadius: BorderRadius.all(Radius.circular(24)),
        border: Border.fromBorderSide(
          BorderSide(
            color: Color.fromARGB(71, 255, 255, 255),
            width: 0.5,
          ),
        ),
        boxShadow: [BoxShadow(blurRadius: 20, spreadRadius: 5)],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              // ── Play / pause ──────────────────────────────────────────────
              IconButton(
                onPressed: onTogglePause,
                icon: Icon(
                  isPaused ? Icons.play_arrow_rounded : Icons.pause_rounded,
                  color: Colors.white,
                  size: 26,
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
              ),
              const SizedBox(width: 10),

              // ── Progress column ───────────────────────────────────────────
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Elapsed / remaining labels
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _formatDuration(elapsed),
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '-${_formatDuration(remaining)}',
                          style: const TextStyle(
                            color: Colors.white38,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),

                    // Progress bar
                    ClipRRect(
                      borderRadius: BorderRadius.circular(3),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 4,
                        backgroundColor: Colors.white12,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Colors.white70,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),

                    // Event name
                    Text(
                      event.name,
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),

              // ── Current clock time ────────────────────────────────────────
              Text(
                _formatClock(now),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(width: 2),
            ],
          ),
        ),
      ),
    );
  }
}
