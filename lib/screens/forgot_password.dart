import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:store/screens/get_started_page.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool isLoading = true;
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordEditingController =
      TextEditingController();
  bool isHovers = false;
  bool isSelectedOn = false;
  bool isSelectedOn1 = false;

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
                  height: 100,
                ),
                const Row(
                  children: [
                    SizedBox(
                      width: 25,
                    ),
                    Text(
                      "Forgot Password?",
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
                    Text(
                      "Input your email to get a reset link sent to your email",
                      style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  height: 237,
                  width: 370,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    color: isHovers ? Colors.white : Colors.deepOrange.shade50,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Form(
                          key: _formKey,
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
                                    textInputAction: TextInputAction.done,
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
                            ],
                          )),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    resetPassword(emailController.text);
                  },
                  child: Container(
                    height: 47,
                    width: 340,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      color: Colors.black,
                    ),
                    child: const Center(
                      child: Text(
                        "Get reset password Link",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 19),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Future<void> resetPassword(String email) async {
    try {
      // Send a password reset email to the user
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      // Show a success message or navigate to a success screen
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.deepOrange.shade300,
        content: Text(
          "A reset link has been sent to your email",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.all(12),
        showCloseIcon: true,
      ));
    } catch (e) {
      // Handle any errors that occur during the process
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.deepOrange.shade300,
        content: Text(
          "reset failed: $e",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.all(12),
        showCloseIcon: true,
      ));
      // Display an error message to the user or handle the error accordingly
    }
  }
}
