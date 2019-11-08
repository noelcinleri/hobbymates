import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hobby_mates/ui/profile.dart';
import 'package:hobby_mates/utils/MaskedTextBox.dart';
import 'package:hobby_mates/utils/shared.dart';

class PhoneCodeEnter extends StatefulWidget {
  final actualCode;
  PhoneCodeEnter({Key key, this.actualCode}) : super(key: key);

  @override
  _PhoneCodeEnterState createState() => _PhoneCodeEnterState();
}

class _PhoneCodeEnterState extends State<PhoneCodeEnter> {
  TextEditingController codeController =
      new MaskedTextController(mask: '0-0-0-0-0-0');
  var firebaseAuth = FirebaseAuth.instance;
  String status = '';
  static String actualCode;
  String errorMessage;
  
  void signInWithPhoneNumber(String smsCode) async {
    
    print('actualCode => ${widget.actualCode}');
    var _authCredential = PhoneAuthProvider.getCredential(
        // verificationId: "AM5PThCiQTTYmW-VO0z1KzAa1h1081DUzQRLH-4YAQi0nPT79E-4WKiAfkkPWN9Xkgbmvq6lfsWuP40NW70yh4T0-aVGRpQ0sPq2M3m4TVIE3fJZ3Wyq1Ua--lEpdXk8Ok5Yik9EPm4A", smsCode: smsCode.toString());
        verificationId: widget.actualCode.toString(),
        smsCode: smsCode.toString());
    firebaseAuth.signInWithCredential(_authCredential).catchError((error) {
      setState(() {
        status = 'Something has gone wrong, please try later';
      });
    }).then((user) {
      setState(() {
        SharedData.setDataTypeString('user', '${user.user.uid}').then((e) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => ProfilePage()),
              (Route<dynamic> route) => false);
        });

        print('uid>  ${user.user.uid}');
      });
    });
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
                        controller: codeController,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            errorText: errorMessage,
                            hintText: "Doğrulama Kodunu Giriniz",
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 14, vertical: 14),
                            focusedBorder: OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            border: InputBorder.none),
                        onChanged: (e) {},
                        textInputAction: TextInputAction.go,
                        obscureText: false,
                      ),
                    ),
                    // RaisedButton(
                    //   onPressed: () {
                    //     if ((codeController.text.length < 12)) {
                    //       setState(() {
                    //         errorMessage =
                    //             'Geçerli Bir Numara Giriniz ${codeController.text.length}';
                    //       });
                    //     } else {
                    //       setState(() {
                    //         errorMessage = null;
                    //         verify(codeController.text.replaceAll('-', ''));
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
                        if (codeController.text.length < 8) {
                          setState(() {
                            errorMessage = 'Geçerli bir doğrulma kodu giriniz';
                          });
                        } else {
                          signInWithPhoneNumber(
                              codeController.text.replaceAll('-', ''));
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
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
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
