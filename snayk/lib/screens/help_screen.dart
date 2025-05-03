import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  static final String routeName = "/help_screen";
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff424242),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "🎮 Objective ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                """Control a snake that gets longer every time it eats food (the dot). The main objective is to eat as much food as possible to make the snake grow while avoiding crashing into the walls or running into your own body.""",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Text(
                "🕹️ Controls",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                """Up ⬆️

Down ⬇️

Left ⬅️

Right ➡️
""",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Text(
                """One key rule: you can’t reverse direction immediately. For example, if you're going right, you can't go left in the next move.""",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Text(
                "⚖️ Game Rules",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                """The snake moves automatically in the current direction and continues until you change it. Each time the snake eats a piece of food, it grows longer. The game ends if the snake hits a wall (in some versions) or runs into its own body. You earn points for every piece of food eaten, and in some versions, bonus items may appear that give extra points.""",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
