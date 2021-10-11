import 'package:flutter/material.dart';

//This widget is used to view CMS banners
//This widget contains PageView and PageView indicator
class BlackBookPageView extends StatefulWidget {
  const BlackBookPageView({required this.listOfPage});
  final List<Widget> listOfPage;

  @override
  _BlackBookPageViewState createState() => _BlackBookPageViewState();
}

class _BlackBookPageViewState extends State<BlackBookPageView> {
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        PageView(
            physics: PageScrollPhysics(),
            children: widget.listOfPage,
            onPageChanged: (int page) {
              print('CURRENT PAGE');
              setState(() {
                currentPage = page;
              });
            }),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for (int i = 0; i < widget.listOfPage.length; i++)
                    if (i == currentPage) ...<Widget>[circleBar(true)] else
                      circleBar(false),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget circleBar(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      height: 9,
      width: 9,
      decoration: BoxDecoration(
          color: isActive
              ? const Color(0xff4A8DE0)
              : const Color(0xff4A8DE0).withOpacity(.6),
          borderRadius: const BorderRadius.all(Radius.circular(12))),
    );
  }
}
