import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:store/screens/face_cap.dart';
import 'package:store/screens/handbag.dart';
import 'package:store/screens/men_wear.dart';
import 'package:store/screens/shoes_page.dart';
import 'package:store/screens/watches_page.dart';
import 'package:store/screens/women_page.dart';
import 'package:store/widgets/grid.dart';

import '../model/product_provider_model.dart';
import '../model/user.dart';
import 'glasses.dart';
import 'kid_clothings.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  bool showBackPage = false;
  ScrollController scrollController = ScrollController();
  int activeIndex = 0;
  int counter = 0;
  final controller = CarouselController();
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    // floating action button function
    scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          if (scrollController.offset >= 400) {
            showBackPage = true;
          } else {
            showBackPage = false;
          }
        });
      });
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
    showBackPage;
    super.dispose();
  }

  void scrollToTop() {
    scrollController.animateTo(0,
        duration: const Duration(seconds: 3), curve: Curves.linear);
  }

  // LIST OF IMAGES for carousel slider
  final barImages = [
    "images/canvas.jpg",
    "images/fila.jpeg",
    "images/gucci1.jpg",
    "images/handy3.jpg",
    "images/suit1.jpeg",
    "images/nike1.jpeg",
    "images/menc3.png",
    "images/ws4.jpg",
    "images/shirt4.jpg",
    "images/photo2.webp",
    "images/ws8.jpg",
  ];

  //LIST OF TITLE for carousel slider
  final List<String> texts = [
    "nike Canvas(Blubera)",
    "Brown Fila",
    "Drala Gucci",
    "Danilea Backpack",
    "Louise Black Suit",
    "Nike Jordan D54",
    "Nike Jordan R32",
    "Stella black High-heels",
    "Brammer Vintage Shirt",
    "Sasha Transparent Suit",
    "Nike Jordan Y72",
  ];

  // LIST OF COLORS for carousel slider
  final List<MaterialColor> myColors = [
    Colors.orange,
    Colors.red,
    Colors.blue,
    Colors.purple,
    Colors.green,
    Colors.pink,
    Colors.indigo,
    Colors.brown,
    Colors.yellow,
    Colors.deepPurple,
    Colors.blue,
  ];

  //LIST OF DEALS for carousel slider
  final List<String> deals = [
    "25% OFF!",
    "20% OFF!",
    "15% OFF!",
    "45% OFF!",
    "20% OFF!",
    "45% OFF!",
    "20% OFF!",
    "30% OFF!",
    "20% OFF!",
    "25% OFF!",
    "25% OFF!",
  ];

  //Recently Searched Items
  Widget buildRecentlySearchedItems() {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Consumer<TopDealer>(
          builder: (context, value, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Recently Searched Items:",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: value.recentlySearchedItems.map((item) {
                    return Chip(
                      label: Text(item),
                      onDeleted: () {
                        setState(() {
                          value.recentlySearchedItems.remove(item);
                        });
                      },
                    );
                  }).toList(),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: AnimatedOpacity(
          opacity: showBackPage ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 1000),
          child: FloatingActionButton(
            onPressed: () {
              setState(() {
                scrollController.animateTo(0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn);
              });
            },
            backgroundColor: Colors.deepOrange.shade300,
            child: const Icon(CupertinoIcons.arrow_up),
          ),
        ),
        body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool isScrolled) {
              return [
                //APP BAR
                SliverAppBar(
                  snap: false,
                  automaticallyImplyLeading: false,
                  forceMaterialTransparency: true,
                  backgroundColor: Colors.deepOrange.shade50,
                  elevation: 7,
                  floating: true,
                  iconTheme: const IconThemeData(color: Colors.black),
                  surfaceTintColor: Colors.deepOrange.shade50,
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding: const EdgeInsets.all(5),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Hello ${loggedInUser.firstName}",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Badge(
                              label: Consumer<TopDealer>(
                                builder: (context, value, child) {
                                  return Text(
                                      value.cartItems.length.toString());
                                },
                              ),
                              textStyle: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                              child: const Icon(
                                Icons.shopping_cart,
                                color: Colors.black,
                                size: 25,
                              ),
                            ),
                            const SizedBox(
                              width: 9,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ];
            },
            // body........................................................
            body: SingleChildScrollView(
              controller: scrollController,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Welcome to best store to find your style.",
                        style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    GestureDetector(
                      onTap: () {
                        showBottomSheet(
                          context: context,
                          builder: (context) {
                            return Consumer<TopDealer>(
                              builder: (context, value, child) {
                                return StatefulBuilder(
                                  builder: (BuildContext context,
                                      StateSetter setState) {
                                    return SingleChildScrollView(
                                      child: SizedBox(
                                        height: 741,
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
                                                  Container(
                                                    height: 46,
                                                    width: 300,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          blurRadius: 2,
                                                          color: Colors
                                                              .grey.shade700,
                                                          spreadRadius: 0.5,
                                                          offset: const Offset(
                                                              0.3, 0.3),
                                                        ),
                                                      ],
                                                    ),
                                                    child: TextField(
                                                      controller:
                                                          searchController,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          searchController
                                                                  .text =
                                                              value; // Update the search text
                                                          Provider.of<TopDealer>(
                                                                  context,
                                                                  listen: false)
                                                              .runFilter(value);
                                                        });
                                                      },
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                        fontSize: 19,
                                                      ),
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText:
                                                            "Search for product...",
                                                        hintStyle: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors
                                                              .grey.shade600,
                                                          fontSize: 17,
                                                        ),
                                                        suffixIcon: const Icon(
                                                            CupertinoIcons
                                                                .search),
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .all(7),
                                                      ),
                                                      textDirection: TextDirection
                                                          .ltr, // Set the text direction to ltr
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
                                                        color: Colors.deepOrange
                                                            .shade300,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              buildRecentlySearchedItems(),
                                              if (value.searchResult.isEmpty &&
                                                  searchController.text
                                                      .isNotEmpty) // Show "This query is not found"
                                                Center(
                                                  child: Text(
                                                    "This query is not found",
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 19,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              if (value.searchResult.isEmpty &&
                                                  searchController.text
                                                      .isEmpty) // Show "No Search Made"
                                                Center(
                                                  child: Text(
                                                    "No Search Made",
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 19,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              if (value.searchResult
                                                  .isNotEmpty) // Show search results
                                                Expanded(
                                                    child: GridView.builder(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  gridDelegate:
                                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    mainAxisSpacing: 8,
                                                    crossAxisSpacing: 8,
                                                    childAspectRatio: 0.65,
                                                  ),
                                                  itemCount:
                                                      value.searchResult.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    // Get the item from the results list
                                                    return GridItem(
                                                      itemName:
                                                          value.searchResult[
                                                              index][0],
                                                      itemOverview:
                                                          value.searchResult[
                                                              index][5],
                                                      itemPrice:
                                                          value.searchResult[
                                                              index][2],
                                                      color: value.searchResult[
                                                          index][3],
                                                      itemBrand:
                                                          value.searchResult[
                                                              index][4],
                                                      itemImage:
                                                          value.searchResult[
                                                              index][1],
                                                      onTap: () {
                                                        Provider.of<TopDealer>(
                                                                context,
                                                                listen: false)
                                                            .addItemToCart(
                                                                index);
                                                      },
                                                    );
                                                  },
                                                )
                                                    // Replace with your desired empty container widget
                                                    ),
                                            ],
                                          ),
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
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Search for product...",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade600,
                                      fontSize: 17),
                                ),
                                const Icon(CupertinoIcons.search)
                              ],
                            )),
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    // CATEGORY TEXT......................................
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "New Promo",
                        style: GoogleFonts.roboto(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 17,
                    ),
                    // STACK OF CAROUSEL...................................
                    Stack(
                      children: [
                        CarouselSlider.builder(
                          itemCount: barImages.length,
                          carouselController: controller,
                          options: CarouselOptions(
                              height: 381,
                              initialPage: 0,
                              autoPlay: true,
                              aspectRatio: 18 / 8,
                              autoPlayInterval: const Duration(seconds: 2),
                              viewportFraction: 1,
                              // enlargeCenterPage: true,
                              // pageSnapping: false
                              // enableInfiniteScroll: false,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  activeIndex = index;
                                });
                              }),
                          itemBuilder: (context, index, realIndex) {
                            final carImages = barImages[index];

                            return buildImages(carImages, index);
                          },
                        ),
                        Center(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 85,
                              ),
                              const Row(
                                children: [
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Text(
                                    "NEW PROMO!!!",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 37,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 25,
                                  ),
                                  Text(
                                    texts[activeIndex],
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 25,
                                  ),
                                  Text(
                                    deals[activeIndex],
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 55,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 4),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              shopButton(),
                              const SizedBox(height: 25),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Center(child: buildIndicator()),
                    const SizedBox(height: 15),
                    // SEARCH BAR............................................
                    const SizedBox(height: 26),
                    Row(
                      children: [
                        const SizedBox(
                          width: 25,
                        ),
                        // CATEGORY TEXT......................................
                        Text(
                          "Category",
                          style: GoogleFonts.roboto(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    // SLIDE VIEW OF CATEGORY WIDGETS..........................
                    const SizedBox(
                      height: 10,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          category(
                              text: "Men's Wear",
                              images: "images/men3.png",
                              onTapped: const MenWear()),
                          const SizedBox(
                            width: 15,
                          ),
                          category(
                              text: "Women's Wear",
                              images: "images/dress8.png",
                              onTapped: const WomenWear()),
                          const SizedBox(
                            width: 15,
                          ),
                          category(
                              text: "Kid's Wear",
                              images: "images/kid10.png",
                              onTapped: const KidWears()),
                          const SizedBox(
                            width: 15,
                          ),
                          category(
                              text: "Glasses",
                              images: "images/glass5.png",
                              onTapped: const Glasses()),
                          const SizedBox(
                            width: 15,
                          ),
                          category(
                              text: "HandBags",
                              images: "images/bag6.png",
                              onTapped: const HandBag()),
                          const SizedBox(
                            width: 15,
                          ),
                          category(
                              text: "Watches",
                              images: "images/watch 5.png",
                              onTapped: const Watch()),
                          const SizedBox(
                            width: 15,
                          ),
                          category(
                              text: "Face Caps",
                              images: "images/cap5.png",
                              onTapped: const Face()),
                          category(
                              text: "Shoes",
                              images: "images/shoe2.png",
                              onTapped: const Shoes()),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    // TOP DEAL TEXT.....................................
                    Row(
                      children: [
                        const SizedBox(
                          width: 23,
                        ),
                        Text("Recommended for you",
                            style: GoogleFonts.poppins(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                    // TOP DEALS WIDGETS....................................
                    gridItem(),
                  ],
                ),
              ),
            )));
  }

  // CAROUSEL WIDGET BUILDER........................................
  Widget buildImages(String carImages, int index) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 400,
        decoration: BoxDecoration(
            color: Colors.deepOrange.shade50,
            borderRadius: BorderRadius.circular(12)),
        child: Image.asset(
          carImages,
          colorBlendMode: BlendMode.darken,
          fit: BoxFit.cover,
          filterQuality: FilterQuality.high,
        ),
      ),
    );
  }

  // CAROUSEL INDICATOR...........................................
  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: barImages.length,
        onDotClicked: animateToSlide,
        effect: ExpandingDotsEffect(
          activeDotColor: myColors[activeIndex],
          dotColor: Colors.grey.shade400,
          dotHeight: 9,
          dotWidth: 7,
        ),
      );

  // CAROUSEL PREVIOUS AND NEXT BUTTON.........................................
  Widget buildButton({bool stretch = false}) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: previous,
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32)),
              child: const Icon(Icons.arrow_back_ios_new)),
          stretch
              ? const Spacer()
              : const SizedBox(
                  width: 32,
                ),
          ElevatedButton(
              onPressed: next,
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32)),
              child: const Icon(Icons.arrow_forward_ios)),
        ],
      );

  void animateToSlide(int index) {
    controller.animateToPage(index);
  }

  //CAROUSEL ADD CART BUILD BUTTON......................................
  Widget shopButton() {
    return Row(
      children: [
        const SizedBox(
          width: 265,
        ),
        GestureDetector(
          child: Container(
              height: 45,
              padding: const EdgeInsets.all(12),
              width: 121,
              decoration: BoxDecoration(
                  color: myColors[activeIndex],
                  borderRadius: BorderRadius.circular(13)),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.cart,
                    color: Colors.black,
                  ),
                  SizedBox(width: 1),
                  Text(
                    "Add to Cart",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  )
                ],
              )),
        )
      ],
    );
  }

  // CATEGORY WIDGETS..................................................
  Widget category({text, images, onTapped}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => onTapped));
            },
            child: Container(
              height: 77,
              width: 99,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  color: Colors.deepOrange.shade50),
              child: Image.asset(images),
            ),
          ),
          Text(
            text as String,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18),
          )
        ],
      ),
    );
  }

//GRID LIST FOR TOP VIEW................................
  Widget gridItem({void Function()? onTap}) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TopDealer>(
          builder: (context, value, child) {
            return GridView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: value.dealsItems.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: (0.72),
                ),
                itemBuilder: (context, index) {
                  // Get the current item
                  return GridItem(
                    itemName: value.dealsItems[index][0],
                    itemOverview: value.dealsItems[index][5],
                    itemPrice: value.dealsItems[index][2],
                    color: value.dealsItems[index][3],
                    itemBrand: value.dealsItems[index][4],
                    itemImage: value.dealsItems[index][1],
                    onTap: () {
                      Provider.of<TopDealer>(context, listen: false)
                          .addItemToCart(index);
                    },
                  );
                });
          },
        ),
      ),
    );
  }

  void previous() =>
      controller.nextPage(duration: const Duration(milliseconds: 500));

  void next() =>
      controller.previousPage(duration: const Duration(milliseconds: 500));
}
