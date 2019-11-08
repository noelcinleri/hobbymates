import 'package:flutter/material.dart';

class HobbySelect extends StatefulWidget {
  HobbySelect({Key key}) : super(key: key);

  @override
  _HobbySelectState createState() => _HobbySelectState();
}

class _HobbySelectState extends State<HobbySelect> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height/4,
                color: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }
}