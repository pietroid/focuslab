part of 'music_experience_cubit.dart';

@immutable
sealed class MusicExperienceState {}

final class MusicExperienceInitial extends MusicExperienceState {}

final class MusicExperienceLoading extends MusicExperienceState {}

final class MusicExperiencePlaying extends MusicExperienceState {
  MusicExperiencePlaying({
    required this.totalDuration,
    this.position = Duration.zero,
    this.beat = 0,
    this.beatProgress = 0.0,
  });

  /// current position of the music
  final Duration position;

  /// total duration of the music
  final Duration totalDuration;

  /// current beat of the music
  final int beat;

  /// progress of the current beat
  final double beatProgress;
}

final class MusicExperienceError extends MusicExperienceState {
  MusicExperienceError(this.message);

  final String message;
}
