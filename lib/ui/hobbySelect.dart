import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hobby_mates/utils/Firestore.dart';

class HobbySelect extends StatefulWidget {
  HobbySelect({Key key}) : super(key: key);

  @override
  _HobbySelectState createState() => _HobbySelectState();
}

class _HobbySelectState extends State<HobbySelect>
    with TickerProviderStateMixin {
  List<FireStoreHobby> hobbies = List();
  List<Widget> hobbiesWidget = List();
  bool loading = true;
  
  getDatas() {
    Firestore.instance
        .collection('hobbies')
        .orderBy('hobi_ID')
        .getDocuments()
        .then((query) {
      List<DocumentSnapshot> documents = query.documents;
      for (DocumentSnapshot document in documents) {
        var n = FireStoreHobby(document.documentID, document.data['hobi_ID'],
            document.data['imgUrl']);
        hobbies.add(n);
        UserHobbies.selectedList.add(false);
      }
      setState(() {
        loading = false;
      });
    });
  }

  @override
  void initState() {
    getDatas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: false,
        child: !loading
            ? Scaffold(
                body: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Text(
                            'İlgilendiğiniz Hobileri Seçiniz',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        height: MediaQuery.of(context).size.height * 4 / 25,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 161, 87, 226),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(40),
                                bottomRight: Radius.circular(40))),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 50,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 17 / 25,
                        child: GridView.builder(
                            itemCount: hobbies.length,
                            gridDelegate:
                                new SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemBuilder: (BuildContext context, int index) {
                              return Center(
                                child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        UserHobbies.selectedList[index] =
                                            !UserHobbies.selectedList[index];
                                      });
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          3 /
                                          7,
                                      height:
                                          MediaQuery.of(context).size.width *
                                                  3 /
                                                  7 -
                                              25,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: hobbies[index].url != null &&
                                                    hobbies[index]
                                                        .url
                                                        .isNotEmpty
                                                ? NetworkImage(
                                                    hobbies[index].url)
                                                : NetworkImage(
                                                    'https://1.bp.blogspot.com/-CzmfcShGRa4/Wbzy08PDu9I/AAAAAAAADKA/yin4j9C-ZlUpoUlKQKcgjYCHGyD8Wz0wwCLcBGAs/s1600/astronomi.jpg'),
                                          ),
                                          borderRadius:
                                              BorderRadiusDirectional.circular(
                                                  15)),
                                      child: Center(
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              3 /
                                              7,
                                          height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  3 /
                                                  7 -
                                              25,
                                          decoration: BoxDecoration(
                                              color: UserHobbies
                                                      .selectedList[index]
                                                  ? Color.fromARGB(
                                                          255, 161, 87, 226)
                                                      .withAlpha(255).withOpacity(0.6)
                                                  : Color.fromARGB(
                                                          255, 161, 87, 226)
                                                      .withAlpha(230).withOpacity(0.6),
                                              borderRadius:
                                                  BorderRadiusDirectional
                                                      .circular(15)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    5, 0, 5, 0),
                                                child: Text(
                                                    '${hobbies[index].hobbyName}',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              UserHobbies.selectedList[index]
                                                  ? Icon(
                                                      Icons
                                                          .check_circle_outline,
                                                      color: Colors.white,
                                                      size: 35,
                                                    )
                                                  : SizedBox(
                                                      height: 0.1,
                                                    )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )),
                              );
                            }),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 100,
                      ),
                      RaisedButton(
                        onPressed: () {
                          int index = 0;
                          for (bool item in UserHobbies.selectedList) {
                            if (item) {
                              print('${index+1}. hobby eklendi');
                              Data.setHobbyMaters(hobbies[index].hobbyName);
                            }
                            index++;
                          }
                          Navigator.pushNamedAndRemoveUntil(context, '/main',(Route<dynamic> r)=>false);
                        },
                        color: Color.fromARGB(255, 161, 87, 226),
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.white)),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 7 / 15,
                          child: Text(
                            'TAMAMLA',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 100,
                      ),
                    ],
                  ),
                ),
              )
            : Container(
                color: Colors.white,
                child: Center(
                    child: Image.asset(
                  'assets/loading.gif',
                  width: 60,
                )),
              ));
  }
}

class UserHobbies {
  static List<bool> selectedList = List();
}
