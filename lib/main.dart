import 'package:flutter/material.dart';
import 'package:hobby_mates/ui/StartScreen.dart';
import 'package:hobby_mates/ui/conversation.dart';
import 'package:hobby_mates/ui/hobbySelect.dart';
import 'package:hobby_mates/ui/phoneVerificationCode.dart';
import 'package:hobby_mates/ui/phoneverification.dart';
import 'package:hobby_mates/ui/profile.dart';
import 'package:hobby_mates/ui/mainScreen.dart';
import 'package:hobby_mates/ui/settingsScreen.dart';
import 'package:hobby_mates/ui/profileScreen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HobbyMates',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        // '/':(context)=>Conversation(uid: 'Jspv3d8hINaj5NGmMJFF99UOCyL2',),
        '/':(context)=>StartScreen(),
        '/main':(context)=>MainScreen(),
        '/settings':(context)=>SettingsScreen(),
        '/phone':(context)=>PhoneVerification(),
        '/code':(context)=>PhoneCodeEnter(),
        '/profil':(context)=>ProfilePage(),
        '/profileshow':(context)=>ProfileScreen(),
        '/chat':(context)=>Conversation(),
        '/hobby':(context)=>HobbySelect(),
      },
      // home: PhoneVerification(),
    );
  }
}
