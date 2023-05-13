import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_inventory_app/main.dart';
import 'package:new_inventory_app/pages/AddItemPage.dart';
import 'package:new_inventory_app/widgets/SideMenu.dart';
import 'package:new_inventory_app/pages/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  final user = FirebaseAuth.instance.currentUser!;

  List userInventory = [];

  Future loadAllInventoryItems() async {
    userInventory = [];
    FirebaseFirestore.instance
        .collection('users').doc(user.uid).collection('user_inventory')
        .get()
        .then((querySnapshot) {
          print("Getting your current inventory: ");
          for(var docSnapshot in querySnapshot.docs) {
            print('${docSnapshot.id} => ${docSnapshot.data()}');
            userInventory.add(docSnapshot.data());
          }
          setState(() {});
    }).catchError((error) {
      print("Failed to get your inventory items from our database");
    });
  }

  @override
  void initState() {
    super.initState();
    loadAllInventoryItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideMenu(),
      appBar: AppBar(
        title: const Text('Current Inventory',
          style: TextStyle(color: Colors.white, fontSize: 30,),
        ),
        centerTitle: true,
        actions:  [
          IconButton(
            icon: const Icon(Icons.refresh_rounded, color: Colors.white,),
            onPressed: (){
              loadAllInventoryItems();
            }
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Center(
            child: Column(
              children: <Widget>[
                ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.all(5),
                  itemCount: userInventory.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                        title: Center(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Colors.amberAccent,
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black54,
                                      blurRadius: 35.0,
                                      spreadRadius: 5,
                                      offset: Offset(
                                        10, 10,
                                      ),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 50,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              'Name: ${userInventory[index]['item_name']}',
                                          ),
                                          Text(
                                              'Quantity: ${userInventory[index]['quantity']}'
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          print("Now Viewing " + index.toString() + " item");
                          print(userInventory[index]);
                          var items = userInventory[index];
                        },
                    );
                  },
                ),
              ],
            )
        ),
      ),
    );
  }
}

/*
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideMenu(),
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}

 */