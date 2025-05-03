import 'package:flutter/material.dart';
import 'package:snayk/screens/about_screen.dart';
import 'package:snayk/screens/difficulty_screen.dart';
import 'package:snayk/screens/help_screen.dart';
import 'package:snayk/screens/home_screen.dart';
import 'package:snayk/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snake game',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        DifficultyScreen.routeName: (context) => DifficultyScreen(),
        HelpScreen.routeName: (context) => HelpScreen(),
        AboutScreen.routeName: (context) => AboutScreen(),
      },
    );
  }
}
