import 'package:flutter/material.dart';
import 'package:new_inventory_app/pages/AddItemPage.dart';
import 'package:new_inventory_app/pages/AddOrderPage.dart';
import 'package:new_inventory_app/pages/OrdersPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_inventory_app/services/database.dart';



class SideMenu extends StatelessWidget{
  const SideMenu({super.key});


  @override
  Widget build (BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color.fromRGBO(240, 226, 182, 50),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [
                      0.90,
                      0.99,
                    ],
                    colors: [Color(0xff046a38), Color.fromRGBO(240, 226, 182, 50)]
                ),
              ),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 50),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black54))
              ),
              child: ListTile(
                title: const Text(
                  'Manage Inventory',
                  style: TextStyle(color: Colors.black, fontSize: 25),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddItemPage()),
                  );
                },
              ),
            ),


            /*
            Container(
              decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.black54))
              ),
              child: ListTile(
                  title: const Text('Manage Orders',
                    style: TextStyle(color: Colors.black, fontSize: 25),),
                  onTap: ()  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const OrdersPage()),
                    );
                  }
              ),
            ),

             */




            Container(
              decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.black54))
              ),
              child: ListTile(
                  title: const Text('Add New Item',
                    style: TextStyle(color: Colors.black, fontSize: 25),),
                  onTap: ()  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AddItemPage()),
                    );
                  }
              ),
            ),



            /*
            Container(
              decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.black54))
              ),
              child: ListTile(
                  title: const Text('Add New Order',
                    style: TextStyle(color: Colors.black, fontSize: 25),),
                  onTap: ()  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AddOrderPage()),
                    );
                  }
              ),
            ),

             */


            Container(
              decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.black54))
              ),
              child: ListTile(
                  title: const Text('About',
                    style: TextStyle(color: Colors.black, fontSize: 25),),
                  onTap: ()  {
                     const Tooltip (
                      message: 'Your current items will appear on the home screen.\n To add/manage your items, use the options in the side menu.'
                    );
                  }
              ),
            ),


            Container(
              decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.black54))
              ),
              child: ListTile(
                  title: const Text('Sign Out',
                    style: TextStyle(color: Colors.black, fontSize: 25),),
                  onTap: ()  {
                      FirebaseAuth.instance.signOut();
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}

