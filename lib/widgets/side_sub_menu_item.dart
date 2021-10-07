import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SideSubMenuItem extends StatefulWidget {
  const SideSubMenuItem({
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
  State<SideSubMenuItem> createState() => _SideSubMenuItemState();
}

class _SideSubMenuItemState extends State<SideSubMenuItem> {
  @override
  Widget build(BuildContext context) {
    TextStyle roboto = GoogleFonts.roboto();

    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        color: widget.isSelected ? const Color(0xffECECEC) : Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  widget.icon,
                  const SizedBox(width: 5),
                  Text(widget.title, style: roboto.copyWith(fontSize: 14)),
                ],
              ),
            ),
            const Divider(height: 0),
          ],
        ),
      ),
    );
  }
}
