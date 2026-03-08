import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

/// {@template music_experience_repository}
/// Repository to interact with the music experience feature of the application.
/// {@endtemplate}
class MusicExperienceRepository {
  BehaviorSubject<Duration>? _positionSubject;

  /// {@macro music_experience_repository}
  /// Player instance to handle audio playback.
  late final AudioPlayer player = AudioPlayer();

  /// BPM of the music.
  double get bpm => 101;

  double get beatOffsetMillis => 0;

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

  /// Position of the music playing
  Stream<Duration> get positionStream {
    if (_positionSubject == null) {
      _positionSubject =
          BehaviorSubject<Duration>(onCancel: () => _positionSubject = null);

      _positionSubject!.addStream(
        player.createPositionStream(
          steps: 100000,
          minPeriod: const Duration(milliseconds: 16),
          maxPeriod: const Duration(milliseconds: 16),
        ),
      );
    }
    return _positionSubject!.stream;
  }

  /// Duration of current music
  Duration get musicDuration => player.duration ?? Duration.zero;

  /// Stops the music
  Future<void> stop() async {
    if (player.playing) {
      await player.stop();
    }
    await _positionSubject?.close();
    _positionSubject = null;
  }
}
