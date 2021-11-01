import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class ModalHeader extends StatelessWidget {
  final String? title;
  final String? subTitle;

  const ModalHeader({required this.title, required this.subTitle, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title!,
            style: GoogleFonts.roboto(
                fontSize: 20,
                color: Color(0xff191919),
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 5,
          ),
          Text(subTitle!,
              style: GoogleFonts.roboto(fontSize: 14, color: Color(0xff191919)))
        ],
      ),
    );
  }
}
