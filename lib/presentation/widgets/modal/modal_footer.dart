import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ModalFooter extends StatelessWidget {
  final Function() onSave;
  final Color? color;
  final String submitName;
  final IconData? icon;

  const ModalFooter(
      {Key? key,
      required this.onSave,
      this.color,
      required this.submitName,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(5),
        ),
        color: Color(0xffFFFFFF),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Color(0xffE6E6E6),
              offset: Offset(0.0, 1.0),
              blurRadius: 6.0,
              spreadRadius: 0),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.close, color: Colors.red),
                  Text('  CANCEL', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: color != null ? color : Color(0xff17A0FB),
              ),
              onPressed: onSave,
              child: Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icon != null ? icon : Icons.save,
                      color: Colors.white,
                      size: 16,
                    ),
                    Text('  $submitName',
                        style: TextStyle(color: Colors.white, fontSize: 15)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
