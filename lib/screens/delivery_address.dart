import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:store/model/product_provider_model.dart';

import '../model/user.dart';
import 'cart_check_out.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _homeAddressController = TextEditingController();
  String? _selectedState;
  String? _selectedLocation;
  bool isSelected = false;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

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
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Consumer<TopDealer>(
              builder: (context, value, child) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order Summary",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 19,
                              color: Colors.deepOrange.shade300),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Item's total (${value.cartItems.length})",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Colors.black),
                            ),
                            Text(
                              "\$${value.calculateTotalItem()}",
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Delivery fees",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Colors.black),
                            ),
                            Text(
                              "\$150.0",
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),
                            )
                          ],
                        ),
                        Divider(
                          color: Colors.grey.shade400,
                          thickness: 0.9,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Colors.black),
                            ),
                            Text(
                              "\$${value.totalItem()}",
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Add delivery address",
                          style: GoogleFonts.poppins(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrange.shade300),
                        ),
                        Text(
                          "Select a delivery method",
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade600),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                useRootNavigator: true,
                                isScrollControlled: true,
                                builder: (context) {
                                  return SafeArea(
                                    child: Scaffold(
                                      resizeToAvoidBottomInset: false,
                                      body: SingleChildScrollView(
                                        physics:
                                            const AlwaysScrollableScrollPhysics(),
                                        //
                                        child: StatefulBuilder(builder:
                                            (BuildContext context,
                                                StateSetter setState) {
                                          return SizedBox(
                                            height: 650,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context)
                                                    .viewInsets
                                                    .bottom,
                                                // this will set the bottom padding to the height of the keyboard
                                                left: 8.0,
                                                right: 8.0,
                                                top: 29.0,
                                              ),
                                              child: SingleChildScrollView(
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
                                                          "Add New address",
                                                          style:
                                                              GoogleFonts.poppins(
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(
                                                            "Close",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    fontSize: 17,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .deepOrange
                                                                        .shade300),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Address Details",
                                                          style:
                                                              GoogleFonts.poppins(
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                        Text(
                                                          "*Required fields",
                                                          style:
                                                              GoogleFonts.poppins(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade600),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 14,
                                                    ),
                                                    Form(
                                                      key: _formKey,
                                                      child:
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: SingleChildScrollView(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "First Name*",
                                                                    style: GoogleFonts.poppins(
                                                                        fontSize: 15,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .deepOrange
                                                                            .shade300),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 6,
                                                                  ),
                                                                  Container(
                                                                    height: 43,
                                                                    width: 380,
                                                                    decoration:
                                                                        const BoxDecoration(
                                                                            border:
                                                                                Border(
                                                                      bottom: BorderSide(
                                                                          color: Colors
                                                                              .black,
                                                                          width: 1.2),
                                                                    )),
                                                                    child: Text(
                                                                      "${loggedInUser.firstName}",
                                                                      style: GoogleFonts.poppins(
                                                                          fontSize:
                                                                              17,
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .bold,
                                                                          color: Colors
                                                                              .black),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Text(
                                                                    "Second Name*",
                                                                    style: GoogleFonts.poppins(
                                                                        fontSize: 15,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .deepOrange
                                                                            .shade300),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 6,
                                                                  ),
                                                                  Container(
                                                                    height: 43,
                                                                    width: 380,
                                                                    decoration:
                                                                        const BoxDecoration(
                                                                            border:
                                                                                Border(
                                                                      bottom: BorderSide(
                                                                          color: Colors
                                                                              .black,
                                                                          width: 1.2),
                                                                    )),
                                                                    child: Text(
                                                                      "${loggedInUser.secondName}",
                                                                      style: GoogleFonts.poppins(
                                                                          fontSize:
                                                                              17,
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .bold,
                                                                          color: Colors
                                                                              .black),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Text(
                                                                    "Phone Number*",
                                                                    style: GoogleFonts.poppins(
                                                                        fontSize: 15,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .deepOrange
                                                                            .shade300),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 6,
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Container(
                                                                          height: 43,
                                                                          width: 50,
                                                                          decoration:
                                                                              const BoxDecoration(
                                                                                  border:
                                                                                      Border(
                                                                            bottom: BorderSide(
                                                                                color: Colors
                                                                                    .black,
                                                                                width:
                                                                                    1.2),
                                                                          )),
                                                                          child:
                                                                              Center(
                                                                            child: Text(
                                                                                "+234",
                                                                                style: GoogleFonts.poppins(
                                                                                    fontWeight: FontWeight.bold,
                                                                                    color: Colors.black)),
                                                                          )),
                                                                      const SizedBox(
                                                                        width: 4,
                                                                      ),
                                                                      Container(
                                                                        height: 43,
                                                                        width: 320,
                                                                        decoration:
                                                                            const BoxDecoration(
                                                                                border:
                                                                                    Border(
                                                                          bottom: BorderSide(
                                                                              color: Colors
                                                                                  .black,
                                                                              width:
                                                                                  1.2),
                                                                        )),
                                                                        child:
                                                                            TextFormField(
                                                                          keyboardType:
                                                                              TextInputType
                                                                                  .phone,
                                                                          style: GoogleFonts.poppins(
                                                                              color: Colors
                                                                                  .black,
                                                                              fontWeight:
                                                                                  FontWeight
                                                                                      .bold,
                                                                              fontSize:
                                                                                  17),
                                                                          controller:
                                                                              _phoneNumberController,
                                                                          inputFormatters: [
                                                                            FilteringTextInputFormatter
                                                                                .digitsOnly,
                                                                            // Limit the input
                                                                            LengthLimitingTextInputFormatter(
                                                                                11),
                                                                          ],
                                                                          decoration: InputDecoration(
                                                                              hintText:
                                                                                  "Phone Number",
                                                                              hintStyle: GoogleFonts.poppins(
                                                                                  color: Colors
                                                                                      .grey.shade600,
                                                                                  fontWeight: FontWeight
                                                                                      .bold,
                                                                                  fontSize:
                                                                                      17),
                                                                              border: InputBorder
                                                                                  .none,
                                                                              contentPadding:
                                                                                  const EdgeInsets.all(10)),
                                                                          validator:
                                                                              (value) {
                                                                            RegExp
                                                                                regex =
                                                                                RegExp(
                                                                                    r'^.{11,}$');
                                                                            if (value!
                                                                                .isEmpty) {
                                                                              return "Your Phone Number is required";
                                                                            }
                                                                            if (!regex
                                                                                .hasMatch(
                                                                                    value)) {
                                                                              return ("Please enter a valid Phone Number(Min. 11 Characters)");
                                                                            }
                                                                            return null;
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Text(
                                                                    "Delivery Address*",
                                                                    style: GoogleFonts.poppins(
                                                                        fontSize: 15,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .deepOrange
                                                                            .shade300),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 6,
                                                                  ),
                                                                  Container(
                                                                    height: 43,
                                                                    width: 380,
                                                                    decoration:
                                                                        const BoxDecoration(
                                                                            border:
                                                                                Border(
                                                                      bottom: BorderSide(
                                                                          color: Colors
                                                                              .black,
                                                                          width: 1.2),
                                                                    )),
                                                                    child:
                                                                        TextFormField(
                                                                      style: GoogleFonts.poppins(
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .bold,
                                                                          fontSize:
                                                                              17),
                                                                      controller:
                                                                          _homeAddressController,
                                                                      decoration: InputDecoration(
                                                                          hintText:
                                                                              "Delivery Address",
                                                                          hintStyle: GoogleFonts.poppins(
                                                                              color: Colors
                                                                                  .grey
                                                                                  .shade600,
                                                                              fontWeight:
                                                                                  FontWeight
                                                                                      .bold,
                                                                              fontSize:
                                                                                  17),
                                                                          border:
                                                                              InputBorder
                                                                                  .none,
                                                                          contentPadding:
                                                                              const EdgeInsets.all(
                                                                                  10)),
                                                                      validator:
                                                                          (value) {
                                                                        if (value ==
                                                                                null ||
                                                                            value
                                                                                .isEmpty) {
                                                                          return 'Please enter your delivery address';
                                                                        }
                                                                        return null;
                                                                      },
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Text(
                                                                    "State*",
                                                                    style: GoogleFonts.poppins(
                                                                        fontSize: 15,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .deepOrange
                                                                            .shade300),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 6,
                                                                  ),
                                                                  DropdownButtonFormField<
                                                                      String>(
                                                                    value:
                                                                        _selectedState,
                                                                    items: <String>[
                                                                      'Abia',
                                                                      'Adamawa',
                                                                      'Akwa Ibom',
                                                                      'Anambra',
                                                                      'Bauchi',
                                                                      'Bayelsa',
                                                                      'Benue',
                                                                      'Borno',
                                                                      'Cross River',
                                                                      'Delta',
                                                                      'Ebonyi',
                                                                      'Edo',
                                                                      'Ekiti',
                                                                      'Enugu',
                                                                      'FCT',
                                                                      'Gombe',
                                                                      'Imo',
                                                                      'Jigawa',
                                                                      'Kaduna',
                                                                      'Kano',
                                                                      'Katsina',
                                                                      'Kebbi',
                                                                      'Kogi',
                                                                      'Kwara',
                                                                      'Lagos',
                                                                      'Nasarawa',
                                                                      'Niger',
                                                                      'Ogun',
                                                                      'Ondo',
                                                                      'Osun',
                                                                      'Oyo',
                                                                      'Plateau',
                                                                      'Rivers',
                                                                      'Sokoto',
                                                                      'Taraba',
                                                                      'Yobe',
                                                                      'Zamfara'
                                                                    ].map<
                                                                        DropdownMenuItem<
                                                                            String>>((String
                                                                        value) {
                                                                      return DropdownMenuItem<
                                                                          String>(
                                                                        value: value,
                                                                        child: Text(
                                                                            value),
                                                                      );
                                                                    }).toList(),
                                                                    onChanged:
                                                                        (newValue) {
                                                                      setState(() {
                                                                        _selectedState =
                                                                            newValue;
                                                                      });
                                                                    },
                                                                    style: GoogleFonts.poppins(
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize: 17),
                                                                    decoration:
                                                                        InputDecoration(
                                                                      labelText:
                                                                          'State',
                                                                      labelStyle: GoogleFonts.poppins(
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .bold,
                                                                          fontSize:
                                                                              17),
                                                                      hintText:
                                                                          "Select State",
                                                                      hintStyle: GoogleFonts.poppins(
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .bold,
                                                                          fontSize:
                                                                              17),
                                                                    ),
                                                                    validator:
                                                                        (value) {
                                                                      if (value ==
                                                                              null ||
                                                                          value
                                                                              .isEmpty) {
                                                                        return 'Please select your state';
                                                                      }
                                                                      return null;
                                                                    },
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                    ),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    Center(
                                                      child: GestureDetector(
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
                                                              "Add Address",
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
                                                          _submitForm();
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 6,
                              ),
                              const Icon(Icons.add_circle),
                              Text(
                                "Add New address",
                                style: GoogleFonts.poppins(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Provider.of<TopDealer>(context).buildUserInfoWidget(),
                        const SizedBox(
                          height: 8,
                        ),
                        Center(
                          child: Container(
                            width: 380,
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                                color: value.isChecking
                                    ? Colors.deepOrange.shade100
                                    : Colors.white,
                                border: Border(
                                  top: BorderSide(
                                      color: value.isChecking
                                          ? Colors.deepOrange.shade100
                                          : Colors.white,
                                      width: 0.44),
                                  left: BorderSide(
                                      color: value.isChecking
                                          ? Colors.deepOrange.shade100
                                          : Colors.white,
                                      width: 0.44),
                                  right: BorderSide(
                                      color: value.isChecking
                                          ? Colors.deepOrange.shade100
                                          : Colors.white,
                                      width: 0.44),
                                  bottom: BorderSide(
                                      color: value.isChecking
                                          ? Colors.deepOrange.shade100
                                          : Colors.white,
                                      width: 0.84),
                                )),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Pickup from a store',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.deepOrange.shade300),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            Provider.of<TopDealer>(context,
                                                    listen: false)
                                                .checkBox = !value.isChecking;
                                          });
                                        },
                                        icon: value.isChecking
                                            ? Icon(
                                                Icons.check_box,
                                                color:
                                                    Colors.deepOrange.shade300,
                                              )
                                            : const Icon(Icons
                                                .check_box_outline_blank_sharp))
                                  ],
                                ),
                                DropdownButtonFormField<String>(
                                  value: _selectedLocation,
                                  items: <String>[
                                    'Ikeja,Lagos State',
                                    'Lagos Surulere,Lagos',
                                    'Lagos Oshodi-Apapa Lagos',
                                    'Abuja Wuse II , Abuja',
                                    'Kano  Kano, Kano State',
                                    'Port Harcourt Aba , Rivers State',
                                    'Ibadan Cocoa House, Oyo State',
                                    'Benin - Ekenwan Road, Edo State',
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedLocation = newValue;
                                    });
                                  },
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13),
                                  decoration: InputDecoration(
                                    hintText: "Select pickup location",
                                    hintStyle: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please select your state';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 8,),
                                const Text(
                                  "Select a pickup location in your area from "
                                  "our locations nationwide",
                                  style: TextStyle(
                                      // fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 5,
                            ),
                            const Icon(Icons.info_rounded),
                            Text(
                              "Choose a delivery method suitable for you.",
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade700),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ));
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Add user's information to TopDealer class
      Provider.of<TopDealer>(context, listen: false).addUserInfo(
        _phoneNumberController.text,
        _homeAddressController.text,
        _selectedState!,
      );
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.deepOrange.shade300,
            content: Text("Address added successful",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
              ),),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)
            ),
            padding: const EdgeInsets.all(12),
            showCloseIcon: true,
          )
      );
    Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (context) => const CardForm()));
    }
  }
}
