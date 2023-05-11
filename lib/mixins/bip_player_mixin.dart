import 'package:audioplayers/audioplayers.dart';
import 'package:vibration/vibration.dart';

mixin BipPlayerMixin {
  // Future<AudioPlayer> playLocalAsset({bool isEnd = false}) async {
  //   AudioCache cache = AudioCache();
  //   if (isEnd) {
  //     return await cache.load("sounds/beep_end.mp3");
  //   }
  //   return await cache.load("sounds/beep_start.mp3");
  // }

  Future<void> playBipIfShould(int tick, int endTick,
      {List<int>? warningTicks}) async {
    if (warningTicks != null && warningTicks.contains(tick)) {
      // playLocalAsset();
    }
    if (tick == endTick) {
      // playLocalAsset(isEnd: true);
      bool? hasVibrator = await Vibration.hasVibrator();
      if (hasVibrator != null && hasVibrator) {
        Vibration.vibrate();
      }
    }
  }
}
