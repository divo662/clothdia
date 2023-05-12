import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'delivery_address.dart';
import 'payment_page.dart';

class CardForm extends StatefulWidget {
  const CardForm({Key? key}) : super(key: key);

  @override
  State<CardForm> createState() => _CardFormState();
}

class _CardFormState extends State<CardForm> {
  final List<String> _pages = ['Checkout(1/3)', 'Checkout(2/3)', ];
  final List<Widget> _pageViews = [
    const AddressPage(),
    const PaymentPage(),
  ];
  int _currentPageIndex = 0;
  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          "Place your order",
          style: GoogleFonts.poppins(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange.shade300,
          ),
        ),
      ),
      body: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState){
          return  SingleChildScrollView(
            child: Column(
              children: [
                DotsIndicator(
                  dotsCount: _pages.length,
                  position: _currentPageIndex.toDouble(),
                  decorator: DotsDecorator(
                    activeColor: Colors.deepOrange.shade300,
                    size: const Size.square(8),
                    activeSize: const Size.square(12),
                    spacing: const EdgeInsets.symmetric(horizontal: 6),
                    color: Colors.grey,
                    activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey.shade400,
                  thickness: 0.5,
                ),
                CarouselSlider.builder(
                  itemCount: _pages.length,
                  carouselController: _carouselController,
                  itemBuilder: (BuildContext context, int index, int realIndex) {
                    return _pageViews[index];
                  },
                  options: CarouselOptions(
                    height: 660,
                    aspectRatio: 18 / 8,
                    viewportFraction: 1,
                    enableInfiniteScroll: false,
                    pageSnapping: false,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentPageIndex = index;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap:  _currentPageIndex == 0
                          ? null
                          : () => _carouselController.previousPage(),
                      child: Container(
                        height: 40,
                        width: 100,
                        color: Colors.deepOrange.shade300,
                        child: Center(
                          child: Text("Previous",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5,),
                    GestureDetector(
                      onTap: _currentPageIndex == _pages.length -1?
                      null:
                          () => _carouselController.nextPage(),
                      child: Container(
                        height: 40,
                        width: 100,
                        color: Colors.deepOrange.shade300,
                        child: Center(
                          child: Text("Next",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
