import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snayk/components/play_screen_board.dart';
import 'package:snayk/components/play_screen_header.dart';
import 'package:snayk/screens/home_screen.dart';

import 'package:snayk/services/sound_service.dart';

class PlayScreen extends StatefulWidget {
  final String difficulty;
  const PlayScreen({super.key, required this.difficulty});

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  List<int> snakePosition = [55, 80, 105, 130];
  List<int> obstacles = [];
  int foodPosition = Random().nextInt(650);
  int bonusPosition = -500;
  double bonusTime = 1;
  int foodEaten = 0;
  String direction = "down";
  int score = 0;
  int highestScore = 0;
  Timer? gameTimer;
  Timer? bonusTimer;
  int timeSpeed = 500;
  bool _canChangeDirection = true;

  bool isMuted = false;
  IconData volumeIcon = Icons.volume_up;
  IconData stateIcon = Icons.pause;
  bool isPaused = false;
  final soundService = SoundService();

  void initGame() {
    if (widget.difficulty == "Easy") {
      obstacles = [];
    } else if (widget.difficulty == "Medium") {
      obstacles = [
        52,
        53,
        54,
        77,
        102,
        70,
        71,
        72,
        97,
        122,
        527,
        552,
        577,
        578,
        579,
        547,
        572,
        595,
        596,
        597
      ];
    } else {
      obstacles = [
        52,
        53,
        54,
        77,
        102,
        70,
        71,
        72,
        97,
        122,
        255,
        256,
        257,
        258,
        259,
        260,
        261,
        262,
        263,
        264,
        265,
        266,
        267,
        268,
        269,
        405,
        406,
        407,
        408,
        409,
        410,
        411,
        412,
        413,
        414,
        415,
        416,
        417,
        418,
        419,
        527,
        552,
        577,
        578,
        579,
        547,
        572,
        595,
        596,
        597
      ];
    }
    snakePosition = [55, 80, 105, 130];
    foodPosition = Random().nextInt(650);
    direction = "down";
    score = 0;
    timeSpeed = 500;
    foodEaten = 0;
    bonusTime = 1;
    updatePosition();
  }

  @override
  void initState() {
    super.initState();
    initGame();
  }

  void loadHighestScore() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      highestScore = prefs.getInt("highestScore") ?? 0;
    });
  }

  void generateFood() async {
    do {
      foodPosition = Random().nextInt(650);
    } while (snakePosition.contains(foodPosition) ||
        obstacles.contains(foodPosition));

    if (foodEaten > 0 && foodEaten % 10 == 0) {
      do {
        bonusPosition = Random().nextInt(650);
      } while (bonusPosition == foodPosition ||
          snakePosition.contains(bonusPosition) ||
          obstacles.contains(bonusPosition));
      bonusTime = 1;
      if (!isMuted) soundService.playGenerateBonusSound();
      startBonusTimer();
    } else {
      bonusPosition = -500;
      bonusTime = 0;
    }
    saveScore();
  }

  void startBonusTimer() {
    bonusTimer?.cancel();
    bonusTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (bonusTime <= 0) {
        timer.cancel();
        setState(() {
          bonusPosition = -500;
        });
      } else {
        setState(() {
          bonusTime = double.parse((bonusTime - 0.1).toStringAsFixed(1));
        });
      }
    });
  }

  void gameOver() {
    showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Center(
          child: Text("Game Over"),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, HomeScreen.routeName);
                },
                child: const Text(
                  'Exit',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: () async {
                  initGame();
                  Navigator.pop(context);
                },
                child: const Text(
                  "Play again",
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void updatePosition() {
    gameTimer?.cancel();
    gameTimer =
        Timer.periodic(Duration(milliseconds: timeSpeed), (Timer timer) {
      if (isPaused) return;
      if (direction == "down") {
        setState(() {
          snakePosition.add(snakePosition.last <= 625
              ? snakePosition.last + 25
              : snakePosition.last - 650 + 25);
        });
      } else if (direction == "up") {
        setState(() {
          snakePosition.add(snakePosition.last >= 25
              ? snakePosition.last - 25
              : snakePosition.last + 650 - 25);
        });
      } else if (direction == "left") {
        setState(() {
          snakePosition.add(snakePosition.last % 25 >= 1
              ? snakePosition.last - 1
              : snakePosition.last + 24);
        });
      } else {
        setState(() {
          snakePosition.add((snakePosition.last + 1) % 25 == 0
              ? snakePosition.last - 25 + 1
              : snakePosition.last + 1);
        });
      }
      if (snakePosition.last == foodPosition) {
        setState(() {
          score += 10;
          if (!isMuted) soundService.playEatFoodSound();
          foodEaten++;
          generateFood();
        });
      } else if (snakePosition.last == bonusPosition) {
        setState(() {
          score += 50;
          if (!isMuted) soundService.playEatFoodSound();
          foodEaten++;
          generateFood();
        });
      } else {
        setState(() {
          snakePosition.removeAt(0);
        });
      }

      bool hasCommon =
          snakePosition.toSet().intersection(obstacles.toSet()).isNotEmpty;

      if (countNumberOccurrences(snakePosition, snakePosition.last) > 1 ||
          hasCommon) {
        gameOver();
        if (!isMuted) soundService.playGameOverSound();
        timer.cancel();
      }
    });
  }

  int countNumberOccurrences(List<int> numbers, int target) {
    return numbers.where((n) => n == target).length;
  }

  void saveScore() async {
    if (score > highestScore) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setInt("highestScore", score);
    }
  }

  @override
  void dispose() {
    gameTimer?.cancel();
    bonusTimer?.cancel();
    soundService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff424242),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            PlayScreenHeader(
                isMuted: isMuted,
                volumeIcon: volumeIcon,
                score: score,
                isPaused: isPaused,
                stateIcon: stateIcon,
                toggleMute: () {
                  setState(() {
                    isMuted = !isMuted;
                    isMuted
                        ? volumeIcon = Icons.volume_off
                        : volumeIcon = Icons.volume_up;
                  });
                },
                togglePause: () {
                  setState(() {
                    isPaused = !isPaused;
                    isPaused
                        ? stateIcon = Icons.play_arrow
                        : stateIcon = Icons.pause;
                  });
                }),
            Spacer(),
            PlayScreenBoard(
                snakePosition: snakePosition,
                direction: direction,
                foodPosition: foodPosition,
                bonusPosition: bonusPosition,
                bonusTime: bonusTime,
                obstacles: obstacles),
            bonusPosition != -500
                ? LinearPercentIndicator(
                    padding: EdgeInsets.all(0.0),
                    width: MediaQuery.of(context).size.width,
                    lineHeight: 10.0,
                    percent: bonusTime,
                    backgroundColor: Colors.grey,
                    progressColor: Colors.red,
                  )
                : SizedBox(
                    height: 10.0,
                  ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    createDirectionButton(Icons.arrow_upward_outlined, "up"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 60.0,
                      children: [
                        createDirectionButton(
                            Icons.arrow_back_outlined, "left"),
                        createDirectionButton(
                            Icons.arrow_forward_outlined, "right"),
                      ],
                    ),
                    createDirectionButton(
                        Icons.arrow_downward_outlined, "down"),
                  ],
                ),
                Material(
                  shape: const CircleBorder(),
                  color: Colors.green,
                  child: InkWell(
                    onTapDown: (_) {
                      setState(() {
                        timeSpeed = 10;
                        updatePosition();
                        if (!isMuted && !isPaused) {
                          soundService.playSpeedSound();
                        }
                      });
                    },
                    onTapUp: (_) {
                      setState(() {
                        timeSpeed = 500;
                        updatePosition();
                        if (!isMuted && !isPaused) soundService.pause();
                      });
                    },
                    onTapCancel: () {
                      setState(() {
                        timeSpeed = 500;
                        updatePosition();
                        if (!isMuted && !isPaused) soundService.pause();
                      });
                    },
                    customBorder: const CircleBorder(),
                    splashColor: Colors.white.withValues(alpha: 0.3),
                    hoverColor: Colors.white.withValues(alpha: 0.1),
                    child: SizedBox(
                      height: 100.0,
                      width: 100.0,
                      child: Center(
                        child: Text(
                          "Speed",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }

  IconButton createDirectionButton(IconData icon, String newDirection) {
    return IconButton(
      padding: EdgeInsets.all(20.0),
      color: Colors.green,
      onPressed: () {
        if (!_canChangeDirection) return;

        bool isOpposite = (direction == "up" && newDirection == "down") ||
            (direction == "down" && newDirection == "up") ||
            (direction == "left" && newDirection == "right") ||
            (direction == "right" && newDirection == "left");

        if (!isOpposite && direction != newDirection) {
          setState(() {
            direction = newDirection;

            _canChangeDirection = false;
          });

          if (!isMuted && !isPaused) soundService.playChooseDirectionSound();

          Timer(const Duration(milliseconds: 350), () {
            setState(() {
              _canChangeDirection = true;
            });
          });
        }
      },
      icon: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}
