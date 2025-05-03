import 'package:audioplayers/audioplayers.dart';

class SoundService {
  final AudioPlayer player = AudioPlayer();

  void playEatFoodSound() async {
    await player.play(AssetSource("sounds/eatFood.wav"));
  }

  void playChooseDirectionSound() async {
    await player.play(AssetSource("sounds/chooseDirection.wav"));
  }

  void playSpeedSound() async {
    await player.play(AssetSource("sounds/speed.wav"));
  }

  void playGenerateBonusSound() async {
    await player.play(AssetSource("sounds/generateBonus.wav"));
  }

  void playGameOverSound() async {
    await player.play(AssetSource("sounds/gameOver.wav"));
  }

  void pause() async {
    await player.pause();
  }

  void dispose() {
    player.dispose();
  }
}
