import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/screens/bottom_navigator_page.dart';
import 'package:store/screens/splash_screen.dart';

import 'model/product_provider_model.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TopDealer(),
      child:  MaterialApp(
          title: 'Clothdia',
          debugShowCheckedModeBanner: false,
          home: Navigator(
            onGenerateRoute: (routeSettings) {
              return MaterialPageRoute(
                builder: (context) => const SplashScreen(),
                settings: routeSettings,
              );
            },
          ),
      ),
    );

  }
}
