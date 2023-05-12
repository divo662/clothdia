import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:store/model/user.dart';

// MODEL CLASS FOR ALL THE PRODUCTS ON SALE///////////////////////////
class TopDealer extends ChangeNotifier {
  //RECOMMENDED PRODUCTS LIST ITEMS//////////////////////////////////
  final List dealsItems = [
    [
      "Barella Gown(Blue)",
      "images2/dress5.png",
      "100.00",
      Colors.blue.shade600,
      "Barella Clothing line",
      "The blue dress is a stunning garment that "
          "exudes elegance and style. The rich blue color "
          "is eye-catching and makes a bold statement.",
    ],
    [
      "Gucci WristWatch",
      "images2/match5.png",
      "150.00",
      Colors.yellow.shade600,
      "Gucci Brand",
      "The Golden Gucci wristwatch is a stunning piece"
          "of luxury timekeeping designed for the fashion-"
          "conscious individuals who appreciates the finest"
          "things in life. Crafted from high-quality materials.",
    ],
    [
      "Agane Brown Trouser",
      "images2/men11.png",
      "60.00",
      Colors.brown.shade600,
      "Agane Brand",
      "The brown trouser is a versatile and classic"
          " piece of clothing that is both stylish and practical. "
          "The brown color is warm and earthy, making it a perfect"
          "choice for a variety of occasions and outfits.",
    ],
    [
      "Channel Red HandBag",
      "images/bag2.png",
      "130.00",
      Colors.red.shade600,
      "Channel Brand",
      "The Channel red handbag is a stunning "
          "accessory that exudes luxury and sophistication. "
          "Crafted from high quality leather, the bag features a "
          "rich deep red hue that is both bold and elegant.",
    ],
    [
      "Louise Black Suit",
      "images/men3.png",
      "100.00",
      Colors.black,
      "Louise Sandres",
      "The blue dress is a stunning garment that "
          "exudes elegance and style. The rich blue color "
          "is eye-catching and makes a bold statement.",
    ],
    [
      "Cinderella Dress",
      "images/dress8.png",
      "70.00",
      Colors.orange.shade600,
      "Adaeze Clothing Line",
      "The Golden Gucci wristwatch is a stunning piece"
          "of luxury timekeeping designed for the fashion-"
          "conscious individuals who appreciates the finest"
          "things in life. Crafted from high-quality materials.",
    ],
    [
      "Natola Shoe(brown)",
      "images2/shoe3.png",
      "100.00",
      Colors.brown.shade600,
      "Des de Natola",
      "The Golden Gucci wristwatch is a stunning piece"
          "of luxury timekeeping designed for the fashion-"
          "conscious individuals who appreciates the finest"
          "things in life. Crafted from high-quality materials.",
    ],
    [
      "Daze HighHeels",
      "images2/shoe11.png",
      "80.00",
      Colors.blue.shade600,
      "Daze shoe Brand",
      "The Golden Gucci wristwatch is a stunning piece"
          "of luxury timekeeping designed for the fashion-"
          "conscious individuals who appreciates the finest"
          "things in life. Crafted from high-quality materials.",
    ]
  ];

  // NEW ARRIVAL PRODUCTS LIST ITEMS////////////////////////////////
  final List arrivals = [
    ["Nike GreyTrack Suit", "images2/menc2.jpg"],
    ["Nike Air Jordan DF43", "images2/nike4.jpg"],
    ["Beeze T-Shirt", "images2/shirt1.jpeg"],
    ["Vuitton Suit", "images2/suit3.jpg"],
    ["Vuitton Pink Queen Gown", "images2/wd1.jpeg"],
    ["Tag Black Galaxy WristWatch", "images2/watchda.jpeg"],
    ["Beast Boot", "images2/ws3.jpg"],
    ["dazel Carmel High heels", "images2/ws5.jpg"]
  ];

  // MEN PRODUCTS LIST///////////////////////////////////////////////////////
  final List menShirt = [
    [
      "Markwell packet"
          " Shirt",
      "images2/s3.png",
      "30.00",
      Colors.blue.shade600,
      "Markwell Designs",
    ],
    ////////////////////////////////////////////////////////////
    [
      "Aloe T-shirt",
      "images2/s12.png",
      "50.00",
      Colors.yellow.shade600,
      "Aloe Brand",
    ],
    /////////////////////////////////////////////////////////////////////
    [
      "Agane Packet Shirt",
      "images2/s4.png",
      "60.00",
      Colors.brown.shade600,
      "Agane Brand",
    ],
    ///////////////////////////////////////////////////////////////////////
    [
      "Tommy Dan Shirt",
      "images2/s11.png",
      "85.00",
      Colors.red.shade600,
      "Tommy Dan",
    ],
    ////////////////////////////////////////////////////////////////////////
    [
      "Louise Shirt",
      "images2/s5.png",
      "90.00",
      Colors.black,
      "Louise Sandres",
    ],
    ////////////////////////////////////////////////////////////////////
    [
      "Benson Normer Shirt",
      "images2/s8.png",
      "70.00",
      Colors.orange.shade600,
      "Benson Clothing Line",
    ],
    /////////////////////////////////////////////////////////////////////////
    [
      "Natola T-shirt",
      "images2/s6.png",
      "50.00",
      Colors.brown.shade600,
      "Des de Natola",
    ],
    ///////////////////////////////////////////////////////////////////////
    [
      "Mechulla shirt",
      "images2/s7.png",
      "80.00",
      Colors.blue.shade600,
      "Mechulla Brand",
    ],
  ];
  final List menTrouser = [
    [
      "Arrow blue Chinos",
      "images2/t1.png",
      "70.00",
      Colors.blue.shade600,
      "Arrow Clothing line",
    ],
    ////////////////////////////////////////////////////////////
    [
      "Blackberry Chinos",
      "images2/t2.png",
      "40.00",
      Colors.yellow.shade600,
      "Blackberry Brand",
    ],
    /////////////////////////////////////////////////////////////////////
    [
      "Agane Chinos",
      "images2/t5.png",
      "60.00",
      Colors.brown.shade600,
      "Agane Brand",
    ],
    ///////////////////////////////////////////////////////////////////////
    [
      "Allen Sony Chinos",
      "images2/t6.png",
      "70.00",
      Colors.red.shade600,
      "Allen Sony",
    ],
    ////////////////////////////////////////////////////////////////////////
    [
      "van Don cargo Pants",
      "images2/t7.png",
      "100.00",
      Colors.black,
      "Van Don",
    ],
    ////////////////////////////////////////////////////////////////////
    [
      "van Don cargo Pants",
      "images2/t8.png",
      "70.00",
      Colors.orange.shade600,
      "Van Brand",
    ],
    /////////////////////////////////////////////////////////////////////////
    [
      "Agane Brown Trouser",
      "images2/men11.png",
      "60.00",
      Colors.brown.shade600,
      "Agane Brand",
    ],
    ///////////////////////////////////////////////////////////////////////
    [
      "J&J Cargo Pants",
      "images/men9.png",
      "80.00",
      Colors.blue.shade600,
      "Jack & Jones Brand",
    ],
  ];
  final List menUnderwear = [
    [
      "Green Men Singlet",
      "images2/ud2.png",
      "20.00",
      Colors.blue.shade600,
      "Barella Clothing line",
    ],
    ////////////////////////////////////////////////////////////
    [
      "Blue Men Singlet",
      "images2/ud3.png",
      "20.00",
      Colors.yellow.shade600,
      "Barella Clothing line",
    ],
    /////////////////////////////////////////////////////////////////////
    [
      "Agane Men Singlet",
      "images2/ud5.webp",
      "40.00",
      Colors.brown.shade600,
      "Agane Brand",
    ],
    ///////////////////////////////////////////////////////////////////////
    [
      "Yellow Men Singlet",
      "images2/ud4.png",
      "20.00",
      Colors.red.shade600,
      "Barella Clothing line",
    ],
    ////////////////////////////////////////////////////////////////////////
    [
      "Blue Strip Men Boxer",
      "images2/ud7.webp",
      "20.00",
      Colors.black,
      "Barella Clothing line",
    ],
    ////////////////////////////////////////////////////////////////////
    [
      "Handy Men Boxer",
      "images2/ud8.png",
      "20.00",
      Colors.orange.shade600,
      "Handy Clothing Line",
    ],
    /////////////////////////////////////////////////////////////////////////
    [
      "Camouflage Men Boxer",
      "images2/ud9.png",
      "30.00",
      Colors.brown.shade600,
      "Handy Clothing line",
    ],
    ///////////////////////////////////////////////////////////////////////
    [
      "Grey Men Boxers",
      "images2/ud11.webp",
      "80.00",
      Colors.blue.shade600,
      "Barella Clothing line",
    ],
  ];

  // WOMEN PRODUCTS LIST/////////////////////////////////////////////////////
  final List womenShirt = [
    [
      "Markwell Shirt",
      "images2/w3.png",
      "30.00",
      Colors.blue.shade600,
      "Markwell Designs",
    ],
    ////////////////////////////////////////////////////////////
    [
      "Gency Blouse",
      "images2/w12.png",
      "50.00",
      Colors.yellow.shade600,
      "Gency Brand",
    ],
    /////////////////////////////////////////////////////////////////////
    [
      "Agane pink Shirt",
      "images2/w5.png",
      "60.00",
      Colors.brown.shade600,
      "Agane Brand",
    ],
    ///////////////////////////////////////////////////////////////////////
    [
      "Dazel Shirt",
      "images2/w4.png",
      "55.00",
      Colors.red.shade600,
      "Dazel Clothing line",
    ],
    ////////////////////////////////////////////////////////////////////////
    [
      "Louise pink Shirt",
      "images2/w6.png",
      "60.00",
      Colors.black,
      "Louise Sandres",
    ],
    ////////////////////////////////////////////////////////////////////
    [
      "Gency Blouse",
      "images2/w7.png",
      "50.00",
      Colors.orange.shade600,
      "Gency Brand",
    ],
    /////////////////////////////////////////////////////////////////////////
    [
      "Gency Blouse",
      "images2/w9.png",
      "50.00",
      Colors.brown.shade600,
      "Gency Brand",
    ],
    ///////////////////////////////////////////////////////////////////////
    [
      "Gency Blouse",
      "images2/w11.png",
      "50.00",
      Colors.blue.shade600,
      "Gency Brand",
    ],
  ];
  final List womenSkirt = [
    [
      "Vuitton skirt",
      "images2/skirt10.png",
      "70.00",
      Colors.blue.shade600,
      "vuitton brand",
    ],
    ////////////////////////////////////////////////////////////
    [
      "purple Royal skirt",
      "images2/skirt9.png",
      "80.00",
      Colors.yellow.shade600,
      "Blackberry Brand",
    ],
    /////////////////////////////////////////////////////////////////////
    [
      "Agane pink skirt",
      "images2/skirt7.png",
      "70.00",
      Colors.brown.shade600,
      "Agane Brand",
    ],
    ///////////////////////////////////////////////////////////////////////
    [
      "Yellow check Skirt",
      "images2/skirt4.png",
      "80.00",
      Colors.red.shade600,
      "Agane Brand",
    ],
    ////////////////////////////////////////////////////////////////////////
    [
      "Dazel Complete Outfit",
      "images2/skirt3.png",
      "80.00",
      Colors.black,
      "Dazel Clothing line",
    ],
    ////////////////////////////////////////////////////////////////////
    [
      "Dazel black skirt",
      "images2/skirt2.png",
      "70.00",
      Colors.orange.shade600,
      "Dazel Clothing Line",
    ],
    /////////////////////////////////////////////////////////////////////////
  ];
  final List womenTrouser = [
    [
      "Check Trouser",
      "images2/pant6.png",
      "70.00",
      Colors.blue.shade600,
      "Barella Clothing line",
    ],
    ////////////////////////////////////////////////////////////
    [
      "Leather Black Trouser",
      "images2/pant2.png",
      "80.00",
      Colors.yellow.shade600,
      "Barella Clothing line",
    ],
    /////////////////////////////////////////////////////////////////////
    [
      "Lemon Cotton Trouser",
      "images2/pant9.png",
      "80.00",
      Colors.brown.shade600,
      "Agane Brand",
    ],
    ///////////////////////////////////////////////////////////////////////
    [
      "Jeans Trouser",
      "images2/pant3.png",
      "90.00",
      Colors.red.shade600,
      "Barella Clothing line",
    ],
    ////////////////////////////////////////////////////////////////////////
    [
      "Corporate Trouser",
      "images2/pant8.png",
      "70.00",
      Colors.black,
      "Barella Clothing line",
    ],
    ////////////////////////////////////////////////////////////////////
    [
      "Jeans Trouser",
      "images2/pant4.png",
      "80.00",
      Colors.orange.shade600,
      "Handy Clothing Line",
    ],
    /////////////////////////////////////////////////////////////////////////
    [
      "Queen Jeans Trouser",
      "images2/pant7.png",
      "100.00",
      Colors.brown.shade600,
      "Handy Clothing line",
    ],
    ///////////////////////////////////////////////////////////////////////
    [
      "Jean Trouser",
      "images2/pant5.png",
      "80.00",
      Colors.blue.shade600,
      "Barella Clothing line",
    ],
  ];
  final List womenGown = [
    [
      "Netted Black Royal Gown",
      "images2/gown10.png",
      "170.00",
      Colors.blue.shade600,
      "Arrow Clothing line",
    ],
    ////////////////////////////////////////////////////////////
    [
      "Purple Royal Gown",
      "images2/gown7.png",
      "200.00",
      Colors.yellow.shade600,
      "Blackberry Brand",
    ],
    /////////////////////////////////////////////////////////////////////
    [
      "Agane Bell Gown",
      "images2/gown8.png",
      "120.00",
      Colors.brown.shade600,
      "Agane Brand",
    ],
    ///////////////////////////////////////////////////////////////////////
    [
      "Diamond Red Gown",
      "images2/gown1.png",
      "170.00",
      Colors.red.shade600,
      "Allen Sony",
    ],
    ////////////////////////////////////////////////////////////////////////
    [
      "Golden Red Queen Gown",
      "images2/gown.png",
      "220.00",
      Colors.black,
      "Dazel Clothing Line",
    ],
    ////////////////////////////////////////////////////////////////////
    [
      "Queen Bell Royal Gown",
      "images2/gown11.png",
      "250.00",
      Colors.orange.shade600,
      "Dazel Clothing Line",
    ],
    /////////////////////////////////////////////////////////////////////////
  ];
  final List womenUnder = [
    [
      "Pink Sport Bra",
      "images2/bra1.png",
      "30.00",
      Colors.blue.shade600,
      "Barella Clothing line",
    ],
    ////////////////////////////////////////////////////////////
    [
      "Purple Sport Bra",
      "images2/bra2.png",
      "30.00",
      Colors.yellow.shade600,
      "Barella Clothing line",
    ],
    /////////////////////////////////////////////////////////////////////
    [
      "Black Flower Bra",
      "images2/bra3.png",
      "40.00",
      Colors.brown.shade600,
      "Agane Brand",
    ],
    ///////////////////////////////////////////////////////////////////////
    [
      "Pink Bra",
      "images2/bra4.png",
      "30.00",
      Colors.red.shade600,
      "Barella Clothing line",
    ],
    ////////////////////////////////////////////////////////////////////////
    [
      "Black Flower Bra",
      "images2/bra5.png",
      "40.00",
      Colors.black,
      "Barella Clothing line",
    ],
    ////////////////////////////////////////////////////////////////////
    [
      "Pink Flower Bra",
      "images2/bra6.png",
      "40.00",
      Colors.orange.shade600,
      "Handy Clothing Line",
    ],
  ];

  // KIDS PRODUCTS LIST/////////////////////////////////////////////////////////
  final List maleWear = [
    [
      "Brown Joggers"
          " Shirt",
      "images2/male7.png",
      "60.00",
      Colors.blue.shade600,
      "Markwell Designs",
    ],
    ////////////////////////////////////////////////////////////
    [
      "Check Trouser",
      "images2/male6.png",
      "70.00",
      Colors.yellow.shade600,
      "Aloe Brand",
    ],
    /////////////////////////////////////////////////////////////////////
    [
      "wild Long sleeve Shirt",
      "images2/male4.png",
      "60.00",
      Colors.brown.shade600,
      "Agane Brand",
    ],
    ///////////////////////////////////////////////////////////////////////
    [
      "Tommy Check Shirt",
      "images2/male3.png",
      "65.00",
      Colors.red.shade600,
      "Tommy Dan",
    ],
    ////////////////////////////////////////////////////////////////////////
    [
      "Louise Purple Shirt",
      "images2/male2.png",
      "60.00",
      Colors.black,
      "Louise Sandres",
    ],
    ////////////////////////////////////////////////////////////////////
    [
      "Benson Shirt",
      "images2/male1.png",
      "60.00",
      Colors.orange.shade600,
      "Benson Clothing Line",
    ],
    /////////////////////////////////////////////////////////////////////////
  ];
  final List femaleWear = [
    [
      "Pink Joggers",
      "images2/female1.png",
      "60.00",
      Colors.blue.shade600,
      "Arrow Clothing line",
    ],
    ////////////////////////////////////////////////////////////
    [
      "Handy Joggers",
      "images2/female2.png",
      "60.00",
      Colors.yellow.shade600,
      "Handy Clothing Line",
    ],
    /////////////////////////////////////////////////////////////////////
    [
      "Angel Dress",
      "images2/kid1.png",
      "90.00",
      Colors.brown.shade600,
      "Barella Clothing line",
    ],
    ///////////////////////////////////////////////////////////////////////
    [
      "Barry Dress",
      "images2/kid2.png",
      "60.00",
      Colors.red.shade600,
      "Barella Clothing line",
    ],
    ////////////////////////////////////////////////////////////////////////
    [
      "Elly Joggers",
      "images2/female4.png",
      "50.00",
      Colors.black,
      "Barella Clothing line",
    ],
    ////////////////////////////////////////////////////////////////////
    [
      "vanitage Jeans Skirt",
      "images2/female6.png",
      "70.00",
      Colors.orange.shade600,
      "Vanitage Brand",
    ],
    /////////////////////////////////////////////////////////////////////////
  ];

  //GLasses PRODUCTS LIST//////////////////////////////////////////////////////
  final List maleGlass = [
    [
      "Prada black jack",
      "images2/mglass6.png",
      "100.00",
      Colors.blue.shade600,
      "Prada Brand",
    ],
    ////////////////////////////////////////////////////////////
    [
      "Oakley Classic",
      "images2/mglass4.png",
      "70.00",
      Colors.yellow.shade600,
      "Oakley Brand",
    ],
    /////////////////////////////////////////////////////////////////////
    [
      "D&G Ray Classic",
      "images2/mglass5.png",
      "120.00",
      Colors.brown.shade600,
      "Dolce & Gabbana Brand",
    ],
    ///////////////////////////////////////////////////////////////////////
    [
      "Moscot Ray-Band",
      "images2/mglass3.png",
      "85.00",
      Colors.red.shade600,
      "Moscot Brand",
    ],
    ////////////////////////////////////////////////////////////////////////
    [
      "Warby Classic",
      "images2/mglass2.png",
      "90.00",
      Colors.black,
      "Warby Parker Brand",
    ],
    ////////////////////////////////////////////////////////////////////
    [
      "Saint Laurent Ray",
      "images2/mglass1.png",
      "100.00",
      Colors.orange.shade600,
      "Saint Laurent Brand",
    ],
    /////////////////////////////////////////////////////////////////////////
  ];
  final List femaleGlass = [
    [
      "Saint Laurent Bella",
      "images2/wglass11.png",
      "90.00",
      Colors.blue.shade600,
      "Saint Laurent Brand",
    ],
    ////////////////////////////////////////////////////////////
    [
      "D&G Carrera",
      "images2/wglass10.png",
      "80.00",
      Colors.yellow.shade600,
      "Dolce & Gabbana Brand",
    ],
    /////////////////////////////////////////////////////////////////////
    [
      "Oakley Bella A34",
      "images2/wglass9.png",
      "90.00",
      Colors.brown.shade600,
      "Oakley Brand",
    ],
    ///////////////////////////////////////////////////////////////////////
    [
      "Moscot Dami",
      "images2/wglass8.png",
      "60.00",
      Colors.red.shade600,
      "Moscot Brand",
    ],
    ////////////////////////////////////////////////////////////////////////
    [
      "Oakley Bella BG4",
      "images2/wglass7.png",
      "100.00",
      Colors.black,
      "Oakley Brand",
    ],
    ////////////////////////////////////////////////////////////////////
    [
      "Oakley Bella C56",
      "images2/wglass5.png",
      "70.00",
      Colors.orange.shade600,
      "Oakley Brand",
    ],
    /////////////////////////////////////////////////////////////////////////
  ];

  // HANDBAG PRODUCTS LIST/////////////////////////////////////////////////////
  final List handBag = [
    [
      "Prada black Bag",
      "images/handy13.png",
      "100.00",
      Colors.blue.shade600,
      "Prada Brand",
    ],
    ////////////////////////////////////////////////////////////
    [
      "Oakley Classic Bag",
      "images/handy12.png",
      "70.00",
      Colors.yellow.shade600,
      "Oakley Brand",
    ],
    /////////////////////////////////////////////////////////////////////
    [
      "D&G Ray Classic Bag",
      "images/handy11.png",
      "120.00",
      Colors.brown.shade600,
      "Dolce & Gabbana Brand",
    ],
    ///////////////////////////////////////////////////////////////////////
    [
      "Moscot Ray-Band Bag",
      "images/handy10.png",
      "85.00",
      Colors.red.shade600,
      "Moscot Brand",
    ],
    ////////////////////////////////////////////////////////////////////////
    [
      "Warby Classic Bag",
      "images/handy9.png",
      "90.00",
      Colors.black,
      "Warby Parker Brand",
    ],
    ////////////////////////////////////////////////////////////////////
    [
      "Saint Laurent Ray Bag",
      "images/handy8.png",
      "100.00",
      Colors.orange.shade600,
      "Saint Laurent Brand",
    ],
    /////////////////////////////////////////////////////////////////////////
  ];

  // WATCHES PRODUCTS LIST////////////////////////////////////////////////////
  final List watchMale = [
    [
      "Prada black Watch",
      "images/watch2.png",
      "100.00",
      Colors.blue.shade600,
      "Prada Brand",
    ],
    ////////////////////////////////////////////////////////////
    [
      "Oakley Classic Watch",
      "images/watch3.png",
      "120.00",
      Colors.yellow.shade600,
      "Oakley Brand",
    ],
    /////////////////////////////////////////////////////////////////////
    [
      "D&G Ray Classic Watch",
      "images/watch 4.png",
      "140.00",
      Colors.brown.shade600,
      "Dolce & Gabbana Brand",
    ],
    ///////////////////////////////////////////////////////////////////////
    [
      "Moscot Ray-Band Watch",
      "images/watch 5.png",
      "185.00",
      Colors.red.shade600,
      "Moscot Brand",
    ],
    ////////////////////////////////////////////////////////////////////////
  ];
  final List watchFemale = [
    [
      "Saint Laurent Watch",
      "images/match1.png",
      "90.00",
      Colors.blue.shade600,
      "Saint Laurent Brand",
    ],
    ////////////////////////////////////////////////////////////
    [
      "D&G Carrera Watch",
      "images/match2.png",
      "140.00",
      Colors.yellow.shade600,
      "Dolce & Gabbana Brand",
    ],
    /////////////////////////////////////////////////////////////////////
    [
      "Oakley Diamond Watch",
      "images/match3.png",
      "200.00",
      Colors.brown.shade600,
      "Oakley Brand",
    ],
    ///////////////////////////////////////////////////////////////////////
    [
      "Moscot Dami Watch",
      "images/match6.png",
      "160.00",
      Colors.red.shade600,
      "Moscot Brand",
    ],
    ////////////////////////////////////////////////////////////////////////
  ];

  // FACE CAP PRODUCTS LIST///////////////////////////////////////////////////
  final List faceMale = [
    [
      "Adidas Face Cap",
      "images/cap11.png",
      "30.00",
      Colors.blue.shade600,
      "Adidas Brand",
    ],
    ////////////////////////////////////////////////////////////
    [
      "LRG Face Cap",
      "images/cap10.png",
      "50.00",
      Colors.yellow.shade600,
      "LRG Brand",
    ],
    /////////////////////////////////////////////////////////////////////
    [
      "Blue Face Cap",
      "images/cap9.png",
      "20.00",
      Colors.brown.shade600,
      "Adidas Brand",
    ],
    ///////////////////////////////////////////////////////////////////////
    [
      "Fierce Hat",
      "images/cap7.png",
      "185.00",
      Colors.red.shade600,
      "Fierce Brand",
    ],
    ////////////////////////////////////////////////////////////////////////
  ];
  final List faceFemale = [
    [
      "S&G Head Warmer",
      "images/wc6.png",
      "90.00",
      Colors.blue.shade600,
      "Saint Laurent Brand",
    ],
    ////////////////////////////////////////////////////////////
    [
      " Carrera Hat",
      "images/wc5.png",
      "140.00",
      Colors.yellow.shade600,
      "Dolce & Gabbana Brand",
    ],
    /////////////////////////////////////////////////////////////////////
    [
      "Oakley Cap",
      "images/wc4.webp",
      "200.00",
      Colors.brown.shade600,
      "Oakley Brand",
    ],
    ///////////////////////////////////////////////////////////////////////
    [
      "Moscot Sun Shade",
      "images/wc3.png",
      "160.00",
      Colors.red.shade600,
      "Moscot Brand",
    ],
    ////////////////////////////////////////////////////////////////////////
  ];

  //SHOE PRODUCTS LIST////////////////////////////////////////////////////////
  final List shoeMale = [
    [
      "Agane Brown Shoe",
      "images2/shoe3.png",
      "130.00",
      Colors.blue.shade600,
      "Agane Brand",
    ],
    ////////////////////////////////////////////////////////////
    [
      "LRG Brown Shoe",
      "images/shoe2.png",
      "100.00",
      Colors.yellow.shade600,
      "LRG Brand",
    ],
    /////////////////////////////////////////////////////////////////////
    [
      "Agane D45",
      "images2/shoe1.png",
      "70.00",
      Colors.brown.shade600,
      "Agane Brand",
    ],
    ///////////////////////////////////////////////////////////////////////
    [
      "Fierce Shoe",
      "images2/shoe5.png",
      "120.00",
      Colors.red.shade600,
      "Fierce Brand",
    ],
    ////////////////////////////////////////////////////////////////////////
  ];
  final List shoeFemale = [
    [
      "Black High-heels",
      "images2/shoe10.png",
      "90.00",
      Colors.blue.shade600,
      "Agane Brand",
    ],
    ////////////////////////////////////////////////////////////
    [
      "Blue High-heels",
      "images/shoe11.png",
      "100.00",
      Colors.yellow.shade600,
      "Agane Brand",
    ],
    /////////////////////////////////////////////////////////////////////
    [
      "Yellow High-heels",
      "images2/wshoe10.png",
      "80.00",
      Colors.brown.shade600,
      "Agane Brand",
    ],
    ///////////////////////////////////////////////////////////////////////
    [
      "Brown High-heels",
      "images2/wshoe9.png",
      "160.00",
      Colors.red.shade600,
      "Agane Brand",
    ],
    ////////////////////////////////////////////////////////////////////////
  ];
  final List nike = [
    [
      "Nike Black Force D34",
      "images2/mshoe5.png",
      "100.00",
      Colors.blue.shade600,
      "Nike Collection",
    ],
    ////////////////////////////////////////////////////////////
    [
      "Blue Men Singlet",
      "images2/wshoe2.webp",
      "120.00",
      Colors.yellow.shade600,
      "Nike Collection",
    ],
    /////////////////////////////////////////////////////////////////////
    [
      "Nike Force T54",
      "images2/wshoe1.webp",
      "140.00",
      Colors.brown.shade600,
      "Nike Collection",
    ],
    ///////////////////////////////////////////////////////////////////////
    [
      "Nike All Star m45",
      "images2/wshoe3.png",
      "120.00",
      Colors.red.shade600,
      "Nike Collection",
    ],
    ////////////////////////////////////////////////////////////////////////
  ];

  // GET LIST PRODUCTS////////////////////////////////////////////////////
  get newItems => arrivals;

  get shopItem => dealsItems;

  ///////////////////////////////////////
  final List _cartItems = [];

////////////////////////////////////////////////////////////////////
  get cartItems => _cartItems;

//ADD RECOMMENDED PRODUCTS TO CART///////////////////////////////////////////////////////////////////
  void addItemToCart(int index) {
    _cartItems.add(dealsItems[index]);
    notifyListeners();
  }

  //MEN PRODUCTS ADD TO CART//////////////////////////////////////////////////
  void addShirtToCart(int index) {
    _cartItems.add(menShirt[index]);
    notifyListeners();
  }

  void addTrouserToCart(int index) {
    _cartItems.add(menTrouser[index]);
    notifyListeners();
  }

  void addMenUnderwearToCart(int index) {
    _cartItems.add(menUnderwear[index]);
    notifyListeners();
  }

  // WOMEN PRODUCTS ADD TO CART////////////////////////////////////////////
  void addWomenShirtToCart(int index) {
    _cartItems.add(womenShirt[index]);
    notifyListeners();
  }

  void addWomenSkirtToCart(int index) {
    _cartItems.add(womenSkirt[index]);
    notifyListeners();
  }

  void addWomenTrouserToCart(int index) {
    _cartItems.add(womenTrouser[index]);
    notifyListeners();
  }

  void addWomenGownToCart(int index) {
    _cartItems.add(womenGown[index]);
    notifyListeners();
  }

  void addWomenUnderToCart(int index) {
    _cartItems.add(womenUnder[index]);
    notifyListeners();
  }

  //KID PRODUCTS ADD TO CART///////////////////////////////////////////////
  void addMaleKidToCart(int index) {
    _cartItems.add(maleWear[index]);
    notifyListeners();
  }

  void addFemaleKidToCart(int index) {
    _cartItems.add(femaleWear[index]);
    notifyListeners();
  }

  //GLASS PRODUCTS ADD TO CART/////////////////////////////////////////////
  void addMaleGlassToCart(int index) {
    _cartItems.add(maleGlass[index]);
    notifyListeners();
  }

  void addFemaleGlassToCart(int index) {
    _cartItems.add(femaleGlass[index]);
    notifyListeners();
  }

  //HANDBAG PRODUCTS ADD TO CART////////////////////////////////////////////
  void addHandbagToCart(int index) {
    _cartItems.add(handBag[index]);
    notifyListeners();
  }

  // WATCH PRODUCTS ADD TO LIST//////////////////////////////////////////
  void addMaleWatchToCart(int index) {
    _cartItems.add(watchMale[index]);
    notifyListeners();
  }

  void addFemaleWatchToCart(int index) {
    _cartItems.add(watchFemale[index]);
    notifyListeners();
  }

  //FACE CAP PRODUCTS ADD TO LIST//////////////////////////////////////////
  void addMaleFaceToCart(int index) {
    _cartItems.add(faceMale[index]);
    notifyListeners();
  }

  void addFemaleFaceToCart(int index) {
    _cartItems.add(faceFemale[index]);
    notifyListeners();
  }

  //SHOE PRODUCTS ADD TO LIST////////////////////////////////////////////
  void addShoeMaleToCart(int index) {
    _cartItems.add(shoeMale[index]);
    notifyListeners();
  }

  void addShoeFemaleToCart(int index) {
    _cartItems.add(shoeFemale[index]);
    notifyListeners();
  }

  void addNikeToCart(int index) {
    _cartItems.add(shoeFemale[index]);
    notifyListeners();
  }

//REMOVE ITEMS FROM CART///////////////////////////////////////////////////
  void removeItemFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

//ADD TOTAL PRICE OF CART ITEMS LIST/////////////////////////////////////////
  String calculateTotalItem() {
    double totalPrice = 0;
    for (int i = 0; i < _cartItems.length; i++) {
      totalPrice += double.parse(_cartItems[i][2]);
    }
    return totalPrice.toStringAsFixed(1);
  }

  // ADD DELIVERY FEE AND TOTAL PRICE OF CART ITEMS LIST///////////////////
  double totalItem() {
    double price = 150;
    return price += double.parse(calculateTotalItem());
  }

// SEARCH HOME PRODUCTS FUNCTIONALITY/////////////////////////////////
  late List<dynamic> results = dealsItems;
  List<String> recentlySearchedItems = [];
  List<dynamic> searchResult = [];

  void runFilter(String enteredKeyword) {
    if (enteredKeyword.isEmpty) {
      searchResult = [];
    } else {
      searchResult = dealsItems
          .where((title) =>
              title[0].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    if (!recentlySearchedItems.contains(enteredKeyword)) {
      recentlySearchedItems.add(enteredKeyword);
    }
    notifyListeners();
  }

//ADD ADDRESS TO PAYMENT PAGE
  String _phoneNumber = '';
  String _homeAddress = '';
  String _state = '';

  String get phoneNumber => _phoneNumber;

  String get homeAddress => _homeAddress;

  String get state => _state;
  bool _showUserInfo = false;

  get yesValue => _showUserInfo;

//function to add the address details
  void addUserInfo(String phoneNumber, String homeAddress, String state) {
    _phoneNumber = phoneNumber;
    _homeAddress = homeAddress;
    _state = state;
    _showUserInfo = true;
    notifyListeners();
  }

  //Show the container that displays the address of the user
  bool _isChecked = false;

  void toggleUserInfo() {
    _showUserInfo = !_showUserInfo;
    notifyListeners();
  }

  Widget buildUserInfoWidget() {
    if (_showUserInfo) {
      // Only show the widget if _showUserInfo is true
      return Center(
        child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              width: 380,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                  color: _isChecked ? Colors.deepOrange.shade100 : Colors.white,
                  border: Border(
                    top: BorderSide(
                        color: _isChecked
                            ? Colors.deepOrange.shade100
                            : Colors.white,
                        width: 0.44),
                    left: BorderSide(
                        color: _isChecked
                            ? Colors.deepOrange.shade100
                            : Colors.white,
                        width: 0.44),
                    right: BorderSide(
                        color: _isChecked
                            ? Colors.deepOrange.shade100
                            : Colors.white,
                        width: 0.44),
                    bottom: BorderSide(
                        color: _isChecked
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
                        'Home',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange.shade300),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _isChecked = !_isChecked;
                            });
                          },
                          icon: _isChecked
                              ? Icon(
                                  Icons.check_box,
                                  color: Colors.deepOrange.shade300,
                                )
                              : const Icon(Icons.check_box_outline_blank_sharp))
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Full Name: ${loggedInUser.firstName ?? ""} ${loggedInUser.secondName ?? ""}',
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Phone Number:$_phoneNumber',
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'Home Address: $_homeAddress',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'State: $_state',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade600),
                  ),
                ],
              ),
            );
          },
        ),
      );
    } else {
      return Center(
        child: Text(
          'No delivery address',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600),
        ),
      ); // Return an empty container if _showUserInfo is false
    }
  }

  //fetches the user first name and second name and displays on the address container
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  TopDealer() {
    fetchAndSetLoggedInUser();
  }
  void fetchAndSetLoggedInUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> userData = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(user.uid)
          .get();
      loggedInUser = UserModel.fromMap(userData.data()!);
      _phoneNumber = userData.data()!['phone_number'] ?? "";
      _homeAddress = userData.data()!['home_address'] ?? "";
      _state = userData.data()!['state'] ?? "";
    }
  }

  // the check box function for the pick up check box option
  bool _isCheck = false;
  bool get isChecking => _isCheck;
  set checkBox(bool value) {
    _isCheck = value;
    notifyListeners();
  }

  //the check box function for the pay on delivery  function
  bool _isCheck1 = false;
  bool get isChecking1 => _isCheck1;
  set checkBox1(bool value) {
    _isCheck1 = value;
    notifyListeners();
  }

  //the check box function for the self pick up function
  bool _isCheck2 = false;
  bool get isChecking2 => _isCheck2;
  set checkBox2(bool value) {
    _isCheck2 = value;
    notifyListeners();
  }


  final List<MyTransaction> _transactions = [];
  List<MyTransaction> get transactions => _transactions;

  // Function to generate transactions after successful payment
  void generateTransactions(int index) {
    if (_cartItems.isNotEmpty) {
      // Generate a reference number for the transaction
      String refNumber = generateRefNumber();

      // Create a new transaction
      MyTransaction transaction = MyTransaction(
        refNumber: refNumber,
        nameItem: _cartItems.map((item) => item[0].toString()).toList(),
        amountSpent: totalItem(),
        numberOfItems: _cartItems.length,
        isSuccessful: true,
        dateTime: DateTime.now(),
      );

      // Add the transaction to the list of transactions
      _transactions.add(transaction);

      // Clear the cart items
      _cartItems.clear();

      // Notify listeners of the changes
      notifyListeners();
    }
  }

  void addTransaction(MyTransaction transaction) {
    _transactions.add(transaction);
    notifyListeners();
  }

  String generateRefNumber() {
    // Generate a random 12-digit alphanumeric reference number
    String chars = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    Random random = Random();
    String refNumber = '';

    for (int i = 0; i < 12; i++) {
      refNumber += chars[random.nextInt(chars.length)];
    }

    return refNumber;
  }

// List<Product> _cartItems = [];
}

class MyTransaction {
  String refNumber;
  List<String> nameItem;
  double amountSpent;
  int numberOfItems;
  bool isSuccessful;
  DateTime dateTime;

  MyTransaction(
      {required this.refNumber,
      required this.nameItem,
      required this.amountSpent,
      required this.numberOfItems,
      required this.isSuccessful,
      required this.dateTime});
}
