import 'package:flutter/material.dart';
import 'package:snayk/components/about_screen_custom_card.dart';

class AboutScreen extends StatelessWidget {
  static final String routeName = "/about_screen";
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const String phoneNumber = "+216 26738221";
    const String email = "brinsitakiallah@gmail.com";
    return Scaffold(
      backgroundColor: Color(0xff424242),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10.0,
          children: [
            const CircleAvatar(
              radius: 70.0,
              backgroundImage: AssetImage("assets/images/me.png"),
            ),
            const Text(
              "Brinsi Mohamed Taki Allah",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 1.0,
            ),
            Text(
              "Mobile Developer",
              style: TextStyle(
                color: Colors.grey.shade200,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5.0,
              width: MediaQuery.of(context).size.width / 2,
              child: Divider(
                color: Colors.green[100],
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            CustomCard(phoneNumber: phoneNumber),
            SizedBox(
              height: 5.0,
            ),
            CustomCard(email: email),
          ],
        ),
      ),
    );
  }
}
