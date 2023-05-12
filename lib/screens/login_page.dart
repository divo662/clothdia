import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store/screens/forgot_password.dart';
import 'package:store/screens/bottom_navigator_page.dart';
import 'package:store/screens/register.dart';

import 'get_started_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  bool isButtonEnabled = false;
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isSelectedOn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepOrange[50],
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.deepOrange[50],
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const StartedPage()));
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 26,
              weight: 7,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 70,
                ),
                const Row(
                  children: [
                    SizedBox(
                      width: 25,
                    ),
                    Text(
                      "Welcome!",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 34,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 25,
                    ),
                    AnimatedTextKit(animatedTexts: [
                      TyperAnimatedText(
                        "Login into your account.",
                        textStyle: TextStyle(
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                      TyperAnimatedText(
                        "Login into your account.",
                        textStyle: TextStyle(
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                      TyperAnimatedText(
                        "Login into your account.",
                        textStyle: TextStyle(
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                    ])
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  height: 267,
                  width: 370,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    color: Colors.deepOrange.shade50,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: () {
                            setState(() {
                              isButtonEnabled =
                                  _formKey.currentState!.validate();
                            });
                          },
                          child: Column(
                            children: [
                              Container(
                                  height: 47,
                                  width: 340,
                                  decoration: BoxDecoration(
                                      color: Colors.deepOrange.shade50,
                                      border: const Border(
                                          top: BorderSide.none,
                                          left: BorderSide.none,
                                          right: BorderSide.none,
                                          bottom: BorderSide(
                                              color: Colors.black,
                                              width: 1.5))),
                                  child: TextFormField(
                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    enableSuggestions: true,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please enter your email";
                                      }
                                      if (!RegExp(
                                              "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                          .hasMatch(value)) {
                                        return "Please enter a valid email";
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      emailController.text = value!;
                                    },
                                    autofocus: false,
                                    style: const TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Email",
                                        hintStyle: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                        prefixIcon: Icon(Icons.email)),
                                  )),
                              const SizedBox(
                                height: 40,
                              ),
                              Container(
                                  height: 47,
                                  width: 340,
                                  decoration: BoxDecoration(
                                      color: Colors.deepOrange.shade50,
                                      border: const Border(
                                          top: BorderSide.none,
                                          left: BorderSide.none,
                                          right: BorderSide.none,
                                          bottom: BorderSide(
                                              color: Colors.black,
                                              width: 1.5))),
                                  child: TextFormField(
                                    controller: passwordController,
                                    textInputAction: TextInputAction.done,
                                    obscureText: isSelectedOn,
                                    autofocus: false,
                                    validator: (value) {
                                      RegExp regex = RegExp(
                                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$');

                                      if (value!.isEmpty) {
                                        return 'Password is required';
                                      }

                                      if (!regex.hasMatch(value)) {
                                        return 'Please enter a valid password (Min. 6 characters, with at least one uppercase letter, one lowercase letter, and one digit)';
                                      }

                                      return null;
                                    },
                                    onSaved: (value) {
                                      passwordController.text = value!;
                                    },
                                    style: const TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        // THE HINT TEXT FOR LOGIN PASSWORD
                                        hintText: "Password",
                                        hintStyle: const TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                        prefixIcon:
                                            const Icon(Icons.lock_person_sharp),
                                        //SHOW PASSWORD OR NOT........................
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isSelectedOn = !isSelectedOn;
                                            });
                                          },
                                          child: Icon(isSelectedOn
                                              ? CupertinoIcons.eye_solid
                                              : CupertinoIcons.eye_slash_fill),
                                        )),
                                  )),
                            ],
                          )),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 185,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgotPassword()));
                            },
                            child: const Text(
                              "Forgot Password?",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: isButtonEnabled && !isLoading
                      ? () {
                          signIn(emailController.text, passwordController.text);
                        }
                      : null,
                  child: Opacity(
                    opacity: isButtonEnabled && !isLoading ? 1.0 : 0.5,
                    child: Container(
                      height: 47,
                      width: 340,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13),
                        color: Colors.black,
                      ),
                      child: isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Row(
                              children: [
                                Icon(
                                  Icons.login,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 79),
                                Text(
                                  " Login Now",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 19,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterPage()));
                  },
                  child: const Center(
                    child: Text(
                      "Don't have an Account? Register Now.",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Future<void> signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.deepOrange.shade300,
            content: const Text(
              "Login successful",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(12),
            showCloseIcon: true,
          ),
        );

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MainPage()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.deepOrange.shade300,
            content: Text(
              e.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(12),
            showCloseIcon: true,
          ),
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}
