import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:store/model/product_provider_model.dart';

// THE CODE FOR THE FACE CAP CATEGORY///////////////////////////////
class Face extends StatefulWidget {
  const Face({Key? key}) : super(key: key);

  @override
  State<Face> createState() => _FaceState();
}

// WRAPPED WITH TICKER PROVIDER STATE MIXIN BECAUSE WE ARE USING TAB CONTROLLER
class _FaceState extends State<Face> with TickerProviderStateMixin {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // WRAPPING OUR SCAFFOLD WITH DEFAULT TAB CONTROLLER////////////
    TabController tabController = TabController(length: 2, vsync: this);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        // THE APP BAR BECOMES OPAQUE
        extendBodyBehindAppBar: true,
        // APP BAR//////////////////////////////////////
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
          ),
          title: Row(
            children: [
              const SizedBox(
                width: 40,
              ),
              const Text(
                "Clothedia",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                width: 120,
              ),
              GestureDetector(
                child: const Icon(
                  Icons.shopping_bag,
                  color: Colors.black,
                  size: 25,
                ),
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // THE TOP SCREEN INTRO IMAGE////////////////////////////
              Container(
                height: 280,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.deepOrange.shade50,
                    image: const DecorationImage(
                        image: AssetImage(
                          "images/cap5.png",
                        ),
                        fit: BoxFit.cover)),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 129,
                      ),
                      Text(
                        "Caps are great for people who like to look sharp.",
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // THE CONTAINER FOR SEARCH//////////////////////////
              Container(
                height: 46,
                width: 380,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 2,
                          color: Colors.grey.shade700,
                          spreadRadius: 0.5,
                          offset: const Offset(0.3, 0.3))
                    ]),
                //the search function is null
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 19),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search for product...",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade600,
                          fontSize: 17),
                      suffixIcon: const Icon(CupertinoIcons.search),
                      contentPadding: const EdgeInsets.all(7)),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              // THE GRID VIEW TITLE/////////////////////////
              Row(
                children: [
                  const SizedBox(
                    width: 25,
                  ),
                  Text("Cap Collections",
                      style: GoogleFonts.poppins(
                        fontSize: 23,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
              //THE MALE AND FEMALE TAB BAR////////////////////
              TabBar(
                unselectedLabelColor: Colors.black,
                indicatorColor: Colors.deepOrange.shade400,
                labelColor: Colors.deepOrange.shade400,
                dividerColor: Colors.red,
                padding: const EdgeInsets.all(2),
                tabs: const [
                  Tab(
                    child: Text(
                      "Male",
                      style: TextStyle(
                          fontSize: 16.7, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Female",
                      style: TextStyle(
                          fontSize: 16.7, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
                controller: tabController,
                isScrollable: true,
                labelPadding: const EdgeInsets.symmetric(horizontal: 30),
              ),
              const SizedBox(
                height: 10,
              ),
              // THE GRID VIEW CONTROLLER///////////////////////////
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: TabBarView(controller: tabController, children: [
                  SingleChildScrollView(
                    child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: gridItem()
                        //   children: [
                        //     SingleChildScrollView(child: gridItem())
                        //   ],
                        // ),
                        ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: grid2Item(),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // THE FUNCTION FOR THE FIRST GRID WIDGET//////////////////////////
  Widget gridItem({void Function()? onTap}) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          // WRAPPED WITH A PROVIDER CONSUMER FOR TOP DEALER/////////////////
          child: Consumer<TopDealer>(
            builder: (context, value, child) {
              // RETURNS A GRID VIEW BUILDER////////////////////////
              return GridView.builder(
                  physics: const ScrollPhysics(parent: ScrollPhysics()),
                  shrinkWrap: true,
                  itemCount: value.faceMale.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: (0.72),
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // SHOWS A BOTTOM SHEET WHEN THE GRID VIEW IS TAPPED///
                        showBottomSheet(
                            context: context,
                            elevation: 15,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            builder: (context) {
                              return SingleChildScrollView(
                                child: Container(
                                  // BOTTOM SHEET BOX FIT IMAGE/////////
                                  height: 730,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.deepOrange.shade50,
                                    image: DecorationImage(
                                        image: AssetImage(
                                            value.faceMale[index][1]),
                                        fit: BoxFit.contain,
                                        alignment: Alignment.topCenter),
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 29,
                                        ),
                                        Row(
                                          children: [
                                            const SizedBox(
                                              width: 326,
                                            ),
                                            // THE CLOSE BOTTOM SHEET BUTTON
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                height: 30,
                                                width: 80,
                                                decoration: BoxDecoration(
                                                    color: Colors.transparent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            13)),
                                                child: const Text(
                                                  "Close",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            const SizedBox(
                                              height: 479,
                                            ),
                                            // DESIGNING THE WHITE CONTAINER///
                                            Container(
                                              height: 387,
                                              padding: const EdgeInsets.all(22),
                                              width: double.infinity,
                                              decoration: const BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                        blurRadius: 17,
                                                        spreadRadius: 2,
                                                        color: Colors.black)
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  25),
                                                          topRight:
                                                              Radius.circular(
                                                                  25)),
                                                  color: Colors.white),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    // THE PRODUCT TITLE
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        value.faceMale[index]
                                                            [0],
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 29,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      // THE ADD TO FAVORITE BUTTON
                                                      GestureDetector(
                                                          child: Icon(
                                                                  Icons
                                                                      .favorite_border_sharp,
                                                                  size: 32,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade700,
                                                                )
                                                             )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  // THE PRICE OF THE ITEM
                                                  Text(
                                                    "\$${value.faceMale[index][2]}",
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Text(
                                                        "Brand: ",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        "${value.faceMale[index][4]}",
                                                        style: const TextStyle(
                                                            color: Colors.red,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  const Text(
                                                    "Product Rating:",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  const Row(
                                                    children: [
                                                      Icon(
                                                        Icons.star,
                                                        color: Colors.orange,
                                                        size: 27,
                                                      ),
                                                      Icon(
                                                        Icons.star,
                                                        color: Colors.orange,
                                                        size: 27,
                                                      ),
                                                      Icon(
                                                        Icons.star,
                                                        color: Colors.orange,
                                                        size: 27,
                                                      ),
                                                      Icon(
                                                        Icons.star,
                                                        color: Colors.orange,
                                                        size: 27,
                                                      ),
                                                      Icon(
                                                        Icons.star,
                                                        color: Colors.orange,
                                                        size: 27,
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "\$${value.faceMale[index][2]}",
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 25,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            Provider.of<TopDealer>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .addMaleFaceToCart(
                                                                    index);
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return AlertDialog(
                                                                    title: Text(
                                                                        "Added to Cart!",
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          color:
                                                                              Colors.black,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontSize:
                                                                              19,
                                                                        )),
                                                                    content: Text(
                                                                        "Added to Cart. Go "
                                                                        "to Cart to continue.",
                                                                        style: GoogleFonts.poppins(
                                                                          color:
                                                                              Colors.black,
                                                                          fontSize:
                                                                              17,
                                                                        )),
                                                                    actions: [
                                                                      TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child:
                                                                              const Text("Close"))
                                                                    ],
                                                                  );
                                                                });
                                                          });
                                                        },
                                                        child: Container(
                                                            height: 40,
                                                            width: 240,
                                                            // padding: EdgeInsets.all(12),
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12),
                                                                color: value
                                                                        .faceMale[
                                                                    index][3]),
                                                            child: Center(
                                                                child: Text(
                                                              "Add to Cart",
                                                              style: GoogleFonts.poppins(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 19),
                                                            ))),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                      child: Column(
                        children: [
                          Stack(children: [
                            Container(
                              height: 220,
                              width: 190,
                              decoration: BoxDecoration(
                                  color: Colors.deepOrange.shade50,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.asset(
                                        value.faceMale[index][1],
                                        width: double.infinity,
                                        // fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const Row(
                              children: [
                                SizedBox(
                                  height: 49,
                                  width: 150,
                                ),
                                Icon(
                                  Icons.shopping_cart,
                                  size: 28,
                                  color: Colors.black,
                                )
                              ],
                            ),
                          ]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    value.faceMale[index][0],
                                    style: const TextStyle(
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "\$${value.faceMale[index][2]}",
                                    style: TextStyle(
                                        fontSize: 21,
                                        color: Colors.deepOrange.shade700,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  });
            },
          )),
    );
  }

  // THE FUNCTION FOR THE SECOND GRID WIDGET/////////////////////////
  Widget grid2Item({void Function()? onTap}) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<TopDealer>(
            builder: (context, value, child) {
              return GridView.builder(
                  physics: const ScrollPhysics(parent: ScrollPhysics()),
                  shrinkWrap: true,
                  itemCount: value.faceFemale.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: (0.72),
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        showBottomSheet(
                            context: context,
                            elevation: 15,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            builder: (context) {
                              return SingleChildScrollView(
                                child: Container(
                                  height: 730,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.deepOrange.shade50,
                                    image: DecorationImage(
                                        image: AssetImage(
                                            value.faceFemale[index][1]),
                                        fit: BoxFit.contain,
                                        alignment: Alignment.topCenter),
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 29,
                                        ),
                                        Row(
                                          children: [
                                            const SizedBox(
                                              width: 326,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                height: 30,
                                                width: 80,
                                                decoration: BoxDecoration(
                                                    color: Colors.transparent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            13)),
                                                child: const Text(
                                                  "Close",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            const SizedBox(
                                              height: 479,
                                            ),
                                            Container(
                                              height: 387,
                                              padding: const EdgeInsets.all(22),
                                              width: double.infinity,
                                              decoration: const BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                        blurRadius: 17,
                                                        spreadRadius: 2,
                                                        color: Colors.black)
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  25),
                                                          topRight:
                                                              Radius.circular(
                                                                  25)),
                                                  color: Colors.white),
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
                                                        value.faceFemale[index]
                                                            [0],
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 29,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      GestureDetector(

                                                          child: Icon(
                                                                  Icons
                                                                      .favorite_border_sharp,
                                                                  size: 32,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade700,
                                                                )
                                                             )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "\$${value.faceFemale[index][2]}",
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Text(
                                                        "Brand: ",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        "${value.faceFemale[index][4]}",
                                                        style: const TextStyle(
                                                            color: Colors.red,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  const Text(
                                                    "Product Rating:",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  const Row(
                                                    children: [
                                                      Icon(
                                                        Icons.star,
                                                        color: Colors.orange,
                                                        size: 27,
                                                      ),
                                                      Icon(
                                                        Icons.star,
                                                        color: Colors.orange,
                                                        size: 27,
                                                      ),
                                                      Icon(
                                                        Icons.star,
                                                        color: Colors.orange,
                                                        size: 27,
                                                      ),
                                                      Icon(
                                                        Icons.star,
                                                        color: Colors.orange,
                                                        size: 27,
                                                      ),
                                                      Icon(
                                                        Icons.star,
                                                        color: Colors.orange,
                                                        size: 27,
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "\$${value.faceFemale[index][2]}",
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 25,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            Provider.of<TopDealer>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .addFemaleFaceToCart(
                                                                    index);
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return AlertDialog(
                                                                    title: Text(
                                                                        "Added to Cart!",
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          color:
                                                                              Colors.black,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontSize:
                                                                              19,
                                                                        )),
                                                                    content: Text(
                                                                        "Added to Cart. Go "
                                                                        "to Cart to continue.",
                                                                        style: GoogleFonts.poppins(
                                                                          color:
                                                                              Colors.black,
                                                                          fontSize:
                                                                              17,
                                                                        )),
                                                                    actions: [
                                                                      TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child:
                                                                              const Text("Close"))
                                                                    ],
                                                                  );
                                                                });
                                                          });
                                                        },
                                                        child: Container(
                                                            height: 40,
                                                            width: 240,
                                                            // padding: EdgeInsets.all(12),
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12),
                                                                color: value
                                                                        .faceFemale[
                                                                    index][3]),
                                                            child: Center(
                                                                child: Text(
                                                              "Add to Cart",
                                                              style: GoogleFonts.poppins(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 19),
                                                            ))),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                      child: Column(
                        children: [
                          Stack(children: [
                            Container(
                              height: 220,
                              width: 190,
                              decoration: BoxDecoration(
                                  color: Colors.deepOrange.shade50,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.asset(
                                        value.faceFemale[index][1],
                                        width: double.infinity,
                                        // fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const Row(
                              children: [
                                SizedBox(
                                  height: 49,
                                  width: 150,
                                ),
                                Icon(
                                  Icons.shopping_cart,
                                  size: 28,
                                  color: Colors.black,
                                )
                              ],
                            ),
                          ]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    value.faceFemale[index][0],
                                    style: const TextStyle(
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "\$${value.faceFemale[index][2]}",
                                    style: TextStyle(
                                        fontSize: 21,
                                        color: Colors.deepOrange.shade700,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  });
            },
          )),
    );
  }
}
