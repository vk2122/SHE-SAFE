// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_web_libraries_in_flutter, avoid_unnecessary_containers, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class UnderProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Container(
          width: width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(child: CircularProgressIndicator()),
                SizedBox(
                  height: height / 20,
                ),
                Container(
                  child: Text("Under Development"),
                ),
              ]),
        ),
      ),
    );
  }
}
