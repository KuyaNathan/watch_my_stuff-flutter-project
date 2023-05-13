

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_inventory_app/pages/HomePage.dart';
import 'package:new_inventory_app/services/database.dart';
import 'package:new_inventory_app/pages/SignUpPage.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({super.key});

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {

  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _itemAmountController = TextEditingController();

  User? user = FirebaseAuth.instance.currentUser;

  static bool check = false;

  Future addItem(String itemName, int itemAmount) async {
    await FirebaseFirestore.instance.collection('users').doc(user?.uid).collection('user_inventory').doc(itemName).set({
      'item_name': itemName,
      'quantity': itemAmount,
    });
  }

  Future updateItem(String itemName, int itemAmount) async {
    await FirebaseFirestore.instance.collection('users').doc(user?.uid).collection('user_inventory').doc(itemName).update({
      'quantity': itemAmount,
    });
  }

  void checkIfExists(String itemName) async {
    DocumentSnapshot<Map<String, dynamic>> document = await FirebaseFirestore
        .instance.collection('users').doc(user?.uid).collection('user_inventory')
        .doc(itemName).get();

    if(document.exists) {
      check = true;
    } else {
      check = false;
    }
  }


  @override
  Widget build (BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: const Text('Manage Items in Inventory',
          style: TextStyle(color: Colors.white, fontSize: 20,),
        ),
        centerTitle: true,
      ),

      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(60),
            ),

            const Padding(
              padding: EdgeInsets.all(5),
              child: Text (
                "If the item exists, the amount will be updated.\nIf the item does not exist, then a new item will be created.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blue),
              ),
            ),

             Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: _itemNameController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  labelText: 'Item Name',
                  hintText: 'Enter the Name of the Item you Wish to add',
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: _itemAmountController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  labelText: 'Amount',
                  hintText: 'Enter the Current Amount of this Item',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
            ),

            ElevatedButton(
              onPressed: () {
                checkIfExists(_itemNameController.text.trim());
                if(check == false) {
                  addItem(
                    _itemNameController.text.trim(),
                    int.parse(_itemAmountController.text.trim()),
                  );
                } else if(check == true) {
                  updateItem(
                    _itemNameController.text.trim(),
                    int.parse(_itemAmountController.text.trim())
                  );
                }

                Navigator.pop(
                    context
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amberAccent,
              ),
              child: const Text(
                'Submit',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),

          ],
        ),
      ),
    );
  }
}




// old code keeping just in case
/*
class AddItemPage extends StatelessWidget {
  const AddItemPage({super.key});

  @override
  Widget build (BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: const Text('Add New Item to Inventory'),
      ),
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Item Name',
                    hintText: 'Enter the Name of the Item you Wish to add',
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Description',
                  hintText: 'Enter a Description of the Item',
                ),
                autofocus: false,
                maxLines: null,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Amount',
                  hintText: 'Enter the Current Amount of this Item',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  context
                );
              },
              child: const Text(
                'Submit',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

 */