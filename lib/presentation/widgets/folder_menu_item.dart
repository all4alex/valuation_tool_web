import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FolderMenuItem extends StatefulWidget {
  const FolderMenuItem({
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.folderCount,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final Widget icon;
  final String title;
  final bool isSelected;
  final int folderCount;
  final Function() onPressed;

  @override
  State<FolderMenuItem> createState() => _FolderMenuItemState();
}

class _FolderMenuItemState extends State<FolderMenuItem> {
  @override
  Widget build(BuildContext context) {
    TextStyle roboto = GoogleFonts.roboto();

    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        width: 250,
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
                  Expanded(
                    flex: 1,
                    child: Text(widget.folderCount.toString(),
                        textAlign: TextAlign.end,
                        style:
                            roboto.copyWith(fontSize: 14, color: Colors.red)),
                  ),
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
