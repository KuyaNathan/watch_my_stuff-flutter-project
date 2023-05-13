import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_inventory_app/pages/HomePage.dart';
import 'package:new_inventory_app/firebase_options.dart';
import 'package:new_inventory_app/pages/SignUpPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_inventory_app/pages/loginPage.dart';
import 'package:new_inventory_app/pages/directPage.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  MaterialColor buildMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for(int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r: (255-r)) * ds).round(),
        g + ((ds < 0 ? g: (255-g)) * ds).round(),
        b + ((ds < 0 ? b: (255-b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(

        primarySwatch: buildMaterialColor(Color(0xff046a38)),
        scaffoldBackgroundColor: const Color.fromRGBO(240, 226, 182, 50),
      ),
      home: const DirectPage(),
    );
  }
}


