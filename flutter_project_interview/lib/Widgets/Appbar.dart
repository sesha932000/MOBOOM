import 'package:flutter/material.dart';

AppBar buildAppBar() {
  return AppBar(
    elevation: 5,
    shadowColor: Colors.black,
    backgroundColor: Colors.white,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(
          Icons.menu,
          color: Colors.black,
          size: 30,
        ),
        Container(
          padding: EdgeInsets.fromLTRB(0, 0, 120, 0),
          child: Text.rich(
            TextSpan(
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
              children: [
                TextSpan(text: 'M', style: TextStyle(color: Colors.pinkAccent)),
                TextSpan(
                  text: 'oBoo',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                TextSpan(text: 'M', style: TextStyle(color: Colors.pinkAccent)),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
