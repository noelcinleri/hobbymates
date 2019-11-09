import 'package:flutter/material.dart';
import 'package:hobby_mates/ui/mainScreen.dart';
import 'package:hobby_mates/ui/profile.dart';
import 'package:hobby_mates/ui/profileScreen.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        leading: IconButton(
          padding: EdgeInsets.only(left: 200.0, right: 0.0),
          color: Color.fromARGB(255, 140, 27, 140),
          icon: Icon(Icons.settings),
        ),
        titleSpacing: 0,
        actions: <Widget>[
          IconButton(
            color: Color.fromARGB(255, 140, 27, 140),
            icon: Icon(Icons.home),
            onPressed: () => Navigator.push(context, 
              MaterialPageRoute(builder: (context) => MainScreen())
            ),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(color: Color.fromARGB(255, 250, 250, 250)),
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            Text("Uygulama Ayarları", style: TextStyle(fontSize: 20)),
            Card(
              child: ListTile(
                title: Text('Bildirim gönderileri al'),
                subtitle: Text('Size uygulamamızla ilgili bildirimleri almak için'),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Bildirim gönderileri al'),
                subtitle: Text('Size uygulamamızla ilgili bildirimleri almak için'),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Bildirim gönderileri al'),
                subtitle: Text('Size uygulamamızla ilgili bildirimleri almak için'),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Bildirim gönderileri al'),
                subtitle: Text('Size uygulamamızla ilgili bildirimleri almak için'),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Bildirim gönderileri al'),
                subtitle: Text('Size uygulamamızla ilgili bildirimleri almak için'),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Bildirim gönderileri al'),
                subtitle: Text('Size uygulamamızla ilgili bildirimleri almak için'),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Bildirim gönderileri al'),
                subtitle: Text('Size uygulamamızla ilgili bildirimleri almak için'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}