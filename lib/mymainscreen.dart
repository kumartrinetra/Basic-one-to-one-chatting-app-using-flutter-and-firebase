import 'package:chatapp/chatscreen.dart';
import 'package:chatapp/myloginscreen.dart';
import 'package:chatapp/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyMainScreen extends StatefulWidget {
  @override
  String myId;
  MyMainScreen(this.myId);
  State<MyMainScreen> createState() => _MyMainScreenState(this.myId);
}

class _MyMainScreenState extends State<MyMainScreen> {
  String myId;
  _MyMainScreenState(this.myId);
  final _auth = FirebaseAuth.instance;
  final myContact = FirebaseFirestore.instance.collection('Users').snapshots();
  final myUsers = FirebaseFirestore.instance.collection('Chats');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0B805D),
        actions: [
          IconButton(
              onPressed: () {
                _auth.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MyLoginScreen()));
              },
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              )),
        ],
        title: Text(
          'Connections',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Chat With: ',
              style: TextStyle(fontSize: 23),
            ),
            SizedBox(
              height: 10,
            ),
            StreamBuilder<QuerySnapshot>(
                stream: myContact,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return Text('Has Some Error');
                  }
                  return Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          String p = _auth.currentUser!.email.toString();
                          String username =
                          p.trimRight().substring(0, p.length - 10);
                          if(snapshot.data!.docs[index]['id'].toString() != username) {
                            return InkWell(
                              onTap: () {
                                List<String> key = [];
                                key.add(snapshot.data!.docs[index]['id']
                                    .toString());
                                key.add(myId);
                                key.sort();
                                String input = key.join();
                                String id = DateTime.now().year.toString() +
                                    DateTime.now().month.toString() +
                                    DateTime.now().day.toString() +
                                    DateTime.now().hour.toString() +
                                    DateTime.now().minute.toString() +
                                    DateTime.now().second.toString() +
                                    DateTime.now().millisecond.toString();
                                myUsers
                                    .doc(input)
                                    .collection('DonoKiBaatein')
                                    .doc(id)
                                    .set({
                                  "id": id,
                                  "message": '',
                                  "receiver": snapshot.data!.docs[index]['name']
                                      .toString()
                                });
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyChatsScreen(
                                            input,
                                            snapshot.data!.docs[index]['name']
                                                .toString())));
                              },
                              child: Card(
                                child: ListTile(
                                  title: Text(snapshot.data!.docs[index]['name']
                                      .toString()),
                                ),
                              ),
                            );
                          }
                          return SizedBox();
                        }),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
