import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:store/model/user.dart';

import '../model/product_provider_model.dart';
import 'cart_check_out.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  final firstNameEditingController = TextEditingController();
  final secondNameEditingController = TextEditingController();
  final emailNameEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
    super.initState();
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
        body: SafeArea(
          child: Consumer<TopDealer>(
            builder: (context, value, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "My Cart",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 34),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.deepOrange.shade300,
                          child: const Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey.shade600,
                    thickness: 0.7,
                  ),
                  if (value.cartItems.isEmpty)
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(
                            CupertinoIcons.xmark,
                            color: Colors.deepOrange.shade600,
                            size: 25,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            "No Item in cart",
                            style: GoogleFonts.poppins(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ))
                  else
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Text(
                            "Your Cart",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 18),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Container(
                            height: 27,
                            width: 80,
                            color: Colors.deepOrange.shade300,
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "${value.cartItems.length}",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  "items",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  Divider(
                    color: Colors.grey.shade600,
                    thickness: 0.1,
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: value.cartItems.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8)),
                                child: ListTile(
                                  leading: Container(
                                    height: 130,
                                    width: 90,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Image.asset(
                                      value.cartItems[index][1],
                                      height: 36,
                                    ),
                                  ),
                                  title: Text(
                                    value.cartItems[index][0],
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  subtitle: Text(
                                    "\$${value.cartItems[index][2]}",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  trailing: IconButton(
                                      onPressed: () {
                                        Provider.of<TopDealer>(context,
                                                listen: false)
                                            .removeItemFromCart(index);
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      )),
                                ),
                              ),
                            );
                          })),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${value.cartItems.length} items added",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 19),
                                ),
                                Text(
                                  "\$${value.calculateTotalItem()}",
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 21),
                                )
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const CardForm();
                                }));
                              },
                              child: Container(
                                height: 50,
                                width: 180,
                                decoration: BoxDecoration(
                                    color: Colors.deepOrange.shade300,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Center(
                                  child: Text(
                                    "Check Out",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 19,
                                        color: Colors.black),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ));
  }
}
