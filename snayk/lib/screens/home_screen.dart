import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snayk/screens/about_screen.dart';
import 'package:snayk/screens/difficulty_screen.dart';
import 'package:snayk/screens/help_screen.dart';

class HomeScreen extends StatefulWidget {
  static final String routeName = "/home_screen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? highestScore;

  @override
  void initState() {
    super.initState();
    _loadHighScore();
  }

  Future<void> _loadHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    final highestScoreLoaded = prefs.getInt("highestScore") ?? 0;

    setState(() {
      highestScore = highestScoreLoaded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff424242),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20.0,
            children: [
              customButton(context, "Play",
                  routeName: DifficultyScreen.routeName),
              customButton(context, "Highest Score"),
              customButton(context, "Help", routeName: HelpScreen.routeName),
              customButton(context, "About Developer",
                  routeName: AboutScreen.routeName),
            ],
          ),
        ),
      ),
    );
  }

  Material customButton(BuildContext context, String textButton,
      {String? routeName}) {
    return Material(
      color: Colors.green,
      borderRadius: BorderRadius.circular(10.0),
      child: InkWell(
        onTap: () {
          if (routeName != null) {
            Navigator.pushNamed(context, routeName);
          } else {
            _loadHighScore();
            showDialog<String>(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) => AlertDialog(
                backgroundColor: Colors.green,
                title: Center(
                  child: Text(
                    "Highest Score: $highestScore",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                actions: <Widget>[
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'OK',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
        borderRadius: BorderRadius.circular(10.0),
        splashColor: Colors.white.withValues(alpha: 0.3),
        hoverColor: Colors.white.withValues(alpha: 0.1),
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 60.0,
          height: MediaQuery.of(context).size.height / 12,
          child: Center(
            child: Text(
              textButton,
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
