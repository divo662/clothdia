import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:store/screens/login_page.dart';
import 'package:store/screens/get_started_page.dart';

import '../model/user.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _auth = FirebaseAuth.instance;
  bool _obscureText = true;
  bool obscureText = true;
  bool isLoading = false;
  bool isButtonEnabled = false;
  final _formKey = GlobalKey<FormState>();
  final firstNameEditingController = TextEditingController();
  final secondNameEditingController = TextEditingController();
  final emailNameEditingController = TextEditingController();
  final passwordNameEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange[50],
      appBar: AppBar(
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
                      "Register with us now.",
                      textStyle: TextStyle(
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.bold,
                          fontSize: 34),
                    ),
                    TyperAnimatedText(
                      "Register with us now.",
                      textStyle: TextStyle(
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.bold,
                          fontSize: 34),
                    ),
                    TyperAnimatedText(
                      "Register with us now.",
                      textStyle: TextStyle(
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.bold,
                          fontSize: 34),
                    ),
                  ])
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: () {
                    setState(() {
                      isButtonEnabled = _formKey.currentState!.validate();
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
                                      color: Colors.black, width: 1.5))),
                          child: TextFormField(
                            style: const TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            autofocus: true,
                            controller: firstNameEditingController,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "First name is required!";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              firstNameEditingController.text = value!;
                            },
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.person),
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 15, 20, 15),
                                hintText: "First Name",
                                hintStyle: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                border: InputBorder.none),
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
                                      color: Colors.black, width: 1.5))),
                          child: TextFormField(
                            style: const TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            autofocus: true,
                            controller: secondNameEditingController,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Second name is required!";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              secondNameEditingController.text = value!;
                            },
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.person),
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 15, 20, 15),
                                hintText: "Second Name",
                                hintStyle: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                border: InputBorder.none),
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
                                      color: Colors.black, width: 1.5))),
                          child: TextFormField(
                            style: const TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            autofocus: true,
                            controller: emailNameEditingController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please Enter Your Email";
                              }
                              if (!RegExp(
                                      "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                  .hasMatch(value)) {
                                return "Please enter a valid email";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              emailNameEditingController.text = value!;
                            },
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.email),
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 15, 20, 15),
                                hintText: "Email",
                                hintStyle: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                border: InputBorder.none),
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
                                      color: Colors.black, width: 1.5))),
                          child: TextFormField(
                            style: const TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            autofocus: true,
                            obscureText: _obscureText,
                            controller: passwordNameEditingController,
                            validator: (value) {
                              RegExp regex = RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$');

                              if (value!.isEmpty) {
                                return 'Password is required';
                              }

                              if (!regex.hasMatch(value)) {
                                return 'Please enter a valid password'
                                    ' (Min. 6 characters, with at least one'
                                    ' uppercase letter, one lowercase letter,'
                                    ' and one digit)';
                              }

                              return null;
                            },
                            onSaved: (value) {
                              passwordNameEditingController.text = value!;
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  child: Icon(_obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                ),
                                prefixIcon: const Icon(Icons.vpn_key),
                                contentPadding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 15),
                                hintText: "Password",
                                hintStyle: const TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                border: InputBorder.none),
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
                                      color: Colors.black, width: 1.5))),
                          child: TextFormField(
                            style: const TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            autofocus: true,
                            obscureText: obscureText,
                            controller: confirmPasswordEditingController,
                            validator: (value) {
                              if (confirmPasswordEditingController.text !=
                                  passwordNameEditingController.text) {
                                return "Password doesn't match";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              confirmPasswordEditingController.text = value!;
                            },
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      obscureText = !obscureText;
                                    });
                                  },
                                  child: Icon(obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                ),
                                prefixIcon: const Icon(Icons.vpn_key),
                                contentPadding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 15),
                                hintText: "Confirm Password",
                                hintStyle: const TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                border: InputBorder.none),
                          )),
                    ],
                  )),
              const SizedBox(
                height: 30,
              ),
              // Add this boolean variable to track the loading state
              GestureDetector(
                onTap: isButtonEnabled && !isLoading
                    ? () {
                  signUp(
                    emailNameEditingController.text,
                    passwordNameEditingController.text,
                  );
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
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                        )
                        : const Row(
                      children: [
                        Icon(
                          Icons.how_to_reg_sharp,
                          color: Colors.white,
                        ),
                        SizedBox(width: 79),
                        Text(
                          " Register Now",
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
                          builder: (context) => const LoginPage()));
                },
                child: const Center(
                  child: Text(
                    "Have an Account? Login Now.",
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
      ),
    );
  }

  // Registering a new User into the app................................
   signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true; // Set isLoading to true to show the circular progress indicator
      });

      try {
        await _auth.createUserWithEmailAndPassword(email: email, password: password);
        await postDetailsToFirestore();

        setState(() {
          isLoading = false; // Set isLoading to false to hide the circular progress indicator
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.deepOrange.shade300,
            content: Text(
              "Registration successful",
              style: GoogleFonts.poppins(
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

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
              (route) => false,
        );
      } catch (e) {
        setState(() {
          isLoading = false; // Set isLoading to false to hide the circular progress indicator
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.deepOrange.shade300,
            content: Text(
              "$e",
              style: GoogleFonts.poppins(
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
      }
    }
  }

  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();

    // Writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = firstNameEditingController.text;
    userModel.secondName = secondNameEditingController.text;

    await firebaseFirestore.collection("users").doc(user.uid).set(userModel.toMap());
  }

}
