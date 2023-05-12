import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../model/product_provider_model.dart';
import '../widgets/grid.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Explore",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 34
                      ),
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
                Text("Upcoming Products",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      fontSize: 18
                  ),
                ),
                gridItems()
              ],
            ),
          ),
        ),
      )
    );
  }
  Widget gridItems(){
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TopDealer>(
          builder: (context, value, child){
            return GridView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: value.arrivals.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: (1.0),

                ),
                itemBuilder: (context, index){
                  return ArrivalNew(
                      title: value.arrivals[index][0],
                      pic: value.arrivals[index][1]);
                }
            );
          },
        ),
      ),
    );
  }
}
