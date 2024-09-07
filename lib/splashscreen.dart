import 'dart:async';
import 'package:chatapp/myloginscreen.dart';
import 'package:chatapp/mymainscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  @override
  void initState() {

    final user = _auth.currentUser;
    if (user != null) {
      Timer(Duration(
        seconds: 1
      ), () {
        String p = _auth.currentUser!.email.toString();
        String username = p.trimRight().substring(0, p.length - 10);
Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> MyMainScreen(username)));
      });
    }
    else{
      Timer(Duration(seconds: 1), (){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyLoginScreen()));
      });
    }
  }
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Welcome!',
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}
