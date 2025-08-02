import 'package:just_audio/just_audio.dart';

/// {@template music_experience_repository}
/// Repository to interact with the music experience feature of the application.
/// {@endtemplate}
class MusicExperienceRepository {
  /// {@macro music_experience_repository}
  /// Player instance to handle audio playback.
  late final AudioPlayer player = AudioPlayer();

  /// Load the music from assets
  Future<void> loadMusic() async {
    try {
      await player.setAsset('assets/music/sonic riots.mp3');
    } catch (error) {
      throw Exception('Failed to load music: $error');
    }
  }

  /// Play the loaded music
  Future<void> playMusic() async {
    if (player.playing) {
      await player.stop();
    }
    await player.play();
  }

  /// Stops the music
  void stop() {
    if (player.playing) {
      player.stop();
    }
  }
}
