import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hobby_mates/ui/mainScreen.dart';
import 'package:hobby_mates/ui/settingsScreen.dart';
import 'package:hobby_mates/utils/utils.dart';
import 'package:hobby_mates/widgets/appbar.dart';
import 'package:page_transition/page_transition.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height -
                      (MediaQuery.of(context).padding.top + 70);
    final String imgUrl =
        'https://pixel.nymag.com/imgs/daily/selectall/2017/12/26/26-eric-schmidt.w700.h700.jpg';
    return Scaffold(
        body: Column(
      children: <Widget>[
        GradientAppBar(
          leftIcon: IconButton(
            color: Colors.white,
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(context, PageTransition(type: PageTransitionType.leftToRightWithFade, child: SettingsScreen()));
            },
          ),
          centerIcon: IconButton(
              onPressed: () {},
              color: Colors.white,
              icon: Icon(Icons.account_circle,size: 35,),
            ),
          rightIcon: IconButton(
              onPressed: (){
                Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeftWithFade, child: MainScreen()));
              },
              icon: Icon(Icons.home,color: Colors.white,),
            ),
        ),
        Container(
          height: _height,
          decoration: BoxDecoration(color: Color.fromARGB(255, 250, 250, 250)),
          child: Stack(
      children: <Widget>[
        Scaffold(
            drawer: new Drawer(
              child: new Container(),
            ),
            backgroundColor: Colors.white,
            body: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: _height / 12,
                  ),
                  CircleAvatar(
                    radius: _width < _height ? _width / 4 : _height / 4,
                    backgroundImage: NetworkImage(imgUrl),
                  ),
                  SizedBox(
                    height: _height / 25.0,
                  ),
                  Text(
                    '',
                    style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: _width / 15,
                        color: AppColor.mainColor),
                  ),
                  Padding(
                    padding: new EdgeInsets.only(
                        top: _height / 30, left: _width / 8, right: _width / 8),
                    child: new Text(
                      'Snowboarder, Superhero and writer.\nSometime I work at google as Executive Chairman ',
                      style: new TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: _width / 25,
                          color: AppColor.mainColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Divider(
                    height: _height / 30,
                    color: AppColor.mainColor,
                  ),
                  Row(
                    children: <Widget>[
                      rowCell(343, 'Bla'),
                      rowCell(1858, 'BLa1'),
                      rowCell(275, 'Bla2'),
                    ],
                  ),
                  Divider(height: _height / 30, color: AppColor.mainColor),
                  Padding(
                    padding: new EdgeInsets.only(
                        left: _width / 8, right: _width / 8),
                    child: new FlatButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.pushNamedAndRemoveUntil(context, '/', (Route<dynamic>r)=>false);
                      },
                      child: new Container(
                          child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Icon(Icons.exit_to_app),
                          new SizedBox(
                            width: _width / 30,
                          ),
                          new Text('Çıkış Yap')
                        ],
                      )),
                      color: Colors.blue[50],
                    ),
                  ),
                ],
              ),
            ))
      ],
    ),
        ),
      ],
    ));
    
  }
  Widget rowCell(int count, String type) => Expanded(
          child: Column(
        children: <Widget>[
          Text(
            '$count',
            style: TextStyle(color: AppColor.mainColor),
          ),
          Text(type,
              style: TextStyle(
                  color: AppColor.mainColor, fontWeight: FontWeight.normal))
        ],
      ));
}
