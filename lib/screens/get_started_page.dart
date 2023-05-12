import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:store/screens/login_page.dart';
import 'package:store/screens/register.dart';

class StartedPage extends StatefulWidget {
  const StartedPage({Key? key}) : super(key: key);

  @override
  State<StartedPage> createState() => _StartedPageState();
}

class _StartedPageState extends State<StartedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange.shade50,
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(color: Colors.deepOrange.shade50),
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 202,
                ),
                AnimatedTextKit(animatedTexts: [
                  ColorizeAnimatedText("Clothdia",
                      textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 63,
                          fontWeight: FontWeight.bold),
                      colors: [
                        Colors.orange,
                        Colors.red,
                        Colors.black,
                      ],
                      speed: const Duration(seconds: 7)),
                ]),
                const SizedBox(
                  height: 12,
                ),
                AnimatedTextKit(animatedTexts: [
                  FadeAnimatedText(
                    "The Ultimate Divine Fashion...",
                    textStyle: TextStyle(
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  ),
                  TyperAnimatedText(
                    "Looking for the best outfit to fit you?",
                    textStyle: TextStyle(
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  ),
                  TyperAnimatedText(
                    "Don't know where to get this outfit?",
                    textStyle: TextStyle(
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  ),
                  TyperAnimatedText(
                    "Don't worry we got you covered..."
                    "         shop with Clothdia now",
                    textStyle: TextStyle(
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  TyperAnimatedText(
                    "Get started to continue...",
                    textStyle: TextStyle(
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  ),
                ]),
                const SizedBox(
                  height: 63,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                  },
                  child: Container(
                    height: 47,
                    width: 340,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                              blurRadius: 2,
                              spreadRadius: 0.4,
                              color: Colors.black)
                        ]),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.login_sharp,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 79,
                        ),
                        Text(
                          "Login Now",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 19),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 26,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterPage()));
                  },
                  child: Container(
                    height: 47,
                    width: 340,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13),
                        color: Colors.black,
                        boxShadow: const [
                          BoxShadow(
                              blurRadius: 2,
                              spreadRadius: 0.6,
                              color: Colors.black)
                        ]),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.how_to_reg_sharp,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 79,
                        ),
                        Text(
                          " Register Now",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 19),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
