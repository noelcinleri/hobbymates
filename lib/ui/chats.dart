import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hobby_mates/ui/mainScreen.dart';
import 'package:hobby_mates/utils/utils.dart';
import 'package:hobby_mates/widgets/appbar.dart';
import 'package:page_transition/page_transition.dart';

class Chats extends StatefulWidget {
  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        GradientAppBar(
          leftIcon: IconButton(
            color: Colors.white,
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.leftToRight,
                      child: MainScreen()));
            },
          ),
          centerIcon: IconButton(
            color: Colors.white,
            icon: Icon(Icons.message),
            onPressed: () {},
          ),
          rightIcon: IconButton(
            color: Colors.white,
            icon: Icon(
              Icons.message,
              color: Colors.transparent,
            ),
            onPressed: () {},
          ),
        ),
        StreamBuilder(
          stream:
              Firestore.instance.collection('rooms').getDocuments().asStream(),
          builder: (context, snap) {
            if (snap.hasData) {
              return SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height -
                      (MediaQuery.of(context).padding.top + 70),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: (MediaQuery.of(context).size.height -
                                (MediaQuery.of(context).padding.top + 70)) *
                            2 /
                            6,
                        padding: EdgeInsets.only(top: 10),
                        child: Column(
                          children: <Widget>[
                            leftAlignText(
                                text: 'Konuşma Talepleri',
                                leftPadding: 10.0,
                                textColor: AppColor.mainColor,
                                fontSize: 16.0),
                            Divider(
                              thickness: 1.5,
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: (MediaQuery.of(context).size.height -
                                (MediaQuery.of(context).padding.top + 70)) *
                            4 /
                            6,
                        padding: EdgeInsets.only(top: 10),
                        child: Column(
                          children: <Widget>[
                            leftAlignText(
                                text: 'Aktif Konuşmalar',
                                leftPadding: 10.0,
                                textColor: AppColor.mainColor,
                                fontSize: 16.0),
                            Divider(
                              thickness: 1.5,
                            ),
                            StreamBuilder(
                              stream: Firestore.instance
                                  .collection('users')
                                  .getDocuments()
                                  .asStream(),
                              builder: (context, snapUser) {
                                if (snapUser.hasData) {
                                  int index;
                                  int index2;
                                  for (var i = 0;
                                      i < snapUser.data.documents.length;
                                      i++) {
                                    if (snapUser.data.documents[i].documentID ==
                                        Uid.uid) {
                                      index = i;
                                    }
                                  }
                                  //snap.data.documents[int.parse(rooms[i])+1]['users'][0]
                                  List rooms =
                                      snapUser.data.documents[index]['rooms'];
                                  List wid = List();
                                  wid.add(GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context, '/chat');
                                    },
                                    child: Card(
                                      elevation: 8.0,
                                      margin: new EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 6.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: AppColor.mainColor),
                                        child: ListTile(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 20.0,
                                                    vertical: 10.0),
                                            leading: Container(
                                              padding:
                                                  EdgeInsets.only(right: 12.0),
                                              decoration: new BoxDecoration(
                                                  border: new Border(
                                                      right: new BorderSide(
                                                          width: 1.0,
                                                          color:
                                                              Colors.white24))),
                                              child: Icon(Icons.account_circle,
                                                  color: Colors.white),
                                            ),
                                            title: Text(
                                              "Hope",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            // subtitle: Row(
                                            //   children: <Widget>[
                                            //     Icon(Icons.record_voice_over,
                                            //         color: Colors.grey),
                                            //     SizedBox(width: 10,),
                                            //     Text('"Hi"',
                                            //         style: TextStyle(
                                            //             color:
                                            //                 Colors.greenAccent))
                                            //   ],
                                            // ),
                                            trailing: Icon(
                                                Icons.keyboard_arrow_right,
                                                color: Colors.white,
                                                size: 30.0)),
                                      ),
                                    ),
                                  ));

                                  /* SAKIN SİLME yada sil yaaaa */
                                  // for (var i = 0; i < rooms.length; i++) {
                                  //   if (snap.data.documents[rooms[i] - 1]
                                  //       ['isApproved']) {
                                  //     wid.add(SizedBox(
                                  //       height: 30,
                                  //       width: 120,
                                  //       child: Text('öz sivaslılar'),
                                  //     ));
                                  //   }
                                  // }
                                  return SingleChildScrollView(
                                    child: Container(
                                      height:
                                          ((MediaQuery.of(context).size.height -
                                                      (MediaQuery.of(context)
                                                              .padding
                                                              .top +
                                                          70)) *
                                                  4 /
                                                  6) -
                                              45,
                                      child: ListView.builder(
                                        itemCount: wid.length,
                                        itemBuilder: (context, indexes) {
                                          return wid[indexes];
                                        },
                                      ),
                                    ),
                                  );
                                } else {
                                  return Container(
                                    height:
                                        ((MediaQuery.of(context).size.height -
                                                    (MediaQuery.of(context)
                                                            .padding
                                                            .top +
                                                        70)) *
                                                4 /
                                                6) -
                                            45,
                                    child: Center(
                                      child: Image.asset('assets/loading.gif'),
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Center(
                child: Image.asset(
                  'assets/loading.gif',
                  width: 100,
                ),
              );
            }
          },
        ),
      ],
    ));
  }

  Padding leftAlignText(
      {key, text, leftPadding, textColor, fontSize, fontWeight}) {
    return Padding(
      key: key,
      padding: EdgeInsets.only(left: leftPadding),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(text ?? "",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontFamily: 'Exo2',
                fontSize: fontSize ?? 14.0,
                fontWeight: fontWeight ?? FontWeight.w500,
                color: textColor)),
      ),
    );
  }
}
