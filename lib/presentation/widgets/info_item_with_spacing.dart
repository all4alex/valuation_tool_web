import 'package:flutter/cupertino.dart';

class InfoItemWithSpacing extends StatelessWidget {
  InfoItemWithSpacing(this.name, this.info);
  final String name;
  final String info;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 8,
      ),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
            ),
            Text(
              info,
              overflow: TextOverflow.clip,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
          ]),
    );
  }
}
