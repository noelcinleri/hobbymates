import 'package:flutter/material.dart';
import 'package:hobby_mates/ui/mainScreen.dart';
import 'package:hobby_mates/ui/settingsScreen.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        leading: IconButton(
          color: Color.fromARGB(255, 140, 27, 140),
          icon: Icon(Icons.home),
          onPressed: () => Navigator.push(context, 
           MaterialPageRoute(builder: (context) => MainScreen())
          ),
        ),
        titleSpacing: 0,
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.only(left: 0.0, right: 200.0),
            icon: Image.asset("assets/profil.png"),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(color: Color.fromARGB(255, 250, 250, 250)),
        child: Text("Profil"),
      ),
    );
  }
}