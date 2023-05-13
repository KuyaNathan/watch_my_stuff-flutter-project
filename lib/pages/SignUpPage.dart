import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_inventory_app/pages/HomePage.dart';
import 'package:new_inventory_app/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_inventory_app/services/database.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  static User? user = FirebaseAuth.instance.currentUser;


  @override
  State<SignUpPage> createState() => _SignUpPageState();

  static Future<String?> getID() async {
    var collection = FirebaseFirestore.instance.collection('users');
    var docSnapshot = await collection.doc(user?.uid).get();

    Map<String, dynamic> data = docSnapshot.data()!;

    String id = data['id'];
    return id;
  }

}

class _SignUpPageState extends State<SignUpPage> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  late int _success = 0;
  late String? _userEmail;
  late String _userCompany;

  static String docID = '';


  Future register() async {
    if(_emailController.text.isEmpty ){
      _success = 1;
    } else if(_passwordController.text.isEmpty){
      _success = 2;
    } else if(_companyController.text.isEmpty){
      _success = 3;
    } else if(_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty  && _companyController.text.isNotEmpty ){
      _success = 4;
      // creates user
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // stores user company name
      addCompanyName(_companyController.text.trim());
      addMoreInfo();
    }
  }


  void addCompanyName(String companyName) async {
    await FirebaseFirestore.instance.collection('users').add({
      'company_name': _companyController.text.trim(),
      'id': '',
    }).then((DocumentReference doc){
      docID = doc.id;
      FirebaseFirestore.instance.collection('users').doc(docID).update({
        'id': docID,
      });
    });
    addMoreInfo();
  }

  void addMoreInfo() async{
    await FirebaseFirestore.instance.collection('users').doc(docID).collection('user_inventory').add({
      'empty': 'empty',
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text(
          'Sign Up',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        centerTitle: true,

      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 150.0,
                width: 150.0,
                padding: const EdgeInsets.only(top:40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200),
                ),
              ),
               Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'Enter your email address'
                  ),
                ),
              ),

               Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter your password',
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: _companyController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    labelText: 'Company Name',
                    hintText: 'Enter your Company Name',
                  ),
                ),
              ),

              const Padding(
                padding: EdgeInsets.all(5),
              ),

              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  _success == 1
                      ? 'Please enter a valid Email'
                      : (
                      _success == 2
                          ? 'Please enter a password'
                          : (
                          _success == 3
                            ? 'Please enter a company name'
                            : (
                            _success == 4
                              ? ''
                              : 'Please Fill in the Empty Fields'
                          )
                      )),
                  style: const TextStyle(color: Colors.blue),
                ),
              ),

              const Padding(
                padding: EdgeInsets.all(5),
              ),

              Container(
                height: 40,
                width: 150,
                decoration: BoxDecoration(
                    color: Colors.amber, borderRadius: BorderRadius.circular(20)
                ),
                child: ElevatedButton(
                  onPressed:() {
                    register();
                    if(_success == 4){
                      Navigator.pop(
                        context
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amberAccent,
                  ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),

              const Padding(
                padding: EdgeInsets.all(10),
              ),
/*
              Container(
                height: 40,
                width: 150,
                decoration: BoxDecoration(
                    color: Colors.deepOrange, borderRadius: BorderRadius.circular(20)
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(
                      context
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                  ),
                  child: const Text(
                    'Go Back',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),

 */
            ],
          ),
        ),
      ),
    );
  }
}














// creates user with email and password
/*
    final User? user = (
    await _auth.createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text)
    ).user;

    if(user != null) {
      setState(() {
        _success = 2;
        _userEmail = user.email;

      });
     // await DatabaseService(uid: user.uid).updateUserData('none', 0);
    }
    else {
      setState(() {
        _success = 3;

      });
    }
  }

  Future addUserCompany(String companyName) async {
    await FirebaseFirestore.instance.collection('users').add({
      'company name': companyName,
    });

     */