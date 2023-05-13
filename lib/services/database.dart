import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_inventory_app/pages/SignUpPage.dart';

class DatabaseService {

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  static String? id;

  final String? uid;
  DatabaseService({this.uid});

  // collection reference
  static final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');



  Future updateUserData(String itemName, int itemAmount) async {
    return await userCollection.doc(getUserID() as String?).collection('user_inventory').doc(itemName).set({
      'item_name': itemName,
      'quantity': itemAmount,
    });
  }

  Future<String?> getUserID () async {
    var collection = FirebaseFirestore.instance.collection('users');
    var docSnapshot = await collection.doc(uid).get();

    Map<String, dynamic> data = docSnapshot.data()!;

    id = data['id'];
    return id;
  }


  // get users stream
  Stream<QuerySnapshot> get users {
    return userCollection.snapshots();
  }
}