import 'package:flutter/material.dart';
import 'package:hobby_mates/ui/profileScreen.dart';
import 'package:hobby_mates/widgets/appbar.dart';
import 'package:page_transition/page_transition.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        GradientAppBar(
            leftIcon: IconButton(
              onPressed: () {},
              color: Colors.white,
              icon: Icon(Icons.settings,color: Colors.transparent,),
            ),
            centerIcon: IconButton(
              onPressed: () {},
              color: Colors.white,
              icon: Icon(Icons.settings),
            ),
            rightIcon: IconButton(
              color: Colors.white,
              icon: Icon(Icons.account_circle),
              onPressed: (){
                Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: ProfileScreen()));
              },
            )
        ),
        Container(
          height: MediaQuery.of(context).size.height -
              (MediaQuery.of(context).padding.top + 70),
          decoration: BoxDecoration(color: Color.fromARGB(255, 250, 250, 250)),
          child: ListView(
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              Text("Uygulama Ayarları", style: TextStyle(fontSize: 20)),
              Card(
                child: ListTile(
                  title: Text('Bildirim gönderileri al'),
                  subtitle:
                      Text('Size uygulamamızla ilgili bildirimleri almak için'),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('Bildirim gönderileri al'),
                  subtitle:
                      Text('Size uygulamamızla ilgili bildirimleri almak için'),
                ),
              ),
            ],
          ),
        )
      ],
    ));
  }
}
