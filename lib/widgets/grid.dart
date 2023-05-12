import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GridItem extends StatelessWidget {
  final String itemName;
  final String itemPrice;
  final String itemImage;
  final String itemBrand;
  final String itemOverview;
  final Color color;
  final VoidCallback? onTap;
    const GridItem({Key? key,
    required this.itemName,
    required this.itemPrice,
    required this.itemBrand,
    required this.itemOverview,
    required this.itemImage,
     required this.onTap,
    required this.color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
        Future.delayed(const Duration(milliseconds: 5000));
        showModalBottomSheet(context: context,
            backgroundColor: color,
            useRootNavigator: true,
            isScrollControlled: true,
            elevation: 15,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)
            ),
            builder: (context){
              return  SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.95,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: color,
                    image:  DecorationImage(
                        image: AssetImage(itemImage),
                        fit: BoxFit.contain,
                        alignment: Alignment.topCenter
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 29,),
                        Row(
                          children: [
                            const SizedBox(width: 326,),
                            GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 30,
                                width: 80,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(13)
                                ),
                                child: const Text(
                                  "Close",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const SizedBox(height: 479,),
                            Container(
                              height: 387,
                              padding: const EdgeInsets.all(22),
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  boxShadow: [BoxShadow(
                                      blurRadius: 17,
                                      spreadRadius: 2,
                                      color: Colors.black
                                  )],
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(25),
                                      topRight: Radius.circular(25)
                                  ),
                                  color: Colors.white
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(itemName,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 29,
                                            fontWeight: FontWeight.bold
                                        ),),
                                    ],
                                  ),
                                  const SizedBox(height: 10,),
                                  Text("\$$itemPrice",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold
                                    ),),
                                  const SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      const Text("Brand: ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold
                                        ),),
                                      const SizedBox(width: 10,),
                                      Text(itemBrand,
                                        style: const TextStyle(
                                            color: Colors.red,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold
                                        ),),
                                    ],
                                  ),
                                  const SizedBox(height: 10,),
                                  const Text("Overview",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold
                                    ),),
                                  const SizedBox(height: 10,),
                                  Text(itemOverview,
                                    style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold
                                    ),),
                                  const SizedBox(height: 10,),
                                  const Text("Product Rating:",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold
                                    ),),
                                  const SizedBox(height: 10,),
                                  const Row(
                                    children: [
                                      Icon(Icons.star,
                                        color: Colors.orange,
                                        size: 27,),
                                      Icon(Icons.star,
                                        color: Colors.orange,
                                        size: 27,),
                                      Icon(Icons.star,
                                        color: Colors.orange,
                                        size: 27,),
                                      Icon(Icons.star,
                                        color: Colors.orange,
                                        size: 27,),
                                      Icon(Icons.star,
                                        color: Colors.orange,
                                        size: 27,),
                                    ],
                                  ),
                                  const SizedBox(height: 8,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("\$$itemPrice",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold
                                        ),),
                                      GestureDetector(
                                        onTap: (){ onTap!();
                                            showDialog(context: context,
                                                builder: (context){
                                                  return  AlertDialog(
                                                    title:  Text("Added to Cart!",
                                                        style: GoogleFonts.poppins(
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 19,
                                                        )),
                                                    content: Text("Added to Cart. Go "
                                                        "to Cart to continue.",
                                                        style: GoogleFonts.poppins(
                                                          color: Colors.black,
                                                          fontSize: 17,
                                                        )),
                                                    actions: [
                                                      TextButton(onPressed:
                                                          (){
                                                        Navigator.pop(context);
                                                      },
                                                          child: const Text("Close"))
                                                    ],
                                                  );
                                                });
                                        },
                                        child: Container(
                                            height: 40,
                                            width: 240,
                                            // padding: EdgeInsets.all(12),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(12),
                                                color: color
                                            ),
                                            child: Center(
                                                child:  Text("Add to Cart",
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 19
                                                  ),)
                                            )
                                        ),
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
          Stack(
              children: [Container(
                height: 220,
                width: 190,
                decoration: BoxDecoration(
                    color: Colors.deepOrange.shade50,
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(itemImage,
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
                    SizedBox(height: 49,width: 150,),
                    Icon(
                      Icons.shopping_cart,
                      size: 28,
                      color:  Colors.black,)
                  ],
                ),
              ]
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(itemName,
                    style: const TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                    ),),
                  Text("\$$itemPrice",
                    style:  TextStyle(
                        fontSize: 21,
                        color: Colors.deepOrange.shade700,
                        fontWeight: FontWeight.bold
                    ),),
                ],
              ),

            ],
          )
        ],
      ),
    );
  }

}

class ArrivalNew extends StatelessWidget {
  final String title;
  final String pic;
  const ArrivalNew({Key? key, required this.title, required this.pic, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[
        Container(
        margin: const EdgeInsets.all(5),
        height: 370,
        width: 370,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
              alignment: Alignment.center,
              image: AssetImage(pic)
          )
        ),
      ),
        Center(
          child: Text(title,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.white
          ),),
        )
      ]
    );
  }
}