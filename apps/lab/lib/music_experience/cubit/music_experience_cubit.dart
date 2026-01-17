import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:music_experience_repository/music_experience_repository.dart';

part 'music_experience_state.dart';

class MusicExperienceCubit extends Cubit<MusicExperienceState> {
  StreamSubscription<Duration>? _positionSubscription;

  MusicExperienceCubit({
    required this.musicExperienceRepository,
  }) : super(MusicExperienceInitial());

  final MusicExperienceRepository musicExperienceRepository;

  void loadAndPlayMusic() async {
    emit(MusicExperienceLoading());
    try {
      await musicExperienceRepository.loadMusic();
      musicExperienceRepository.playMusic();
      _positionSubscription = musicExperienceRepository.positionStream.listen(
        updatePosition,
      );
      emit(MusicExperiencePlaying(
        totalDuration: musicExperienceRepository.musicDuration,
      ));
    } catch (error) {
      emit(MusicExperienceError(error.toString()));
    }
  }

  void updatePosition(Duration position) {
    final beatsPerSecond = musicExperienceRepository.bpm / 60.0;
    final secondsPerBeat = 1 / beatsPerSecond;
    final beat =
        (position.inMilliseconds - musicExperienceRepository.beatOffsetMillis) /
            1000 /
            secondsPerBeat;
    // Handle position update logic here if needed
    emit(
      MusicExperiencePlaying(
        position: position,
        totalDuration: musicExperienceRepository.musicDuration,
        beat: beat.floor(),
        beatProgress: beat - beat.floor(),
      ),
    );
  }

  @override
  Future<void> close() {
    musicExperienceRepository.stop();
    _positionSubscription?.cancel();
    return super.close();
  }
}
