import 'dart:io';

import 'package:chatapp/chatscreen.dart';
import 'package:chatapp/myloginscreen.dart';
import 'package:chatapp/mymainscreen.dart';
import 'package:chatapp/mysignuppage.dart';
import 'package:chatapp/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
void main()
async{
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid? await Firebase.initializeApp(
    options: const FirebaseOptions(apiKey: "AIzaSyCF8SG5F0-Ba7z4fMsHRivJjCJiiDXi76Y",
        appId: "1:454387862835:android:a0fe7679527f2e20828246",
        messagingSenderId: "454387862835",
        projectId: "chatapp-16732")
  ) : await Firebase.initializeApp(
      options: const FirebaseOptions(apiKey: "AIzaSyCF8SG5F0-Ba7z4fMsHRivJjCJiiDXi76Y",
          appId: "1:454387862835:android:a0fe7679527f2e20828246",
          messagingSenderId: "454387862835",
          projectId: "chatapp-16732")
  );
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splashscreen(),
    );
  }
}
