import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddOrderPage extends StatefulWidget {
  const AddOrderPage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  State<AddOrderPage> createState() => _AddOrderPageState();
}

class _AddOrderPageState extends State<AddOrderPage> {

  final TextEditingController _customerController = TextEditingController();
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _itemAmountController = TextEditingController();
  final TextEditingController _orderNumberController = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;

  Future addOrder( String orderNumber, String customer, String itemName, int itemAmount) async {
    await FirebaseFirestore.instance.collection('users').doc(user?.uid).collection('user_orders').doc("order $orderNumber").set({
      'order_number': orderNumber,
      'customer': customer,
      'item_name': itemName,
      'quantity': itemAmount,
    });
  }

  @override
  Widget build (BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: const Text('Add New Order',
          style: TextStyle(color: Colors.white, fontSize: 20,),
        ),
        centerTitle: true,
      ),

      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: _orderNumberController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  labelText: 'Order Number/Code',
                  hintText: 'Enter the Number/Code You Wish to Associate with this Order',
                ),
                keyboardType: TextInputType.text,

              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: _customerController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  labelText: 'Customer',
                  hintText: 'Enter the Name of the Customer Who Ordered',
                ),
                keyboardType: TextInputType.text,

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
                  labelText: 'Item',
                  hintText: 'Enter the Name of the Item Being Ordered',
                ),
                keyboardType: TextInputType.text,

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
                  hintText: 'Enter the Amount of this item that was ordered',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
            ),

            ElevatedButton(
              onPressed: () {
                addOrder(
                  _orderNumberController.text.trim(),
                  _customerController.text.trim(),
                  _itemNameController.text.trim(),
                  int.parse(_itemAmountController.text.trim()),
                );
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

/*
class AddOrderPage extends StatelessWidget {
  const AddOrderPage({super.key});

  @override
  Widget build (BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: const Text('Add New Order'),
      ),

      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Amount',
                  hintText: 'Enter the Amount of this item that was ordered',
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