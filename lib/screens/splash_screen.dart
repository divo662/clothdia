import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:store/screens/carsouel.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 11), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => const CarsouelPage()
          )
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange.shade50,
      body: Container(
        height: double.infinity,
        decoration:  BoxDecoration(
          color: Colors.deepOrange.shade50
        ),
        child:  SafeArea(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 300,),
                AnimatedTextKit(
                    animatedTexts: [
                      ColorizeAnimatedText(
                        "Clothdia",
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 63,
                            fontWeight: FontWeight.bold
                          ),
                          colors: [
                            Colors.orange,
                            Colors.red,
                            Colors.black,
                          ],
                        speed: const Duration(seconds: 2)
                      ),
                    ]
                ),
                const SizedBox(height: 12,),
                AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText("The Ultimate Divine Fashion...",
                          speed: const Duration(milliseconds: 210),
                          textStyle:  TextStyle(
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.bold,
                              fontSize: 24
                          ),
                          curve: Curves.easeInCirc
                      )

                    ]
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
