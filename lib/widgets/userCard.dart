import 'package:flutter/material.dart';
import 'package:hobby_mates/utils/utils.dart';

class UserCard extends StatefulWidget {
  final String name;
  final Function func;
  UserCard({Key key, this.name, this.func}) : super(key: key);

  @override
  UserCardState createState() => UserCardState();
}

class UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Card(
              color: Colors.white,
              borderOnForeground: true,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              elevation: 10,
              child: Column(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    child: Container(
                      color: AppColor.mainColor,
                      height: 250,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '${widget.name}',
                          style: TextStyle(
                              color: AppColor.mainColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        GestureDetector(
                          onTap: () {
                            widget.func();
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 5),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: AppColor.mainColor,
                                  borderRadius: BorderRadius.circular(15)),
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(5, 7, 5, 7),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Mesaj At',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                    ),
                                    SizedBox(
                                      width: 18,
                                    ),
                                    Icon(
                                      Icons.send,
                                      color: Colors.white,
                                      size: 28,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
