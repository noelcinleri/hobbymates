import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hobby_mates/ui/phoneVerificationCode.dart';
import 'package:hobby_mates/utils/MaskedTextBox.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class PhoneVerification extends StatefulWidget {
  PhoneVerification({Key key}) : super(key: key);

  @override
  _PhoneVerificationState createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerification> {

  bool loading =false;
  TextEditingController phoneController =
      new MaskedTextController(mask: '000-000-0000');
  var firebaseAuth = FirebaseAuth.instance;
  String status = '';
  static String actualCode;
  String errorMessage;
  static bool ch = false;
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
  numberCheck(String number) {
    // if (number.length <= 13) {
    //   setState(() {
    //     errorMessage = 'Geçerli Bir Numara Giriniz* ${number.length}';
    //   });
    // } else
    if (number.substring(0, 1) == '0') {
      setState(() {
        errorMessage = "numaranızı başında '0' olmadan yazınız ";
      });
    } else {
      setState(() {
        errorMessage = null;
      });
    }
  }

  verify(String number) {
    print('phone number => $number');
    firebaseAuth.verifyPhoneNumber(
        phoneNumber: "+90" + number,
        timeout: Duration(seconds: 120),
        verificationCompleted: method,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  PhoneCodeSent codeSent =
      (String verificationId, [int forceResendingToken]) async {
    actualCode = verificationId;
    print('Code Sent');
    ch= true;
    print('actualCode>$actualCode');
  };
  final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
      (String verificationId) {
    actualCode = verificationId;
    print('TIME OUT');
  };
  final PhoneVerificationFailed verificationFailed =
      (AuthException authException) {
    print("Error message: ${authException.message}");
  };
  method(AuthCredential auth) {
    print('bune la');
    var _authCredential = auth;

    firebaseAuth.signInWithCredential(_authCredential).then((AuthResult value) {
      if (value.user != null) {
        setState(() {
          status = 'Authentication successful';
        });
        print('user > ${value.user.uid}');
      } else {
        setState(() {
          status = 'Invalid code/invalid authentication';
        });
      }
    }).catchError((error) {
      setState(() {
        status = 'Something has gone wrong, please try later';
      });
    });
  }
  navigateCodePage(){
    if(ch){
      Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => PhoneCodeEnter(actualCode: actualCode,)),
            (Route<dynamic> route) => false);
    }
  }
  Timer t;

  @override
  void initState() {
    connectionCheck();
    t = Timer.periodic(Duration(seconds: 1), (timer){
      navigateCodePage();
    });
    super.initState();
  }  
  @override
  void dispose() {
    t.cancel();
    super.dispose();
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
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: TextField(
                        keyboardType: TextInputType.phone,
                        controller: phoneController,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            errorText: errorMessage,
                            hintText: "Numaranızı Giriniz",
                            icon: Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10))),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 12),
                                  child: Text('+90',
                                      style: TextStyle(
                                        fontSize: 20,
                                      )),
                                ),
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 14, vertical: 14),
                            focusedBorder: OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                            ),
                            border: InputBorder.none),
                        onChanged: (e) {
                          numberCheck(e);
                        },
                        textInputAction: TextInputAction.go,
                        obscureText: false,
                      ),
                    ),
                    // RaisedButton(
                    //   onPressed: () {
                    //     if ((phoneController.text.length < 12)) {
                    //       setState(() {
                    //         errorMessage =
                    //             'Geçerli Bir Numara Giriniz ${phoneController.text.length}';
                    //       });
                    //     } else {
                    //       setState(() {
                    //         errorMessage = null;
                    //         verify(phoneController.text.replaceAll('-', ''));
                    //       });
                    //     }

                    //     // verify();
                    //   },
                    //   child: Text('tikla'),
                    // ),
                    // RaisedButton(
                    //   onPressed: () {
                    //     _signInWithPhoneNumber('123456');
                    //   },
                    //   child: Text('tikla2'),
                    // ),
                    SizedBox(
                      height: 200,
                    ),
                    RaisedButton(
                      onPressed: () {
                        if ((phoneController.text.length < 12)) {
                          setState(() {
                            errorMessage =
                                'Geçerli Bir Numara Giriniz ${phoneController.text.length}';
                          });
                        } else {
                          setState(() {
                            errorMessage = null;
                            verify(phoneController.text.replaceAll('-', ''));
                          });
                        }
                      },
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.white)),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 3,
                        child: Text(
                          'Devam Et',
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
