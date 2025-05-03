import 'package:flutter/material.dart';

class PlayScreenHeader extends StatelessWidget {
  final bool isMuted;
  final IconData volumeIcon;
  final VoidCallback toggleMute;
  final int score;
  final bool isPaused;
  final IconData stateIcon;
  final VoidCallback togglePause;

  const PlayScreenHeader({
    super.key,
    required this.isMuted,
    required this.volumeIcon,
    required this.toggleMute,
    required this.score,
    required this.isPaused,
    required this.stateIcon,
    required this.togglePause,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          onPressed: toggleMute,
          icon: Icon(volumeIcon, size: 32.0, color: Colors.grey),
        ),
        Text(
          "Score : $score",
          style: TextStyle(color: Colors.white, fontSize: 24.0),
        ),
        IconButton(
          onPressed: togglePause,
          icon: Icon(
            stateIcon,
            size: 32.0,
            color: isPaused ? Colors.green : Colors.redAccent,
          ),
        ),
      ],
    );
  }
}
