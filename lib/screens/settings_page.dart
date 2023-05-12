// ignore_for_file: use_build_context_synchronously
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:provider/provider.dart';

import '../model/product_provider_model.dart';
import '../model/user.dart';
import 'login_page.dart';

class PersonPage extends StatefulWidget {
  const PersonPage({Key? key}) : super(key: key);

  @override
  State<PersonPage> createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  bool valued = false;
  final _auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController helpController = TextEditingController();
  bool _obscureText = true;
  bool _isLoading = false;
  bool obscureText = true;
  final _formKey = GlobalKey<FormState>();
  final firstNameEditingController = TextEditingController();
  final secondNameEditingController = TextEditingController();
  final emailNameEditingController = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final passwordNameEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();
  bool isSelected = false;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  void deleteData(String email, String password) async {
    User? user = _auth.currentUser;

    AuthCredential credential =
        EmailAuthProvider.credential(email: email, password: password);

    await user!.reauthenticateWithCredential(credential).then((value) {
      value.user?.delete().then((res) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.deepOrange.shade300,
          content: Text(
            "Account deleted successfully",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
            ),
          ),
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.all(12),
          showCloseIcon: true,
        ));
      }).catchError((e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.deepOrange.shade300,
          content: Text(
            "e!.message",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
            ),
          ),
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.all(12),
          showCloseIcon: true,
        ));
      });
    });
  }

  @override
  void initState() {
    super.initState();

    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<TopDealer>(
        builder: (context, value, child) {
          return Center(
              child: Column(
            children: [
              Container(
                height: 290,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Colors.deepOrange.shade300),
                child: SafeArea(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Clothdia",
                              style: GoogleFonts.poppins(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              "Profile",
                              style: GoogleFonts.poppins(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  CupertinoIcons.cart,
                                  size: 24,
                                  color: Colors.white,
                                ))
                          ],
                        ),
                      ),
                      Center(
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.grey.shade200,
                          child: Icon(
                            CupertinoIcons.person,
                            size: 70,
                            color: Colors.deepOrange.shade300,
                          ),
                        ),
                      ),
                      Text(
                        "Welcome, ${loggedInUser.firstName}",
                        style: GoogleFonts.poppins(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        " ${loggedInUser.email}",
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(
                      CupertinoIcons.money_dollar_circle_fill,
                      color: Colors.blue.shade700,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Total Balance:",
                      style: GoogleFonts.poppins(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade700),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "\$0.00",
                      style: GoogleFonts.poppins(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade700),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Colors.black,
                thickness: 0.96,
                height: 10,
              ),
              Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      onTap: () {
                        showBottomSheet(
                          context: context,
                          backgroundColor: Colors.white,
                          builder: (context) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Consumer<TopDealer>(
                                  builder: (context, value, child) {
                                    return StatefulBuilder(
                                      builder: (BuildContext context,
                                          StateSetter setState) {
                                        return SizedBox(
                                          // Wrap Column with Container
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.6,
                                          // Set a specific height constraint
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "My Orders",
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text(
                                                        "Close",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors
                                                              .deepOrange
                                                              .shade300,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                value.transactions.isEmpty
                                                    ? Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          const Icon(
                                                            CupertinoIcons
                                                                .xmark,
                                                            size: 130,
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            "No transaction history",
                                                            style: GoogleFonts
                                                                .poppins(
                                                              fontSize: 19,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .deepOrange
                                                                  .shade300,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Center(
                                                            child: Text(
                                                              "You have not made any purchase recently.",
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                fontSize: 19,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    : Expanded(
                                                        // Wrap ListView.builder with Expanded
                                                        child: ListView.builder(
                                                          itemCount: value
                                                              .transactions
                                                              .length,
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int index) {
                                                            MyTransaction
                                                                transaction =
                                                                value.transactions[
                                                                    index];

                                                            return ListTile(
                                                              title: Text(
                                                                'Reference Number: ${transaction.refNumber}',
                                                                style: GoogleFonts.poppins(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                              subtitle: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    'Amount Spent: \$${transaction.amountSpent}',
                                                                    style: GoogleFonts.poppins(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .grey
                                                                            .shade600),
                                                                  ),
                                                                  Text(
                                                                    'Number of Items: ${transaction.numberOfItems}',
                                                                    style: GoogleFonts.poppins(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .grey
                                                                            .shade600),
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                        'Date: ${DateFormat('yyyy-MM-dd').format(transaction.dateTime)}',
                                                                        style: GoogleFonts.poppins(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Colors.grey.shade600),
                                                                      ),
                                                                      const SizedBox(
                                                                          width:
                                                                              10),
                                                                      Text(
                                                                        'Time: ${DateFormat('HH:mm').format(transaction.dateTime)}',
                                                                        style: GoogleFonts.poppins(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Colors.grey.shade600),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: transaction
                                                                        .nameItem
                                                                        .map((name) =>
                                                                            Text(
                                                                              name,
                                                                              style: GoogleFonts.poppins(
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.black,
                                                                              ),
                                                                            ))
                                                                        .toList(),
                                                                  ),
                                                                  Divider(
                                                                    thickness:
                                                                        0.7,
                                                                    color: Colors
                                                                        .grey
                                                                        .shade600,
                                                                  )
                                                                ],
                                                              ),
                                                              trailing: transaction
                                                                      .isSuccessful
                                                                  ? const Icon(
                                                                      Icons
                                                                          .check_circle,
                                                                      color: Colors
                                                                          .green)
                                                                  : const Icon(
                                                                      Icons
                                                                          .error,
                                                                      color: Colors
                                                                          .red),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            );
                          },
                        );
                      },
                      title: Text(
                        "My Orders",
                        style: GoogleFonts.poppins(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      leading: const Icon(
                        Icons.shopping_cart_checkout_sharp,
                        color: Colors.black,
                      ),
                      trailing: const Icon(
                        CupertinoIcons.arrow_right,
                        color: Colors.black,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        showBottomSheet(
                            context: context,
                            builder: (context) {
                              return StatefulBuilder(builder:
                                  (BuildContext context, StateSetter setState) {
                                return SingleChildScrollView(
                                    child: SizedBox(
                                  height: 500,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Profile",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  "Close",
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors
                                                          .deepOrange.shade300),
                                                ),
                                              )
                                            ],
                                          ),
                                          Center(
                                            child: Text(
                                              "Edit Profile",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Form(
                                              key: _formKey,
                                              child: Column(
                                                children: [
                                                  Center(
                                                    child: Container(
                                                        height: 47,
                                                        width: 340,
                                                        decoration: const BoxDecoration(
                                                            color: Colors.white,
                                                            border: Border(
                                                                top: BorderSide
                                                                    .none,
                                                                left: BorderSide
                                                                    .none,
                                                                right:
                                                                    BorderSide
                                                                        .none,
                                                                bottom: BorderSide(
                                                                    color: Colors
                                                                        .black,
                                                                    width:
                                                                        1.5))),
                                                        child: TextFormField(
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 19,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black),
                                                          autofocus: true,
                                                          controller:
                                                              firstNameEditingController,
                                                          keyboardType:
                                                              TextInputType
                                                                  .name,
                                                          validator: (value) {
                                                            if (value!
                                                                .isEmpty) {
                                                              return "First name is required!";
                                                            }
                                                            return null;
                                                          },
                                                          onSaved: (value) {
                                                            firstNameEditingController
                                                                .text = value!;
                                                          },
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          decoration: InputDecoration(
                                                              prefixIcon:
                                                                  const Icon(Icons
                                                                      .person),
                                                              contentPadding:
                                                                  const EdgeInsets
                                                                          .fromLTRB(20,
                                                                      15, 20, 15),
                                                              hintText:
                                                                  "${loggedInUser.firstName}",
                                                              hintStyle: TextStyle(
                                                                  fontSize: 19,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade600),
                                                              border:
                                                                  InputBorder
                                                                      .none),
                                                        )),
                                                  ),
                                                  const SizedBox(
                                                    height: 40,
                                                  ),
                                                  Center(
                                                    child: Container(
                                                        height: 47,
                                                        width: 340,
                                                        decoration: const BoxDecoration(
                                                            color: Colors.white,
                                                            border: Border(
                                                                top: BorderSide
                                                                    .none,
                                                                left: BorderSide
                                                                    .none,
                                                                right:
                                                                    BorderSide
                                                                        .none,
                                                                bottom: BorderSide(
                                                                    color: Colors
                                                                        .black,
                                                                    width:
                                                                        1.5))),
                                                        child: TextFormField(
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 19,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black),
                                                          autofocus: true,
                                                          controller:
                                                              secondNameEditingController,
                                                          keyboardType:
                                                              TextInputType
                                                                  .name,
                                                          validator: (value) {
                                                            if (value!
                                                                .isEmpty) {
                                                              return "Second name is required!";
                                                            }
                                                            return null;
                                                          },
                                                          onSaved: (value) {
                                                            secondNameEditingController
                                                                .text = value!;
                                                          },
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          decoration: InputDecoration(
                                                              prefixIcon:
                                                                  const Icon(Icons
                                                                      .person),
                                                              contentPadding:
                                                                  const EdgeInsets
                                                                          .fromLTRB(20,
                                                                      15, 20, 15),
                                                              hintText:
                                                                  "${loggedInUser.secondName}",
                                                              hintStyle: TextStyle(
                                                                  fontSize: 19,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade600),
                                                              border:
                                                                  InputBorder
                                                                      .none),
                                                        )),
                                                  ),
                                                ],
                                              )),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Center(
                                            child: GestureDetector(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors
                                                        .deepOrange.shade300,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                height: 50,
                                                width: 250,
                                                child: Center(
                                                  child: Text(
                                                    "Submit",
                                                    style: GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ),
                                              onTap: () async {
                                                FirebaseFirestore.instance
                                                    .collection("users")
                                                    .doc(user!.uid)
                                                    .update({
                                                  "firstName":
                                                      firstNameEditingController
                                                          .text
                                                          .trim(),
                                                  "secondName":
                                                      secondNameEditingController
                                                          .text
                                                          .trim(),
                                                }).then((value) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    backgroundColor: Colors
                                                        .deepOrange.shade300,
                                                    content: Text(
                                                      "Updated successfully",
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12)),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12),
                                                    showCloseIcon: true,
                                                  ));
                                                  Navigator.pop(context);
                                                });
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ));
                              });
                            });
                      },
                      title: Text(
                        "Account Management",
                        style: GoogleFonts.poppins(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      leading: const Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                      trailing: const Icon(
                        CupertinoIcons.arrow_right,
                        color: Colors.black,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Scaffold(
                                body: StatefulBuilder(builder:
                                    (BuildContext context,
                                        StateSetter setState) {
                                  return SingleChildScrollView(
                                    child: SizedBox(
                                      height: 700,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Contact Us",
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    "Close",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.deepOrange
                                                            .shade300),
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              "Email Address",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            Center(
                                              child: Container(
                                                height: 50,
                                                width: 350,
                                                padding:
                                                    const EdgeInsets.all(12),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.black,
                                                        width: 1.5)),
                                                child: Text(
                                                  "${loggedInUser.email}",
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          Colors.grey.shade600),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              "How can we help you?",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            Center(
                                              child: Container(
                                                  height: 50,
                                                  width: 350,
                                                  padding:
                                                      const EdgeInsets.all(12),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.black,
                                                          width: 1.5)),
                                                  child: TextField(
                                                    controller: helpController,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                    decoration:
                                                        const InputDecoration(
                                                      border: InputBorder.none,
                                                    ),
                                                  )),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              "Message",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            Center(
                                              child: Container(
                                                  height: 90,
                                                  width: 350,
                                                  padding:
                                                      const EdgeInsets.all(12),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.black,
                                                          width: 1.5)),
                                                  child: TextField(
                                                    controller: emailController,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                    decoration:
                                                        const InputDecoration(
                                                      border: InputBorder.none,
                                                    ),
                                                  )),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Center(
                                              child: GestureDetector(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors
                                                          .deepOrange.shade300,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)),
                                                  height: 50,
                                                  width: 250,
                                                  child: Center(
                                                    child: _isLoading
                                                        ? const CircularProgressIndicator()
                                                        : Text(
                                                            "Submit",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black),
                                                          ),
                                                  ),
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    _isLoading = true;
                                                  });
                                                  sendEmail().then((_) {
                                                    setState(() {
                                                      _isLoading = false;
                                                    });
                                                  });
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              );
                            });
                      },
                      title: Text(
                        "Contact Us",
                        style: GoogleFonts.poppins(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      leading: const Icon(
                        Icons.phone,
                        color: Colors.black,
                      ),
                      trailing: const Icon(
                        CupertinoIcons.arrow_right,
                        color: Colors.black,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return StatefulBuilder(
                                builder: (BuildContext context,
                                    StateSetter setState) {
                                  return Container(
                                    height: 500,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Delete Account",
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 19,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    "Close",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.deepOrange
                                                            .shade300),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Text(
                                            "Please Read Carefully",
                                            style: GoogleFonts.poppins(
                                                fontSize: 19,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "You are about to request that we permanently delete "
                                              "your data and close your Clothdia account. All goods and "
                                              "services that you have access to through this account will be offered"
                                              " as soon as it is deleted.",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey.shade600),
                                            ),
                                          ),
                                          Form(
                                              key: _formKey,
                                              child: Column(
                                                children: [
                                                  Center(
                                                    child: Container(
                                                        height: 47,
                                                        width: 340,
                                                        decoration: const BoxDecoration(
                                                            color: Colors
                                                                .transparent,
                                                            border: Border(
                                                                top: BorderSide
                                                                    .none,
                                                                left: BorderSide
                                                                    .none,
                                                                right:
                                                                    BorderSide
                                                                        .none,
                                                                bottom: BorderSide(
                                                                    color: Colors
                                                                        .black,
                                                                    width:
                                                                        1.5))),
                                                        child: TextFormField(
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 19,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black),
                                                          autofocus: true,
                                                          controller: email,
                                                          keyboardType:
                                                              TextInputType
                                                                  .emailAddress,
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          decoration: InputDecoration(
                                                              prefixIcon: const Icon(
                                                                  Icons.email),
                                                              contentPadding:
                                                                  const EdgeInsets
                                                                          .fromLTRB(
                                                                      20,
                                                                      15,
                                                                      20,
                                                                      15),
                                                              hintText: "Email",
                                                              hintStyle: TextStyle(
                                                                  fontSize: 19,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade600),
                                                              border:
                                                                  InputBorder
                                                                      .none),
                                                        )),
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  Center(
                                                    child: Container(
                                                        height: 47,
                                                        width: 340,
                                                        decoration: const BoxDecoration(
                                                            color: Colors
                                                                .transparent,
                                                            border: Border(
                                                                top: BorderSide
                                                                    .none,
                                                                left: BorderSide
                                                                    .none,
                                                                right:
                                                                    BorderSide
                                                                        .none,
                                                                bottom: BorderSide(
                                                                    color: Colors
                                                                        .black,
                                                                    width:
                                                                        1.5))),
                                                        child: TextFormField(
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 19,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black),
                                                          autofocus: true,
                                                          obscureText:
                                                              _obscureText,
                                                          controller: password,
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          decoration:
                                                              InputDecoration(
                                                                  suffixIcon:
                                                                      GestureDetector(
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        _obscureText =
                                                                            !_obscureText;
                                                                      });
                                                                    },
                                                                    child: Icon(_obscureText
                                                                        ? Icons
                                                                            .visibility
                                                                        : Icons
                                                                            .visibility_off),
                                                                  ),
                                                                  prefixIcon:
                                                                      const Icon(
                                                                          Icons
                                                                              .vpn_key),
                                                                  contentPadding:
                                                                      const EdgeInsets
                                                                              .fromLTRB(
                                                                          20,
                                                                          15,
                                                                          20,
                                                                          15),
                                                                  hintText:
                                                                      "Password",
                                                                  hintStyle: TextStyle(
                                                                      fontSize:
                                                                          19,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .grey
                                                                          .shade600),
                                                                  border:
                                                                      InputBorder
                                                                          .none),
                                                        )),
                                                  ),
                                                ],
                                              )),
                                          Row(
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      valued = !valued;
                                                    });
                                                  },
                                                  icon: valued
                                                      ? Icon(
                                                          Icons.check_box,
                                                          color: Colors
                                                              .deepOrange
                                                              .shade300,
                                                        )
                                                      : const Icon(Icons
                                                          .check_box_outline_blank_sharp)),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  "Yes, please erase my Clothdia account and "
                                                  "of my personal data permanently",
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          Colors.grey.shade600),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Center(
                                              child: valued
                                                  ? GestureDetector(
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .deepOrange
                                                                .shade300,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12)),
                                                        height: 50,
                                                        width: 250,
                                                        child: Center(
                                                          child: Text(
                                                            "Delete Account",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black),
                                                          ),
                                                        ),
                                                      ),
                                                      onTap: () {
                                                        deleteData(email.text,
                                                            password.text);
                                                      },
                                                    )
                                                  : GestureDetector(
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            color: Colors.grey,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12)),
                                                        height: 50,
                                                        width: 250,
                                                        child: Center(
                                                          child: Text(
                                                            "Delete Account",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black),
                                                          ),
                                                        ),
                                                      ),
                                                      onTap: () {},
                                                    ))
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            });
                      },
                      title: Text(
                        "Delete Account",
                        style: GoogleFonts.poppins(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      leading: const Icon(
                        Icons.delete,
                        color: Colors.black,
                      ),
                      trailing: const Icon(
                        CupertinoIcons.arrow_right,
                        color: Colors.black,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  "Log Out",
                                  style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepOrange.shade300),
                                ),
                                content: Text(
                                  "You are about to Log out,"
                                  "are you sure you want to Log out?",
                                  style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "Cancel",
                                      style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginPage()));
                                    },
                                    child: Text(
                                      "Log Out",
                                      style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.deepOrange.shade300),
                                    ),
                                  )
                                ],
                              );
                            });
                      },
                      title: Text(
                        "Log Out",
                        style: GoogleFonts.poppins(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      leading: const Icon(
                        Icons.logout,
                        color: Colors.black,
                      ),
                      trailing: const Icon(
                        CupertinoIcons.arrow_right,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ));
        },
      ),
    );
  }

  // Function to send an email
  sendEmail() async {
    String username = "nzehdaniel541@gmail.com";
    String password = "nmao pnnt xzuf iclj";

    final smtpServer =
        gmail(username, password); // Use the SMTP server for Gmail

    final message = Message()
      ..from = Address(loggedInUser.email.toString(),
          loggedInUser.firstName) // Sender's name and email
      ..recipients.add('nzehdaniel541@gmail.com') // Recipient's email
      ..subject = helpController.text // Email subject
      ..text = emailController.text; // Email body

    try {
      final sendReport = await send(message, smtpServer);
      if (null != sendReport) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Email Sent',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange.shade300,
              ),
            ),
            content: const Text(
              'Email sent successfully!',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'OK',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange.shade300,
                  ),
                ),
              ),
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Email Error',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange.shade300,
              ),
            ),
            content: const Text(
              'Email failed to send',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'OK',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange.shade300,
                  ),
                ),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Email Error',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.deepOrange.shade300,
            ),
          ),
          content: Text(
            'Error occurred while sending email $e',
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'OK',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange.shade300,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
