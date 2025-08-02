part of 'music_experience_cubit.dart';

@immutable
sealed class MusicExperienceState {}

final class MusicExperienceInitial extends MusicExperienceState {}

final class MusicExperienceLoading extends MusicExperienceState {}

final class MusicExperiencePlaying extends MusicExperienceState {}

final class MusicExperienceError extends MusicExperienceState {
  MusicExperienceError(this.message);

  final String message;
}
