import 'package:flutter/material.dart';
import 'models.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 180, 74),
      body: PageView.builder(
        itemCount: models.length,
        itemBuilder: (_, i) {
          return Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Image.asset(
                  models[i].image,
                ),
                Text(models[i].title),
                Text(models[i].text),
              ],
            ),
          );
        },
      ),
    );
  }
}
