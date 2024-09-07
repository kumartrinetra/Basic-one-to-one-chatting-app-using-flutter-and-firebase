import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyChatsScreen extends StatefulWidget {
  String input;
  String name;
  MyChatsScreen(this.input, this.name);

  @override
  State<MyChatsScreen> createState() =>
      _MyChatsScreenState(this.input, this.name);
}

class _MyChatsScreenState extends State<MyChatsScreen> {
  final myChats2 = FirebaseFirestore.instance.collection('Chats');
  String input;
  final myController = TextEditingController();
  String name;
  _MyChatsScreenState(this.input, this.name);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0B805D),
        title: Text(
          name,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Chats')
                    .doc(input)
                    .collection('DonoKiBaatein')
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  return Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          if (snapshot.data!.docs[index]['message']
                                  .toString() ==
                              "") {
                            return SizedBox();
                          }
                          if (snapshot.data!.docs[index]['receiver']
                                  .toString() ==
                              name) {
                            return Align(
                              alignment: Alignment.topRight,
                              child: Column(
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                          color: Colors.blueGrey,
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(12),
                                              topLeft: Radius.circular(12),
                                              bottomLeft: Radius.circular(12),
                                              bottomRight:
                                                  Radius.circular(12))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          snapshot.data!.docs[index]['message']
                                              .toString(),
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      )),
                                  SizedBox(
                                    height: 6,
                                  ),
                                ],
                              ),
                            );
                          }
                          return Align(
                            alignment: Alignment.topLeft,
                            child: Column(
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                        color: Colors.blueGrey,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        snapshot.data!.docs[index]['message']
                                            .toString(),
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    )),
                                SizedBox(
                                  height: 6,
                                ),
                              ],
                            ),
                          );
                        }),
                  ));
                }),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    enabled: true,
                    controller: myController,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                SizedBox(
                  height: 55,
                  width: 55,
                  child: IconButton(
                    onPressed: () {
                      String id = DateTime.now().year.toString() +
                          DateTime.now().month.toString() +
                          DateTime.now().day.toString() +
                          DateTime.now().hour.toString() +
                          DateTime.now().minute.toString() +
                          DateTime.now().second.toString() +
                          DateTime.now().millisecond.toString();
                      myChats2
                          .doc(input)
                          .collection('DonoKiBaatein')
                          .doc(id)
                          .set({
                        'id': id,
                        'message': myController.text.toString(),
                        'receiver': name,
                        //'image' : Image.asset('assets/images/img_1.png'),
                      });
                      myController.clear();
                      setState(() {});
                    },
                    icon: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 27,
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xff0B805D))),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
