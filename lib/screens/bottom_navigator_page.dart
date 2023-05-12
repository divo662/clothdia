import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:store/model/product_provider_model.dart';
import 'package:store/screens/cart.dart';
import 'package:store/screens/explore_item_page.dart';
import 'package:store/screens/home_page.dart';
import 'package:store/screens/settings_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int pageIndex = 0;

  final List<Widget> page = [
    const HomePage(),
    const ExplorePage(),
    const CartPage(),
    const PersonPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<TopDealer>(
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: page[pageIndex],
          bottomNavigationBar: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: GNav(
                gap: 9,
                onTabChange: (index) {
                  setState(() {
                    pageIndex = index;
                  });
                },
                selectedIndex: pageIndex,
                activeColor: Colors.black,
                iconSize: 32,
                tabBackgroundColor: Colors.orange.shade100,
                padding: const EdgeInsets.all(13),
                tabs: [
                  const GButton(
                    icon: Icons.home,
                    text: "Home",
                  ),
                  const GButton(
                    icon: Icons.favorite,
                    text: "Explore",
                  ),
                  GButton(
                    icon: Icons.shopping_cart,
                    text: "Cart",
                    leading: Badge(
                      label: Text(value.cartItems.length.toString()),
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                      child: const Icon(Icons.shopping_cart),
                    ),
                  ),
                  const GButton(
                    icon: Icons.person,
                    text: "Accounts",
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
