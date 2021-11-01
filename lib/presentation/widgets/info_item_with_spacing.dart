import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoItemWithSpacing extends StatelessWidget {
  InfoItemWithSpacing(
      {this.name = 'name',
      this.info = 'info',
      this.isClickable = false,
      this.modalWidget,
      this.infoWidget,
      this.infoWidth,
      this.infoColor,
      this.infoDecoration,
      this.space = 10.0});
  final String name;
  final String info;
  final bool isClickable;
  final Widget? modalWidget;
  final Widget? infoWidget;
  final double? infoWidth;
  final Color? infoColor;
  final TextDecoration? infoDecoration;
  final double? space;

  void _showModal(BuildContext context) async {
    showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 0),
      context: context,
      pageBuilder: (BuildContext context, anim1, anim2) {
        return Align(
          alignment: Alignment.center,
          child: modalWidget,
        );
      },
      transitionBuilder:
          (BuildContext context, anim1, Animation<double> anim2, Widget child) {
        return SlideTransition(
          position:
              Tween<Offset>(begin: const Offset(0, 1), end: const Offset(0, 0))
                  .animate(anim1),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 8,
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          name,
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: space),
        infoWidget ??
            InkWell(
              onTap: () => isClickable && modalWidget != null
                  ? _showModal(context)
                  : null,
              child: SizedBox(
                width: infoWidth ?? 100,
                child: Text(
                  info,
                  overflow: TextOverflow.clip,
                  maxLines: 3,
                  textAlign: TextAlign.left,
                  style: isClickable
                      ? TextStyle(
                          fontSize: 13,
                          color: infoColor != null ? infoColor : Colors.blue,
                          decoration: infoDecoration != null
                              ? infoDecoration
                              : TextDecoration.underline)
                      : TextStyle(
                          fontSize: 13,
                          color: infoColor != null ? infoColor : Colors.black),
                ),
              ),
            ),
      ]),
    );
  }
}
