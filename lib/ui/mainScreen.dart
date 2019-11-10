import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hobby_mates/ui/chats.dart';
import 'package:hobby_mates/ui/profileScreen.dart';
import 'package:hobby_mates/utils/Firestore.dart';
import 'package:hobby_mates/utils/utils.dart';
import 'package:hobby_mates/widgets/appbar.dart';
import 'package:hobby_mates/widgets/userCard.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        GradientAppBar(
          leftIcon: IconButton(
            color: Colors.white,
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(context, PageTransition(type: PageTransitionType.leftToRightWithFade, child: ProfileScreen()));
              // Navigator.pushNamed(context, '/profileshow');
            },
          ),
          centerIcon: IconButton(
            color: Colors.white,
            icon: Icon(Icons.home),
            onPressed: () {},
          ),
          rightIcon: IconButton(
            color: Colors.white,
            icon: Icon(
              Icons.message,
            ),
            onPressed: () {
              Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeftWithFade, child: Chats()));
            },
          ),
        ),
        StreamBuilder(
          stream:
              Firestore.instance.collection('users').getDocuments().asStream(),
          builder: (context, snap) {
            if (snap.hasData) {
              List<Widget> cards = List();

              for (var i = 0; i < snap.data.documents.length; i++) {
                if (Uid.uid != snap.data.documents[i].documentID) {
                  cards.add(UserCard(
                    name: snap.data.documents[i]['userName'],
                    func: () {
                      Firestore.instance
                          .collection('rooms')
                          .getDocuments()
                          .then((docs) {
                        bool canThis = true;
                        for (var j = 0; j < docs.documents.length; j++) {
                          List<dynamic> users = docs.documents[j]['users'];
                          if (users[0] == snap.data.documents[i].documentID) {
                            // [snap.data.documents[i].documentID, Uid.uid]
                            canThis = false;
                          }
                        }
                        if (canThis) {
                          Firestore.instance
                              .collection('rooms')
                              .document('${docs.documents.length + 1}')
                              .setData({
                            'isApproved': false,
                            'sender': Uid.uid,
                            'users': [
                              snap.data.documents[i].documentID,
                              Uid.uid
                            ]
                          }, merge: true);
                          Firestore.instance
                              .collection('users')
                              .document('${Uid.uid}')
                              .setData({
                            'rooms': snap.data.documents[i]['rooms'] +
                                [docs.documents.length + 1]
                          }, merge: true);
                        } else {
                          Alert(
                              type: AlertType.warning,
                              title: 'HATA OLDU',
                              desc:
                                  'aynı kişiyle 2.kere sohber açmaya çalıştın',
                              context: context,
                              buttons: []).show();
                        }
                      });
                    },
                  ));
                }
              }

              return SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height -
                      (MediaQuery.of(context).padding.top + 70),
                  decoration:
                      BoxDecoration(color: Color.fromARGB(255, 250, 250, 250)),
                  child: ListView(
                    children: cards,
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
}
