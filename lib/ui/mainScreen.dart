import 'package:flutter/material.dart';
import 'package:hobby_mates/ui/conversation.dart';
import 'package:hobby_mates/ui/profile.dart';
import 'package:hobby_mates/ui/profileScreen.dart';
import 'package:hobby_mates/ui/settingsScreen.dart';
import 'package:hobby_mates/utils/data.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        leading: IconButton(
          color: Color.fromARGB(255, 140, 27, 140),
          icon: Icon(Icons.settings),
          onPressed: () => Navigator.push(context, 
           MaterialPageRoute(builder: (context) => SettingsScreen())
          ),
        ),
        titleSpacing: 0,
        actions: <Widget>[
          IconButton(
            icon: Image.asset("assets/profil.png"),
            onPressed: () => Navigator.push(context, 
              MaterialPageRoute(builder: (context) => ProfileScreen())
            ),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(color: Color.fromARGB(255, 250, 250, 250)),
        child: Text("main"),
      ),
    );
  }
}