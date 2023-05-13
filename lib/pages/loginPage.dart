import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_inventory_app/pages/SignUpPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  // controllers for email and password
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  int _success = 1;
  String? _userEmail = "";

  Future _signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
    if(FirebaseAuth.instance.currentUser != null) {
      _success = 2;
    } else {
      _success = 3;
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: const Text(
          'Login',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        centerTitle: true,

      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 20),
                height: 200,
                width: 200,
                child: Image.asset(
                  "assets/Watch My Stuff.png",
                ),
              ),

              Container(
                height: 50.0,
                width: 150.0,
                padding: const EdgeInsets.only(top:15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
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

              const Padding(
                padding: EdgeInsets.all(5),
              ),

              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  _success == 1
                      ? ''
                      : (
                      _success == 2
                          ? 'Successfully signed in with  $_userEmail'
                          : 'Could not Find An Account With the Email $_userEmail'),
                  style: const TextStyle(color: Colors.red),
                ),
              ),

              Container(
                height: 40,
                width: 150,
                decoration: BoxDecoration(
                    color: Colors.amber, borderRadius: BorderRadius.circular(20)
                ),
                child: ElevatedButton(
                  onPressed: () {
                    _signIn();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amberAccent,
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),

              const Padding(
                padding: EdgeInsets.all(10),
              ),

              const Text(
                'Don\'t have an account? Sign Up Below',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),

              const Padding(
                padding: EdgeInsets.all(10),
              ),

              Container(
                height: 40,
                width: 150,
                decoration: BoxDecoration(
                    color: Colors.amber, borderRadius: BorderRadius.circular(20)
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignUpPage()),
                    );
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
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}




// old code keeping just in case

/*
    final User? user = (
        await _auth.signInWithEmailAndPassword(email: _emailController.text, password: _passwordController.text)
    ).user;

    if (user != null) {
      setState(() {
        _success = 2;
        _userEmail = user.email;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      });
    }
    else {
      setState(() {
        _success = 3;
      });
    }
  }
*/