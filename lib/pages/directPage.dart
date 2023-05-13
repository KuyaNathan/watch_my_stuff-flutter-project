import 'package:flutter/material.dart';
import 'package:new_inventory_app/main.dart';
import 'package:new_inventory_app/pages/AddItemPage.dart';
import 'package:new_inventory_app/widgets/SideMenu.dart';
import 'package:new_inventory_app/pages/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_inventory_app/pages/HomePage.dart';

class DirectPage extends StatefulWidget {
  const DirectPage({super.key});
  @override
  State<DirectPage> createState() => _DirectPageState();
}

class _DirectPageState extends State<DirectPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot){
            if(snapshot.hasData) {
              return HomePage();
            } else {
              return LoginPage();
            }
          }
      ),
    );
  }
}