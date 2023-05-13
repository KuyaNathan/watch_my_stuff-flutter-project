

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {

  final user = FirebaseAuth.instance.currentUser!;

  List userOrders = [];

  Future loadAllOrders() async {
    userOrders = [];
    FirebaseFirestore.instance
        .collection('users').doc(user.uid).collection('user_orders')
        .get()
        .then((querySnapshot) {
      print("Getting your current orders: ");
      for(var docSnapshot in querySnapshot.docs) {
        print('${docSnapshot.id} => ${docSnapshot.data()}');
        userOrders.add(docSnapshot.data());
      }
      setState(() {});
    }).catchError((error) {
      print("Failed to get your current orders from our database");
    });
  }


  void initState() {
    super.initState();
    loadAllOrders();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Current Inventory',
          style: TextStyle(color: Colors.white, fontSize: 30,),
        ),
        centerTitle: true,
        actions:  [
          IconButton(
              icon: const Icon(Icons.refresh_rounded, color: Colors.white,),
              onPressed: (){
                loadAllOrders();
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
                  itemCount: userOrders.length,
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
                                            'Order: ${userOrders[index]['order_number']}',
                                          ),
                                          Text(
                                            'Customer: ${userOrders[index]['customer']}',
                                          ),
                                          Text(
                                            'Item: ${userOrders[index]['item_name']}',
                                          ),
                                          Text(
                                              'Quantity: ${userOrders[index]['quantity']}'
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
                          showModalBottomSheet<void> (
                              context: context,
                              builder: (BuildContext context) {
                                return Container (
                                  child: Wrap (
                                    children: <Widget> [
                                      ListTile(
                                        leading: const Icon(Icons.check),
                                        title: const Text('Fulfill Order'),
                                        onTap: () {

                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                          );
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