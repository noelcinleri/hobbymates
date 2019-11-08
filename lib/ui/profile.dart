import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hobby_mates/utils/Firestore.dart';
import 'package:hobby_mates/utils/shared.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ProfilePage extends StatefulWidget {
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();
  String uid;

  TextEditingController nameController = new TextEditingController();
  TextEditingController userNameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController numberController = new TextEditingController();

  String nameErrorText;
  String userNameErrorText;
  String emailErrorText;
  String numberErrorText;

  Future<File> imageFile;
 
  
  @override
  void initState() {
    connectionCheck();
    loadData().then((_uid){
      setState(() {
        uid = _uid;
      });
    });
    super.initState();
  }
  Future loadData() async {
    final kayitAraci = await SharedPreferences.getInstance();
    String _uid = kayitAraci.getString("user");
    uid = _uid;
    return _uid;
  }
  void connectionCheck() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      print("mobil conneciton");
    } else if (connectivityResult == ConnectivityResult.wifi) {
      print("wifi connection");
    } else {
      Alert(
        context: context,
        type: AlertType.info,
        style: AlertStyle(
          isCloseButton: false,
          isOverlayTapDismiss: false,
        ),
        title: "INTERNET BAĞLANTISI",
        desc:
            "İnternet bağlantısı yok. internet bağlantınızla \n beraber lütfen uygulamayı yeniden başlatın ",
        buttons: [
          DialogButton(
            child: Text(
              "TAMAM",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => exit(0),
            width: 120,
          )
        ],
      ).show();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    if(uid == null){
       return Scaffold(
         body: Container(
           child: Center(
             child: Image.asset('assets/loading.gif'),
           ),
         ),
       );
    }
    else{
      return StreamBuilder(
      stream: Firestore.instance.collection('users').document(uid).snapshots(),
      builder: (context,snap){
        if(!snap.hasData){
          return Scaffold(
         body: Container(
           child: Center(
             child: Image.asset('assets/loading.gif'),
           ),
         ),
       );
        }
        else{
          FirestoreData fdt= Data.documentToFirestoreData(snap.data);
          if(fdt.userName !=null && userNameController.text.isEmpty){
            userNameController.text = fdt.userName;
          }
          if(fdt.adSoyad !=null && userNameController.text.isEmpty){
            nameController.text = fdt.adSoyad;
          }
          if(fdt.mail !=null && userNameController.text.isEmpty){
            emailController.text = fdt.mail;
          }
          if(fdt.numara !=null && userNameController.text.isEmpty){
            numberController.text = fdt.numara;
          }
          return new Scaffold(
        body: SafeArea(
          bottom: false,
          child: new Container(
      color: Colors.white,
      child: new ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              new Container(
                height: 250.0,
                color: Colors.white,
                child: new Column(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(left: 20.0, top: 20.0),
                        child: new Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new GestureDetector(
                              onTap: ()=>Navigator.pushNamed(context, '/'),
                              child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black,
                              size: 22.0,
                            ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 25.0),
                              child: new Text('Profiliniz',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                      fontFamily: 'sans-serif-light',
                                      color: Colors.black)),
                            )
                          ],
                        )),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: new Stack(fit: StackFit.loose, children: <Widget>[
                        new Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Container(
                                width: 140.0,
                                height: 140.0,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                    image: new ExactAssetImage(
                                        'assets/profil.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ))
                          ],
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 90.0, right: 100.0),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new CircleAvatar(
                                  backgroundColor: Color.fromARGB(255, 161, 87, 226),
                                  radius: 25.0,
                                  child: new Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            )),
                      ]),
                    )
                  ],
                ),
              ),
              new Container(
                color: Color(0xffFFFFFF),
                child: Padding(
                  padding: EdgeInsets.only(bottom: 25.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'Hesap Bilgileri',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  _status ? _getEditIcon() : new Container(),
                                ],
                              )
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'Kullanıcı Adınız',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Flexible(
                                child: new TextField(
                                  controller: userNameController,
                                  decoration: InputDecoration(
                                    errorText: userNameErrorText,
                                    hintText: "Kullanıcı Adınızı Giriniz",
                                  ),
                                  enabled: !_status,
                                  autofocus: !_status,

                                ),
                              ),
                            ],
                          )),
                      
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'Adınızı Soyadınız',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Flexible(
                                child: new TextField(
                                  controller: nameController,
                                  decoration: InputDecoration(
                                    errorText: nameErrorText,
                                    hintText: "Adınızı ve Soyadınızı Giriniz",
                                  ),
                                  enabled: !_status,

                                ),
                              ),
                            ],
                          )),
                      
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'Email',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Flexible(
                                child: new TextField(
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration:  InputDecoration(
                                    errorText: emailErrorText,
                                      hintText: "Email Adresinizi Giriniz"),
                                  enabled: !_status,
                                ),
                              ),
                            ],
                          )),
                      
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'Telefon Numarası',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Flexible(
                                child: new TextField(
                                  controller: numberController,
                                  onChanged: (e){
                                    if(numberController.text.length > 10){
                                      numberErrorText = null;
                                    }
                                  },
                                  onEditingComplete: (){
                                    if(numberController.text.length < 10){
                                      numberErrorText = 'Hatalı Numara Girdiniz';
                                    }
                                    else{
                                      numberErrorText = null;
                                    }
                                  },
                                  keyboardType: TextInputType.phone,
                                  decoration:  InputDecoration(
                                    errorText: numberErrorText,
                                      hintText: "Telefon Numaranızı Giriniz"),
                                  enabled: !_status,
                                ),
                              ),
                            ],
                          )),
                      !_status ? _getActionButtons() : new Container(),
                      _landingPage(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    )
        ));
        }
      },
    );
    }
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Kaydet"),
                textColor: Colors.white,
                color: Colors.green,
                onPressed: () {
                  setState(() {
                    SharedData.getData('user').then((uid){
                      Data.createUser(uid, userNameController.text,nameController.text,emailController.text, numberController.text,18,[1]);
                    });
                    _status = true;
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Iptal"),
                textColor: Colors.white,
                color: Colors.red,
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _landingPage(){
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 20.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text('Tanıtım Sayfası'),
                textColor: Colors.white,
                color: Colors.red,
                onPressed: () {
                  setState(() {
                    Navigator.pushNamed(context, '/chat');
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }
  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Color.fromARGB(255, 161, 87, 226),
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }
}