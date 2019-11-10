import "package:flutter/material.dart";


class GradientAppBar extends StatelessWidget {

  final Widget leftIcon;
  final Widget centerIcon;
  final Widget rightIcon;
  final double barHeight = 70.0;

  GradientAppBar({this.leftIcon, this.centerIcon, this.rightIcon});

  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery
        .of(context)
        .padding
        .top;

    return Container(
      padding: EdgeInsets.only(top: statusbarHeight,left: 10,right: 10),
      height: statusbarHeight + barHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          leftIcon,
          centerIcon,
          rightIcon
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomRight:Radius.circular(20),bottomLeft: Radius.circular(20)),
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
    );
  }
}