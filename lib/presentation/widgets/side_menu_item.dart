import 'package:flutter/material.dart';

class SideMenuItem extends StatefulWidget {
  const SideMenuItem({
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.onPressed,
    Key? key,
  }) : super(key: key);
  final Widget icon;
  final String title;
  final bool isSelected;
  final Function() onPressed;
  @override
  State<SideMenuItem> createState() => _SideMenuItemState();
}

class _SideMenuItemState extends State<SideMenuItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        decoration: widget.isSelected
            ? const BoxDecoration(
                border: Border(
                  left: BorderSide(width: 5.0, color: Color(0xff18A0FB)),
                ),
                color: Color(0xffD9DBE1),
              )
            : null,
        child: Column(
          children: <Widget>[
            widget.icon,
            const SizedBox(height: 10),
            Text(widget.title, style: const TextStyle(fontSize: 12))
          ],
        ),
      ),
    );
  }
}
