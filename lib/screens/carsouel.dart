import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:store/screens/get_started_page.dart';

class CarsouelPage extends StatefulWidget {
  const CarsouelPage({Key? key}) : super(key: key);

  @override
  State<CarsouelPage> createState() => _CarsouelPageState();
}

class _CarsouelPageState extends State<CarsouelPage> {
  int activeIndex = 0;
  final controller = CarouselController();
  final barImages = [
    "images/photo7.webp",
    "images/photo5.jpeg",
    "images/photo4.jpeg"
  ];
  final List<MaterialColor> hisColors = [
    Colors.red,
    Colors.brown,
    Colors.blue,
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.deepOrange[50],
          body: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 25,
                    ),
                    AnimatedTextKit(animatedTexts: [
                      ColorizeAnimatedText("Latest Trendy",
                          textStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 34,
                              fontWeight: FontWeight.bold),
                          colors: [
                            Colors.orange,
                            Colors.red,
                            Colors.black,
                          ],
                          speed: const Duration(seconds: 4)),
                    ]),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 25,
                    ),
                    AnimatedTextKit(animatedTexts: [
                      ColorizeAnimatedText("Collection.",
                          textStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 34,
                              fontWeight: FontWeight.bold),
                          colors: [
                            Colors.orange,
                            Colors.red,
                            Colors.black,
                          ],
                          speed: const Duration(seconds: 4)),
                    ]),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 25,
                    ),
                    Text(
                      "Shop the most modern essential.",
                      style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 80,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 25,
                    ),
                    buildIndicator(),
                    const SizedBox(
                      width: 175,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const StartedPage()));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black),
                        child: const Text(
                          "Get Started",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 9,
                ),
                CarouselSlider.builder(
                  itemCount: barImages.length,
                  carouselController: controller,
                  options: CarouselOptions(
                      height: 571,
                      initialPage: 0,
                      autoPlay: true,
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
              ],
            ),
          )),
    );
  }

  Widget buildImages(String carImages, int index) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.grey,
      child: Image.asset(
        carImages,
        colorBlendMode: BlendMode.darken,
        fit: BoxFit.cover,
        filterQuality: FilterQuality.high,
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: barImages.length,
        onDotClicked: animateToSlide,
        effect: ExpandingDotsEffect(
          activeDotColor: hisColors[activeIndex],
        ),
      );

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

  void previous() =>
      controller.nextPage(duration: const Duration(milliseconds: 500));

  void next() =>
      controller.previousPage(duration: const Duration(milliseconds: 500));
}
