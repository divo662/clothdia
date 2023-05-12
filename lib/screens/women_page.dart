import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:store/model/product_provider_model.dart';

class WomenWear extends StatefulWidget {
  const WomenWear({Key? key}) : super(key: key);

  @override
  State<WomenWear> createState() => _WomenWearState();
}

class _WomenWearState extends State<WomenWear> with TickerProviderStateMixin {
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
    TabController tabController = TabController(length: 5, vsync: this);
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        extendBodyBehindAppBar: true,
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
              Container(
                height: 280,
                width: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          "images2/wd1.jpeg",
                        ),
                        fit: BoxFit.cover)),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Better when it's on you.",
                        style: GoogleFonts.poppins(
                          fontSize: 29,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
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
              Row(
                children: [
                  const SizedBox(
                    width: 25,
                  ),
                  Text("Women's Collections",
                      style: GoogleFonts.poppins(
                        fontSize: 23,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
              TabBar(
                unselectedLabelColor: Colors.black,
                indicatorColor: Colors.deepOrange.shade400,
                labelColor: Colors.deepOrange.shade400,
                tabs: const [
                  Tab(
                    child: Text(
                      "Blouse",
                      style: TextStyle(
                          fontSize: 16.7, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Skirt",
                      style: TextStyle(
                          fontSize: 16.7, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Trouser",
                      style: TextStyle(
                          fontSize: 16.7, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Gown",
                      style: TextStyle(
                          fontSize: 16.7, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "UnderWear",
                      style: TextStyle(
                          fontSize: 16.7, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
                controller: tabController,
                isScrollable: true,
                labelPadding: const EdgeInsets.symmetric(horizontal: 30),
              ),
              const SizedBox(
                height: 10,
              ),
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
                  SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: grid3Item(),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: grid4Item()
                        ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: grid5Item(),
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

  Widget gridItem({void Function()? onTap}) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<TopDealer>(
            builder: (context, value, child) {
              return GridView.builder(
                  physics: const ScrollPhysics(parent: ScrollPhysics()),
                  shrinkWrap: true,
                  itemCount: value.womenShirt.length,
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
                                            value.womenShirt[index][1]),
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
                                                        value.womenShirt[index]
                                                            [0],
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 29,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Icon(
                                                        Icons
                                                            .favorite_border_sharp,
                                                        size: 32,
                                                        color: Colors
                                                            .grey.shade700,
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "\$${value.womenShirt[index][2]}",
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
                                                        "${value.womenShirt[index][4]}",
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
                                                        "\$${value.womenShirt[index][2]}",
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
                                                                .addWomenShirtToCart(
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
                                                                        .womenShirt[
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
                                        value.womenShirt[index][1],
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
                                    value.womenShirt[index][0],
                                    style: const TextStyle(
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "\$${value.womenShirt[index][2]}",
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

  Widget grid2Item({void Function()? onTap}) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<TopDealer>(
            builder: (context, value, child) {
              return GridView.builder(
                  physics: const ScrollPhysics(parent: ScrollPhysics()),
                  shrinkWrap: true,
                  itemCount: value.womenSkirt.length,
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
                                            value.womenSkirt[index][1]),
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
                                                        value.womenSkirt[index]
                                                            [0],
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 29,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Icon(
                                                        Icons
                                                            .favorite_border_sharp,
                                                        size: 32,
                                                        color: Colors
                                                            .grey.shade700,
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "\$${value.womenSkirt[index][2]}",
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
                                                        "${value.womenSkirt[index][4]}",
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
                                                        "\$${value.womenSkirt[index][2]}",
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
                                                                .addWomenSkirtToCart(
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
                                                                        .womenSkirt[
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
                                        value.womenSkirt[index][1],
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
                                    value.womenSkirt[index][0],
                                    style: const TextStyle(
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "\$${value.womenSkirt[index][2]}",
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

  Widget grid3Item({void Function()? onTap}) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<TopDealer>(
            builder: (context, value, child) {
              return GridView.builder(
                  physics: const ScrollPhysics(parent: ScrollPhysics()),
                  shrinkWrap: true,
                  itemCount: value.womenTrouser.length,
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
                                            value.womenTrouser[index][1]),
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
                                                        value.womenTrouser[
                                                            index][0],
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 29,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Icon(
                                                        Icons
                                                            .favorite_border_sharp,
                                                        size: 32,
                                                        color: Colors
                                                            .grey.shade700,
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "\$${value.womenTrouser[index][2]}",
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
                                                        "${value.womenTrouser[index][4]}",
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
                                                        "\$${value.womenTrouser[index][2]}",
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
                                                                .addWomenTrouserToCart(
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
                                                                        .womenTrouser[
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
                                        value.womenTrouser[index][1],
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
                                    value.womenTrouser[index][0],
                                    style: const TextStyle(
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "\$${value.womenTrouser[index][2]}",
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

  Widget grid4Item({void Function()? onTap}) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<TopDealer>(
            builder: (context, value, child) {
              return GridView.builder(
                  physics: const ScrollPhysics(parent: ScrollPhysics()),
                  shrinkWrap: true,
                  itemCount: value.womenGown.length,
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
                                            value.womenGown[index][1]),
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
                                                        value.womenGown[index]
                                                            [0],
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 29,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Icon(
                                                        Icons
                                                            .favorite_border_sharp,
                                                        size: 32,
                                                        color: Colors
                                                            .grey.shade700,
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "\$${value.womenGown[index][2]}",
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
                                                        "${value.womenGown[index][4]}",
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
                                                        "\$${value.womenGown[index][2]}",
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
                                                                .addWomenGownToCart(
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
                                                                        .womenGown[
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
                                        value.womenGown[index][1],
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
                                    value.womenGown[index][0],
                                    style: const TextStyle(
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "\$${value.womenGown[index][2]}",
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

  Widget grid5Item({void Function()? onTap}) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<TopDealer>(
            builder: (context, value, child) {
              return GridView.builder(
                  physics: const ScrollPhysics(parent: ScrollPhysics()),
                  shrinkWrap: true,
                  itemCount: value.womenUnder.length,
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
                                            value.womenUnder[index][1]),
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
                                                        value.womenUnder[index]
                                                            [0],
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 29,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Icon(
                                                        Icons
                                                            .favorite_border_sharp,
                                                        size: 32,
                                                        color: Colors
                                                            .grey.shade700,
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "\$${value.womenUnder[index][2]}",
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
                                                        "${value.womenUnder[index][4]}",
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
                                                        "\$${value.womenUnder[index][2]}",
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
                                                                .addWomenUnderToCart(
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
                                                                        .womenUnder[
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
                                        value.womenUnder[index][1],
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
                                    value.womenUnder[index][0],
                                    style: const TextStyle(
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "\$${value.womenUnder[index][2]}",
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
