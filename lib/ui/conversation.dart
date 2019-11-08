import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hobby_mates/utils/data.dart';
import 'package:hobby_mates/widgets/chat-bubble.dart';
import 'dart:math';

class Conversation extends StatefulWidget {
  final uid;

  const Conversation({Key key, this.uid}) : super(key: key);
  @override
  _ConversationState createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {
  ScrollController scrollController = ScrollController();
  String uid;
  String roomId = '1';
  static Random random = Random();
  TextEditingController controller = TextEditingController();
  String name = names[random.nextInt(10)];
  @override
  void initState() {
    FirebaseAuth.instance.currentUser().then((e) {
      uid = e.uid;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('rooms')
          .document(roomId)
          .collection('messages')
          .snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) {
          return Scaffold(
            body: Container(
              child: Center(
                child: Image.asset('assets/loading.gif'),
              ),
            ),
          );
        } else {
          // snap.data.documents
          // DocumentSnapshot a;
          // a.documentID
          List msgDataTemp = snap.data.documents;
          List msgData = List();
          List<String> names = List();

          for (var i = 0; i < msgDataTemp.length; i++) {
            names.add(msgDataTemp[i].documentID);
          }
          for (var i = 0; i < msgDataTemp.length; i++) {
            if (names.contains(i.toString())) {
              int index = 0;
              for (var j = 0; j < msgDataTemp.length; j++) {
                if (i.toString() == names[j]) {
                  index = j;
                  names[j] = '---';
                }
              }
              msgData.add(msgDataTemp[index]);
            }
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 161, 87, 226),
              leading: IconButton(
                icon: Icon(
                  Icons.keyboard_backspace,
                ),
                onPressed: () => Navigator.pop(context),
              ),
              titleSpacing: 0,
              title: InkWell(
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 0.0, right: 10.0),
                      child: CircleAvatar(
                        backgroundImage: AssetImage(
                          "assets/profil.png",
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 15.0),
                          Text(
                            name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Online",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                onTap: () {},
              ),
              actions: <Widget>[
                // IconButton(
                //   icon: Icon(
                //     Icons.more_horiz,
                //   ),
                //   onPressed: () {},
                // ),
              ],
            ),
            body: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10),
                  Flexible(
                    child: ListView.builder(
                      controller: scrollController,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      itemCount: msgData.length,
                      reverse: false,
                      itemBuilder: (BuildContext context, int index) {
                        Map msg = msgData[index].data;
                        return ChatBubble(
                          message: msg['type'] == "text"
                              ? msg['message']
                              : "assets/profil.png",
                          username: msg["username"],
                          time: msg["time"],
                          type: msg['type'],
                          replyText: msg["replyText"],
                          isMe: msg['uid'] == uid ? true : false,
                          isGroup: msg['isGroup'],
                          isReply: msg['isReply'],
                          replyName: name,
                        );
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
//                height: 140,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          stops: [
                            0,
                            1,
                            1,
                          ],
                          colors: [
                            Color.fromARGB(255, 118, 143, 226),
                            Color.fromARGB(255, 161, 87, 226),
                            Color.fromARGB(255, 0, 0, 0),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[500],
                            offset: Offset(0.0, 1.5),
                            blurRadius: 4.0,
                          ),
                        ],
                      ),
                      constraints: BoxConstraints(
                        maxHeight: 190,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Flexible(
                            child: ListTile(
                              leading: IconButton(
                                icon: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                                onPressed: () {},
                              ),
                              contentPadding: EdgeInsets.all(0),
                              title: TextField(
                                controller: controller,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.white,
                                ),
                                onTap: () {
                                  setState(() {
                                    scrollController.jumpTo(scrollController
                                        .position.maxScrollExtent);
                                  });
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 118, 143, 226)
                                          .withOpacity(0),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 118, 143, 226)
                                          .withOpacity(0),
                                    ),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 118, 143, 226)
                                          .withOpacity(0),
                                    ),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 118, 143, 226)
                                          .withOpacity(0),
                                    ),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 118, 143, 226)
                                          .withOpacity(0),
                                    ),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  hintText: "Mesaj Yazınız",
                                  hintStyle: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.white,
                                  ),
                                ),
                                maxLines: null,
                              ),
                              trailing: IconButton(
                                icon: Icon(
                                  Icons.send,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  if (controller.text.length >= 1) {
                                    Firestore.instance
                                        .collection('rooms')
                                        .document(roomId)
                                        .collection('messages')
                                        .document(msgData.length.toString())
                                        .setData({
                                      "username": "abdusin",
                                      "message": controller.text,
                                      "time": "",
                                      "type": 'text',
                                      "replyText": 'boş',
                                      "isMe": true,
                                      "uid": uid,
                                      "isGroup": false,
                                      "isReply": false,
                                    }).then((e) {
                                      print(
                                          'len*> ${msgData.length.toString()}');
                                      setState(() {
                                        controller.clear();
                                      });
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
