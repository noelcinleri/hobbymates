import 'package:flutter/material.dart';
import 'package:hobby_mates/ui/chats.dart';
import 'package:hobby_mates/ui/conversation.dart';
import 'package:hobby_mates/ui/phoneVerificationCode.dart';
import 'package:hobby_mates/ui/phoneverification.dart';
import 'package:hobby_mates/ui/profile.dart';

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
        '/':(context)=>Conversation(uid: 'Jspv3d8hINaj5NGmMJFF99UOCyL2',),
        // '/':(context)=>PhoneVerification(),
        '/code':(context)=>PhoneCodeEnter(),
        '/profil':(context)=>ProfilePage(),
        '/chat':(context)=>Conversation(uid: 'Jspv3d8hINaj5NGmMJFF99UOCyL2',),
      },
      // home: PhoneVerification(),
    );
  }
}
