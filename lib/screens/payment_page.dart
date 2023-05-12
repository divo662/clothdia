
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:store/model/product_provider_model.dart';

enum CardType {
  master,
  Visa,
  Verve,
  Discover,
  AmericanExpress,
  DinersClub,
  Jcb,
  Others,
  Invalid
}

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String? _selectedBank;
  final _formKey = GlobalKey<FormState>();
  bool isInputValid = false;
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  CardType cardType = CardType.Invalid;
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
 bool  _isLoading = false;

  @override
  void initState() {
    cardNumberController.addListener(
      () {
        getCardTypeFrmNumber();
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    cardNumberController.dispose();
    super.dispose();
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
                      "Payment Method",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                          color: Colors.deepOrange.shade300),
                    ),
                    Text(
                      "Select a payment method",
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade600),
                    ),
                    const SizedBox(
                      height: 17,
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            useRootNavigator: true,
                            isScrollControlled: true,
                            builder: (context) => Scaffold(
                                  resizeToAvoidBottomInset: false,
                                  body: SingleChildScrollView(
                                    child: Consumer<TopDealer>(
                                      builder: (context, value, child){
                                        return  StatefulBuilder(
                                          builder: (BuildContext context,
                                              StateSetter setState) {
                                            return SizedBox(
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
                                                          "Enter Card Details",
                                                          style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 17,
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold,
                                                              color:
                                                              Colors.black),
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
                                                                FontWeight
                                                                    .bold,
                                                                color: Colors
                                                                    .deepOrange
                                                                    .shade300),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 35,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Fee to be paid:",
                                                          style:
                                                          GoogleFonts.poppins(
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold,
                                                              fontSize: 17,
                                                              color:
                                                              Colors.black),
                                                        ),
                                                        Text(
                                                          "\$${value.totalItem()}",
                                                          style:
                                                          GoogleFonts.poppins(
                                                              color:
                                                              Colors.black,
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold,
                                                              fontSize: 17),
                                                        )
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Form(
                                                      key: formKey,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Text(
                                                            "Credit Card Number",
                                                            style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          TextFormField(
                                                            style: const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.black,
                                                            ),
                                                            controller: cardNumberController,
                                                            keyboardType: TextInputType.number,
                                                            textInputAction: TextInputAction.next,
                                                            validator: (value) {
                                                              if (value == null || value.isEmpty) {
                                                                return 'Please enter a card number';
                                                              }

                                                              // Remove any whitespace from the card number
                                                              value = value.replaceAll(RegExp(r'\s+\b|\b\s'), '');

                                                              // Check if the card number has a minimum length
                                                              if (value.length < 16) {
                                                                return 'Invalid card number';
                                                              }

                                                              return null; // Return null for valid input
                                                            },
                                                            inputFormatters: [
                                                              FilteringTextInputFormatter.digitsOnly,
                                                              LengthLimitingTextInputFormatter(16),
                                                              CardNumberInputFormatter(),
                                                            ],
                                                            decoration: InputDecoration(
                                                              hintText: "Card number",
                                                              hintStyle: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.bold,
                                                                color: Colors.grey.shade600,
                                                              ),
                                                              suffix: CardUtils.getCardIcon(cardType),

                                                            ),
                                                          ),

                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            "Full Name",
                                                            style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),

                                                          TextFormField(
                                                            style: GoogleFonts.poppins(
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.black,
                                                            ),
                                                            textInputAction: TextInputAction.next,
                                                            validator: (value) {
                                                              if (value == null || value.isEmpty) {
                                                                return 'Please enter your full name';
                                                              }
                                                              return null; // Return null for valid input
                                                            },
                                                            decoration: InputDecoration(
                                                              hintText: "Full name",
                                                              hintStyle: GoogleFonts.poppins(
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.bold,
                                                                color: Colors.grey.shade600,
                                                              ),
                                                            ),
                                                          ),

                                                          const SizedBox(
                                                              height: 19),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "CVV",
                                                                style: GoogleFonts
                                                                    .poppins(
                                                                    fontSize:
                                                                    18,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                              const SizedBox(
                                                                  width: 162),
                                                              Text(
                                                                "Expiry Date",
                                                                style: GoogleFonts
                                                                    .poppins(
                                                                    fontSize:
                                                                    18,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child:
                                                                TextFormField(
                                                                  style: GoogleFonts.poppins(
                                                                      fontSize: 16,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                      color: Colors
                                                                          .black),
                                                                  textInputAction: TextInputAction.next,
                                                                  keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                                  validator: (value) {
                                                                    if (value == null || value.isEmpty) {
                                                                      return 'Please enter CVV';
                                                                    }
                                                                    if (value.length != 3) {
                                                                      return 'CVV must be 3 digits';
                                                                    }
                                                                    return null; // Return null for valid input
                                                                  },

                                                                  inputFormatters: [
                                                                    FilteringTextInputFormatter
                                                                        .digitsOnly,
                                                                    // Limit the input
                                                                    LengthLimitingTextInputFormatter(
                                                                        3),
                                                                  ],
                                                                  decoration:
                                                                  InputDecoration(
                                                                    hintText: "CVV",
                                                                    hintStyle: GoogleFonts.poppins(
                                                                        fontSize:
                                                                        16,
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                        color: Colors
                                                                            .grey
                                                                            .shade600),
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  width: 16),
                                                              Expanded(
                                                                child:
                                                                TextFormField(
                                                                  style: GoogleFonts.poppins(
                                                                      fontSize: 16,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                      color: Colors
                                                                          .black),
                                                                  textInputAction: TextInputAction.next,
                                                                  keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                                  validator: (value) {
                                                                    // Expiry date validation
                                                                    if (value == null || value.isEmpty) {
                                                                      setState(() {
                                                                        isInputValid = false;
                                                                      });
                                                                      return 'Please enter expiry date';
                                                                    }

                                                                    // Validate the format of the date (MM/YY)
                                                                    final RegExp regex = RegExp(r'^\d{2}/\d{2}$');
                                                                    if (!regex.hasMatch(value)) {
                                                                      setState(() {
                                                                        isInputValid = false;
                                                                      });
                                                                      return 'Invalid date format';
                                                                    }

                                                                    // Split the date into month and year
                                                                    final dateParts = value.split('/');
                                                                    final month = int.tryParse(dateParts[0]);
                                                                    final year = int.tryParse(dateParts[1]);

                                                                    // Perform additional validation if needed (e.g., check if it is a future date)

                                                                    // Check if the month and year are valid
                                                                    if (month == null || month < 1 || month > 12 || year == null || year < 0) {
                                                                      setState(() {
                                                                        isInputValid = false;
                                                                      });
                                                                      return 'Invalid expiry date';
                                                                    }

                                                                    setState(() {
                                                                      isInputValid = true;
                                                                    });
                                                                    return null; // Return null for valid input
                                                                  },

                                                                  inputFormatters: [
                                                                    FilteringTextInputFormatter
                                                                        .digitsOnly,
                                                                    LengthLimitingTextInputFormatter(
                                                                        4),
                                                                    CardMonthInputFormatter(),
                                                                  ],
                                                                  decoration:
                                                                  InputDecoration(
                                                                    hintText:
                                                                    "MM/YY",
                                                                    hintStyle: GoogleFonts.poppins(
                                                                        fontSize:
                                                                        16,
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                        color: Colors
                                                                            .grey
                                                                            .shade600),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(height: 46),
                                                    Center(
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          if(formKey.currentState!.validate()){
                                                            setState(() {
                                                              _isLoading = true; // Show circular progress indicator
                                                            });
                                                            Future.delayed(const Duration(seconds: 5), () {
                                                              // Simulating payment processing delay
                                                              setState(() {
                                                                _isLoading = false; // Hide circular progress indicator
                                                              });
                                                              String refNumber = value.generateRefNumber();

                                                              MyTransaction transaction = MyTransaction(
                                                                refNumber: refNumber,
                                                                nameItem: value.cartItems.map((item) => item[0].toString()).toList().cast<String>(),
                                                                amountSpent: value.totalItem(),
                                                                numberOfItems: value.cartItems.length,
                                                                isSuccessful: true,
                                                                dateTime: DateTime.now(),
                                                              );

                                                              TopDealer provider = Provider.of<TopDealer>(context, listen: false);
                                                              provider.addTransaction(transaction);
                                                              showDialog(
                                                                context: context,
                                                                builder: (BuildContext context) {
                                                                  return AlertDialog(
                                                                    title: Text(
                                                                      "Transaction Complete",
                                                                      style: GoogleFonts.poppins(
                                                                        fontSize: 19,
                                                                        fontWeight: FontWeight.bold,
                                                                        color: Colors.deepOrange.shade300,
                                                                      ),
                                                                    ),
                                                                    content: Container(
                                                                      height: 150, // Adjust the height as needed
                                                                      padding: EdgeInsets.symmetric(horizontal: 16),
                                                                      child: Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                        children: [
                                                                          Text(
                                                                            "Ref Number: ${value.generateRefNumber()}",
                                                                            style: GoogleFonts.poppins(
                                                                              fontSize: 16,
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Colors.black,
                                                                            ),
                                                                          ),
                                                                          Center(
                                                                            child: Icon(
                                                                              Icons.gpp_good,
                                                                              size: 45,
                                                                              color: Colors.deepOrange.shade300,
                                                                            ),
                                                                          ),
                                                                          Center(
                                                                            child: Text(
                                                                              "Check your orders to keep progress of your delivery.",
                                                                              style: GoogleFonts.poppins(
                                                                                fontSize: 16,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.black,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    actions: [
                                                                      TextButton(
                                                                        onPressed: () {
                                                                          Navigator.pop(context);
                                                                        },
                                                                        child: Text(
                                                                          "OK",
                                                                          style: GoogleFonts.poppins(
                                                                            fontSize: 15,
                                                                            fontWeight: FontWeight.bold,
                                                                            color: Colors.black,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              );

                                                            });
                                                          }
                                                        },
                                                        child: Container(
                                                          height: 53,
                                                          width: 230,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(10),
                                                            color: Colors.deepOrange.shade300,
                                                          ),
                                                          child: Center(
                                                            child: _isLoading
                                                                ? const CircularProgressIndicator() // Show circular progress indicator
                                                                : Text(
                                                              "Pay Now",
                                                              style: GoogleFonts.poppins(
                                                                fontWeight: FontWeight.bold,
                                                                color: Colors.white,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ));
                      },
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 6,
                          ),
                          const Icon(Icons.add_circle),
                          Text(
                            "Add New Credit Card",
                            style: GoogleFonts.poppins(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.grey.shade600,
                      thickness: 0.7,
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            useRootNavigator: true,
                            isScrollControlled: true,
                            backgroundColor: Colors.white,
                            builder: (context) {
                              return SingleChildScrollView(
                                child: StatefulBuilder(builder:
                                    (BuildContext context,
                                        StateSetter setState) {
                                  return SizedBox(
                                    height: 500,
                                    child: SingleChildScrollView(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 44,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              padding: const EdgeInsets.all(5),
                                              color: Colors.deepOrange.shade300,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Pay With USSD",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      "Close",
                                                      style: GoogleFonts.poppins(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                          color: Colors.white),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 24,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Form(
                                                key: _formKey,
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
                                                            "Fee to be paid:",
                                                            style:
                                                                GoogleFonts.poppins(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize: 17,
                                                                    color: Colors
                                                                        .black),
                                                          ),
                                                          Text(
                                                            "\$${value.totalItem()}",
                                                            style:
                                                                GoogleFonts.poppins(
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize: 17),
                                                          )
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 9,
                                                      ),
                                                      Text(
                                                        "Bank Name",
                                                        style: GoogleFonts.poppins(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black),
                                                      ),
                                                      Center(
                                                        child:
                                                            DropdownButtonFormField<
                                                                String>(
                                                          value: _selectedBank,
                                                          items:
                                                              bankList.map((bank) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: bank,
                                                              child: Text(bank),
                                                            );
                                                          }).toList(),
                                                          onChanged: (newValue) {
                                                            setState(() {
                                                              _selectedBank =
                                                                  newValue;
                                                            });
                                                          },
                                                          style:
                                                              GoogleFonts.poppins(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 17,
                                                          ),
                                                          decoration:
                                                              InputDecoration(
                                                            hintText:
                                                                "Choose Your Bank",
                                                            hintStyle:
                                                                GoogleFonts.poppins(
                                                              color: Colors.black,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              fontSize: 17,
                                                            ),
                                                          ),
                                                          validator: (value) {
                                                            if (value == null ||
                                                                value.isEmpty) {
                                                              return 'Please select your bank';
                                                            }
                                                            return null;
                                                          },
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 29,
                                                      ),
                                                      Text(
                                                        "Phone Number",
                                                        style: GoogleFonts.poppins(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black),
                                                      ),
                                                      SingleChildScrollView(
                                                        child: Row(
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
                                                                      width: 1.2),
                                                                )),
                                                                child: Center(
                                                                  child: Text("+234",
                                                                      style: GoogleFonts.poppins(
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .bold,
                                                                          color: Colors
                                                                              .black)),
                                                                )),
                                                            const SizedBox(
                                                              width: 4,
                                                            ),
                                                            Container(
                                                              height: 43,
                                                              width: 336,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                      border: Border(
                                                                bottom: BorderSide(
                                                                    color:
                                                                        Colors.black,
                                                                    width: 1.2),
                                                              )),
                                                              child: TextFormField(
                                                                keyboardType:
                                                                    TextInputType
                                                                        .phone,
                                                                style: GoogleFonts
                                                                    .poppins(
                                                                  color: Colors.black,
                                                                  fontWeight:
                                                                      FontWeight.bold,
                                                                  fontSize: 17,
                                                                ),
                                                                controller:
                                                                    _phoneNumberController,
                                                                inputFormatters: [
                                                                  FilteringTextInputFormatter
                                                                      .digitsOnly,
                                                                  LengthLimitingTextInputFormatter(
                                                                      11),
                                                                ],
                                                                decoration:
                                                                    InputDecoration(
                                                                  hintText:
                                                                      "Phone Number",
                                                                  hintStyle:
                                                                      GoogleFonts
                                                                          .poppins(
                                                                    color: Colors.grey
                                                                        .shade600,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize: 17,
                                                                  ),
                                                                  border: InputBorder
                                                                      .none,
                                                                  contentPadding:
                                                                      const EdgeInsets
                                                                          .all(10),
                                                                ),
                                                                validator: (value) {
                                                                  if (value!
                                                                      .isEmpty) {
                                                                    return "Your Phone Number is required";
                                                                  }
                                                                  if (value.length !=
                                                                      11) {
                                                                    return "Please enter a valid 11-digit phone number";
                                                                  }
                                                                  return null;
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 18,
                                                      ),
                                                      Text(
                                                        "This is an encrypted payment, your",
                                                        style: GoogleFonts.poppins(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors
                                                                .grey.shade600),
                                                      ),
                                                      Text(
                                                        "details are 100% secured and safe",
                                                        style: GoogleFonts.poppins(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors
                                                                .grey.shade600),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 29,
                                            ),
                                            Center(
                                                child: GestureDetector(
                                                    onTap: () {
                                                      _payNow(context);
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors.deepOrange
                                                              .shade300,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12)),
                                                      height: 50,
                                                      width: 250,
                                                      child: Center(
                                                        child: Text(
                                                          "Get your bank USSD code",
                                                          style:
                                                              GoogleFonts.poppins(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                      ),
                                                    )))
                                          ]),
                                    ),
                                  );
                                }),
                              );
                            });
                      },
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 6,
                          ),
                          const Icon(Icons.qr_code_sharp),
                          Text(
                            "Pay with USSD",
                            style: GoogleFonts.poppins(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.grey.shade600,
                      thickness: 0.7,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Add your credit card to continue with payment.",
                      style: TextStyle(
                          // fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade600),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      "Pay with cards, bank transfer or USSD.",
                      style: TextStyle(
                          // fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade600),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Container(
                        width: 380,
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                            color: value.isChecking1
                                ? Colors.deepOrange.shade100
                                : Colors.white,
                            border: Border(
                              top: BorderSide(
                                  color: value.isChecking1
                                      ? Colors.deepOrange.shade100
                                      : Colors.white,
                                  width: 0.44),
                              left: BorderSide(
                                  color: value.isChecking1
                                      ? Colors.deepOrange.shade100
                                      : Colors.white,
                                  width: 0.44),
                              right: BorderSide(
                                  color: value.isChecking1
                                      ? Colors.deepOrange.shade100
                                      : Colors.white,
                                  width: 0.44),
                              bottom: BorderSide(
                                  color: value.isChecking1
                                      ? Colors.deepOrange.shade100
                                      : Colors.white,
                                  width: 0.84),
                            )),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.delivery_dining_sharp,
                                      color: Colors.deepOrange.shade300,
                                    ),
                                    Text(
                                      'Pay  on delivery',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.deepOrange.shade300),
                                    ),
                                  ],
                                ),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        Provider.of<TopDealer>(context,
                                                listen: false)
                                            .checkBox1 = !value.isChecking1;
                                      });
                                    },
                                    icon: value.isChecking1
                                        ? Icon(
                                            Icons.check_box,
                                            color: Colors.deepOrange.shade300,
                                          )
                                        : const Icon(Icons
                                            .check_box_outline_blank_sharp))
                              ],
                            ),
                            const Text(
                              "Pay with either cash, bank, transfers or card on delivery.",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.grey.shade600,
                      thickness: 0.7,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: Container(
                        width: 380,
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                            color: value.isChecking2
                                ? Colors.deepOrange.shade100
                                : Colors.white,
                            border: Border(
                              top: BorderSide(
                                  color: value.isChecking2
                                      ? Colors.deepOrange.shade100
                                      : Colors.white,
                                  width: 0.44),
                              left: BorderSide(
                                  color: value.isChecking2
                                      ? Colors.deepOrange.shade100
                                      : Colors.white,
                                  width: 0.44),
                              right: BorderSide(
                                  color: value.isChecking2
                                      ? Colors.deepOrange.shade100
                                      : Colors.white,
                                  width: 0.44),
                              bottom: BorderSide(
                                  color: value.isChecking2
                                      ? Colors.deepOrange.shade100
                                      : Colors.white,
                                  width: 0.84),
                            )),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Switch to self-pickup',
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
                                            .checkBox2 = !value.isChecking2;
                                      });
                                    },
                                    icon: value.isChecking2
                                        ? Icon(
                                            Icons.check_box,
                                            color: Colors.deepOrange.shade300,
                                          )
                                        : const Icon(Icons
                                            .check_box_outline_blank_sharp))
                              ],
                            ),
                            const Text(
                              "Save the extra delivery fee if you can pick your order(s)",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "Do You Have a Promo Code?",
                      style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Center(
                        child: Container(
                      height: 50,
                      width: 280,
                      decoration: BoxDecoration(
                          border: Border(
                        top: BorderSide(
                            color: Colors.grey.shade700, width: 0.94),
                        left: BorderSide(
                            color: Colors.grey.shade700, width: 0.94),
                        right: BorderSide(
                            color: Colors.grey.shade700, width: 0.94),
                        bottom: BorderSide(
                            color: Colors.grey.shade700, width: 0.94),
                      )),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          // Limit the input
                          LengthLimitingTextInputFormatter(6),
                        ],
                        style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Input your 6 digit promo code.",
                            helperStyle: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade600),
                            contentPadding: const EdgeInsets.all(6)),
                      ),
                    ))
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }


  //List of USSD codes
  Map<String, String> bankUssdCodes = {
    'Access Bank': '*901*234#',
    'Diamond Bank': '*426*43#',
    'Ecobank Nigeria': '*326*345#',
    'Fidelity Bank Nigeria': '*770*55#',
    'First Bank of Nigeria': '*894*543#',
    'Guaranty Trust Bank': '*737*334554#',
    'Keystone Bank Limited': '*7111*#356#',
    'Standard Chartered Bank': '*977*345#',
    'Union Bank of Nigeria': '*826*5325#',
    'United Bank for Africa': '*919*2344#',
    'Zenith Bank': '*966*3456#',
  };

  //the pay now function........................
  void _payNow(BuildContext context) async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    final bankName = _selectedBank;
    bool isValidBank = _validateBank(bankName!);

    if (!isValidBank) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Invalid Bank',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.deepOrange.shade300,
            ),
          ),
          content: const Text(
            'Please select a valid bank',
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
      return;
    }

    final ussdCode = bankUssdCodes[bankName];
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'USSD Code',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange.shade300,
          ),
        ),
        content: Text(
          'Dial $ussdCode to proceed with payment.',
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
              'Copy',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange.shade300,
              ),
            ),
          ),
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

  //validating bank names on the list
  bool _validateBank(String bankName) {
    // Implement validation logic here
    return bankList.contains(bankName);
  }

  //List of banks
  List bankList = [
    "Access Bank",
    "Diamond Bank",
    "Ecobank Nigeria",
    "Fidelity Bank Nigeria",
    "First Bank of Nigeria",
    "Guaranty Trust Bank",
    "Keystone Bank Limited",
    "Standard Chartered Bank",
    "Union Bank of Nigeria",
    "United Bank for Africa",
    "Zenith Bank"
  ];

  void getCardTypeFrmNumber() {
    if (cardNumberController.text.length <= 6) {
      String input = CardUtils.getCleanedNumber(cardNumberController.text);
      CardType type = CardUtils.getCardTypeFrmNumber(input);
      if (type != cardType) {
        setState(() {
          cardType = type;
        });
      }
    }
  }
}

//Card number placement class.................................
class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write('  '); // Add double spaces.
      }
    }
    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}
//Expiry date class.....................................
class CardMonthInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var newText = newValue.text;
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    var buffer = StringBuffer();
    for (int i = 0; i < newText.length; i++) {
      buffer.write(newText[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 2 == 0 && nonZeroIndex != newText.length) {
        buffer.write('/');
      }
    }
    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}

//Credit card class....................................
class CardUtils {
  static CardType getCardTypeFrmNumber(String input) {
    CardType cardType;
    if (input.startsWith(RegExp(
        r'((5[1-5])|(222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720))'))) {
      cardType = CardType.master;
    } else if (input.startsWith(RegExp(r'[4]'))) {
      cardType = CardType.Visa;
    } else if (input.startsWith(RegExp(r'((506([01]))|(507([89]))|(6500))'))) {
      cardType = CardType.Verve;
    } else if (input.startsWith(RegExp(r'((34)|(37))'))) {
      cardType = CardType.AmericanExpress;
    } else if (input.startsWith(RegExp(r'((6[45])|(6011))'))) {
      cardType = CardType.Discover;
    } else if (input.startsWith(RegExp(r'((30[0-5])|(3[89])|(36)|(3095))'))) {
      cardType = CardType.DinersClub;
    } else if (input.startsWith(RegExp(r'(352[89]|35[3-8][0-9])'))) {
      cardType = CardType.Jcb;
    } else if (input.length <= 8) {
      cardType = CardType.Others;
    } else {
      cardType = CardType.Invalid;
    }
    return cardType;
  }

  static String getCleanedNumber(String text) {
    RegExp regExp = RegExp(r"[^0-9]");
    return text.replaceAll(regExp, '');
  }

  static Widget? getCardIcon(CardType? cardType) {
    String img = "";
    Icon? icon;
    switch (cardType) {
      case CardType.master:
        img = 'images/mastercard.png';
        break;
      case CardType.Visa:
        img = 'images/visa.png';
        break;
      case CardType.Verve:
        img = 'images/verve.png';
        break;
      case CardType.AmericanExpress:
        img = 'images/ae.png';
        break;
      case CardType.Discover:
        img = "images/discover.png";
        break;
      case CardType.DinersClub:
        img = 'images/diners.png';
        break;
      case CardType.Jcb:
        img = 'images/jcb.png';
        break;
      case CardType.Others:
        icon = const Icon(
          Icons.credit_card,
          size: 24.0,
          color: Color(0xFFB8B5C3),
        );
        break;
      default:
        icon = const Icon(
          Icons.warning,
          size: 24.0,
          color: Color(0xFFB8B5C3),
        );
        break;
    }
    Widget? widget;
    if (img.isNotEmpty) {
      widget = Image.asset(
        img,
        width: 40.0,
      );
    } else {
      widget = icon;
    }
    return widget;
  }

  static String? validateCardNum(String? input) {
    if (input == null || input.isEmpty) {
      return "This field is required";
    }
    input = getCleanedNumber(input);
    if (input.length < 8) {
      return "Card is invalid";
    }
    int sum = 0;
    int length = input.length;
    for (var i = 0; i < length; i++) {
      // get digits in reverse order
      int digit = int.parse(input[length - i - 1]);
// every 2nd number multiply with 2
      if (i % 2 == 1) {
        digit *= 2;
      }
      sum += digit > 9 ? (digit - 9) : digit;
    }
    if (sum % 10 == 0) {
      return null;
    }
    return "Card is invalid";
  }

  static String? validateCVV(String? value) {
    if (value == null || value.isEmpty) {
      return "This field is required";
    }
    if (value.length < 3 || value.length > 4) {
      return "CVV is invalid";
    }
    return null;
  }

  static String? validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return "This field is required";
    }
    int year;
    int month;
    if (value.contains(RegExp(r'(/)'))) {
      var split = value.split(RegExp(r'(/)'));

      month = int.parse(split[0]);
      year = int.parse(split[1]);
    } else {
      month = int.parse(value.substring(0, (value.length)));
      year = -1; // Lets use an invalid year intentionally
    }
    if ((month < 1) || (month > 12)) {
      // A valid month is between 1 (January) and 12 (December)
      return 'Expiry month is invalid';
    }
    var fourDigitsYear = convertYearTo4Digits(year);
    if ((fourDigitsYear < 1) || (fourDigitsYear > 2099)) {
      // We are assuming a valid should be between 1 and 2099.
      // Note that, it's valid doesn't mean that it has not expired.
      return 'Expiry year is invalid';
    }
    if (!hasDateExpired(month, year)) {
      return "Card has expired";
    }
    return null;
  }

  static int convertYearTo4Digits(int year) {
    if (year < 100 && year >= 0) {
      var now = DateTime.now();
      String currentYear = now.year.toString();
      String prefix = currentYear.substring(0, currentYear.length - 2);
      year = int.parse('$prefix${year.toString().padLeft(2, '0')}');
    }
    return year;
  }

  static bool hasDateExpired(int month, int year) {
    return isNotExpired(year, month);
  }

  static bool isNotExpired(int year, int month) {
    // It has not expired if both the year and date has not passed
    return !hasYearPassed(year) && !hasMonthPassed(year, month);
  }

  static List<int> getExpiryDate(String value) {
    var split = value.split(RegExp(r'(/)'));
    return [int.parse(split[0]), int.parse(split[1])];
  }

  static bool hasMonthPassed(int year, int month) {
    var now = DateTime.now();
    // The month has passed if:
    // 1. The year is in the past. In that case, we just assume that the month
    // has passed
    // 2. Card's month (plus another month) is more than current month.
    return hasYearPassed(year) ||
        convertYearTo4Digits(year) == now.year && (month < now.month + 1);
  }

  static bool hasYearPassed(int year) {
    int fourDigitsYear = convertYearTo4Digits(year);
    var now = DateTime.now();
    // The year has passed if the year we are currently is more than card's
    // year
    return fourDigitsYear < now.year;
  }
}
