import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hobby_mates/utils/MaskedTextBox.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class StartScreen extends StatefulWidget {
  StartScreen({Key key}) : super(key: key);

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {

  bool loading =true;
  bool uidBool = false;
  String uid;
  var firebaseAuth = FirebaseAuth.instance;
  void connectionCheck() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      print("mobil conneciton");
    } else if (connectivityResult == ConnectivityResult.wifi) {
      print("wifi connection");
    } else {
      Alert(
        context: context,
        type: AlertType.warning,
        style: AlertStyle(
          isCloseButton: false,
          isOverlayTapDismiss: false,
        ),
        title: "INTERNET BAĞLANTISI",
        desc:
            "İnternet bağlantısı yok. internet bağlantınızla \n beraber lütfen uygulamayı yeniden başlatın ",
        buttons: [
          // DialogButton(
          //   child: Text(
          //     "TAMAM",
          //     style: TextStyle(color: Colors.white, fontSize: 20),
          //   ),
          //   onPressed: () => exit(0),
          //   width: 120,
          // )
        ],
      ).show();
    }
  }
  

 
  @override
  void initState() {
    connectionCheck();
    firebaseAuth.signOut();
    firebaseAuth.currentUser().then((user){
      uidBool = true;
      if(user != null){
        uid = user.uid;
      }
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
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
              ),
              child: Container(
                  child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                   
                    RaisedButton(
                      onPressed: () {
                        if(uid == null && uidBool){
                          Navigator.pushNamedAndRemoveUntil(context, '/phone', (Route<dynamic> r) =>false);
                        }else if(uid != null){
                          Navigator.pushNamedAndRemoveUntil(context, '/chat', (Route<dynamic> r) =>false);
                        }
                      },
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.white)),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 3,
                        child: Text(
                          'BAŞLA',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold,
                              fontSize: 24,
                              foreground: Paint()
                                ..shader = LinearGradient(
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
                                ).createShader(
                                    Rect.fromLTWH(0.0, 0.0, 1000, 50.0))),
                        ),
                      ),
                    )
                  ],
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
