import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focuslab/music_experience/cubit/music_experience_cubit.dart';
import 'package:focuslab/music_experience/widgets/music_experience_canvas.dart';
import 'package:music_experience_repository/music_experience_repository.dart';

class MusicExperiencePage extends StatelessWidget {
  const MusicExperiencePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MusicExperienceCubit(
        musicExperienceRepository: context.read<MusicExperienceRepository>(),
      )..loadAndPlayMusic(),
      child: DefaultScaffold(
          body: const MusicExperienceView(), title: 'Music Experience'),
    );
  }
}

class MusicExperienceView extends StatelessWidget {
  const MusicExperienceView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MusicExperienceCubit, MusicExperienceState>(
      builder: (context, state) {
        if (state is MusicExperienceLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is MusicExperiencePlaying) {
          return Center(
            child: MusicExperienceCanvas(
              beat: state.beat,
              beatProgress: state.beatProgress,
            ),
          );
        }
        return const Placeholder();
      },
    );
  }
}
