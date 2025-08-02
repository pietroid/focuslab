import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:music_experience_repository/music_experience_repository.dart';

part 'music_experience_state.dart';

class MusicExperienceCubit extends Cubit<MusicExperienceState> {
  MusicExperienceCubit({
    required this.musicExperienceRepository,
  }) : super(MusicExperienceInitial());

  final MusicExperienceRepository musicExperienceRepository;

  void loadMusic() async {
    emit(MusicExperienceLoading());
    try {
      await musicExperienceRepository.loadMusic();
      emit(MusicExperiencePlaying());
      musicExperienceRepository.playMusic();
    } catch (error) {
      emit(MusicExperienceError(error.toString()));
    }
  }

  @override
  Future<void> close() {
    musicExperienceRepository.stop();
    return super.close();
  }
}
