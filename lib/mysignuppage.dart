import 'package:chatapp/myloginscreen.dart';
import 'package:chatapp/mymainscreen.dart';
import 'package:chatapp/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MySignupPage extends StatefulWidget {
  @override
  State<MySignupPage> createState() => _MySignupPageState();
}

class _MySignupPageState extends State<MySignupPage> {
  bool show = false;
  final myFormKey = GlobalKey<FormState>();
  List<String> myUsers = [];
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fireStore = FirebaseFirestore.instance.collection('Users');
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0B805D),
        title: const Center(
            child: Text(
          'Sign Up',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 25),
        )),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                  key: myFormKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter name';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.person_outline_rounded,
                              size: 27,
                              color: Color(0xff5E5E5E),
                            ),
                            hintText: 'Name',
                            hintStyle: TextStyle(
                                color: Color(0xffAFAFAF),
                                fontWeight: FontWeight.normal),
                            contentPadding: EdgeInsets.only(top: 12)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter email';
                          }
                          return null;
                        },
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
              SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      if (myFormKey.currentState!.validate()) {
                        _auth
                            .createUserWithEmailAndPassword(
                                email: emailController.text.toString(),
                                password: passwordController.text.toString())
                            .then((value) {

                          String p = _auth.currentUser!.email.toString();
                          String username =
                          p.trimRight().substring(0, p.length - 10);
                          fireStore
                              .doc(username)
                              .set({
                                "name": nameController.text.toString(),
                                "id": username,
                              })
                              .then((value) {})
                              .onError((error, stackTrace) {
                                toast().myToast(error.toString());
                              });
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyMainScreen(username)));
                        }).onError((error, stackTrace) {});
                      }
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xff0B805D))),
                  )),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyLoginScreen()));
                    },
                    child: Text(
                      'Log In',
                      style: TextStyle(color: Color(0xff0B805D)),
                    ),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.zero),
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent)),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
