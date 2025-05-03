import 'package:flutter/material.dart';
import 'package:snayk/screens/play_screen.dart';

class DifficultyScreen extends StatelessWidget {
  static final String routeName = "/difficulty_screen";
  const DifficultyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff424242),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20.0,
          children: [
            difficultyButton(context, "Easy"),
            difficultyButton(context, "Medium"),
            difficultyButton(context, "Hard"),
          ],
        ),
      ),
    );
  }

  Material difficultyButton(BuildContext context, String difficulty) {
    return Material(
      color: Colors.green,
      borderRadius: BorderRadius.circular(10.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PlayScreen(difficulty: difficulty)));
        },
        borderRadius: BorderRadius.circular(10.0),
        splashColor: Colors.white.withValues(alpha: 0.3),
        hoverColor: Colors.white.withValues(alpha: 0.1),
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 60.0,
          height: MediaQuery.of(context).size.height / 12,
          child: Center(
            child: Text(
              difficulty,
              style: TextStyle(
                color: Colors.white,
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
