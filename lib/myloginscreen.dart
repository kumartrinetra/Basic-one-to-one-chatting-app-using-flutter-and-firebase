import 'package:chatapp/mymainscreen.dart';
import 'package:chatapp/mysignuppage.dart';
import 'package:chatapp/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyLoginScreen extends StatefulWidget {

  @override
  State<MyLoginScreen> createState() => _MyLoginScreenState();
}

class _MyLoginScreenState extends State<MyLoginScreen> {

  bool show = false;
  List<String> myUsers = [];
  final _auth = FirebaseAuth.instance;

  final myFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final myDatabase = FirebaseFirestore.instance.collection('Users').snapshots();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0B805D),
        title: const Center(
            child: Text(
          'Hot Chat',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 25),
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
                key: myFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter email';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            size: 27,
                            color: Color(0xff5E5E5E),
                          ),
                          hintText: 'Email',
                          hintStyle: TextStyle(
                              color: Color(0xffAFAFAF),
                              fontWeight: FontWeight.normal),
                          contentPadding: EdgeInsets.only(top: 12)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter password';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          suffixIcon: SizedBox(
                            height: 24,
                            width: 24,
                            child: IconButton(
                                onPressed: () {
                                  if (show) {
                                    show = false;
                                    setState(() {});
                                  } else {
                                    show = true;
                                    setState(() {});
                                  }
                                },
                                icon: show
                                    ? Image.asset(
                                        'assets/images/img_1.png',
                                        color: Color(0xff5E5E5E),
                                      )
                                    : Image.asset(
                                        'assets/images/img.png',
                                        color: Color(0xff5E5E5E),
                                      )),
                          ),
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            size: 27,
                            color: Color(0xff5E5E5E),
                          ),
                          hintText: 'Password',
                          hintStyle: TextStyle(
                              color: Color(0xffAFAFAF),
                              fontWeight: FontWeight.normal),
                          contentPadding: EdgeInsets.only(top: 12)),
                      obscureText: show,
                    ),
                  ],
                )),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  child: Text(
                    'Log In',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xff0B805D))),
                  onPressed: () {
                    if (myFormKey.currentState!.validate()) {
                      _auth
                          .signInWithEmailAndPassword(
                              email: emailController.text.toString(),
                              password: passwordController.text.toString())
                          .then((value) {
                        String p = _auth.currentUser!.email.toString();
                        String username =
                        p.trimRight().substring(0, p.length - 10);
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyMainScreen(username)));
                      }).onError((error, stacktrace){
                        toast().myToast(error.toString());
                      });
                    }
                  },
                )),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MySignupPage()));
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(color: Color(0xff0B805D)),
                  ),
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent)),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            /*Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Login with'),
                TextButton(onPressed: (){}, child: Text('Phone', style: TextStyle(color: Color(0xff0B805D)),), style: ButtonStyle(padding:
                MaterialStateProperty.all(EdgeInsets.zero), overlayColor: MaterialStateProperty.all(Colors.transparent)),)
              ],
            ),*/
          ],
        ),
      ),
    );
  }
}
