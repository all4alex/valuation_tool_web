import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoItemWithSpacing extends StatelessWidget {
  InfoItemWithSpacing(
      {this.name = 'name', this.info = 'info', this.isClickable = false});
  final String name;
  final String info;
  final bool isClickable;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 8,
      ),
      child: Row(children: [
        Text(
          name,
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 20),
        Text(
          info,
          overflow: TextOverflow.clip,
          textAlign: TextAlign.left,
          style: isClickable
              ? TextStyle(
                  fontSize: 13,
                  color: Colors.blue,
                  decoration: TextDecoration.underline)
              : TextStyle(
                  fontSize: 13,
                ),
        ),
      ]),
    );
  }
}
