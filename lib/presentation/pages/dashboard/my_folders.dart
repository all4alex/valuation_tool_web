import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyFolders extends StatefulWidget {
  MyFolders({Key? key}) : super(key: key);

  @override
  State<MyFolders> createState() => _MyFoldersState();
}

class _MyFoldersState extends State<MyFolders> {
  PageController pageController1 = PageController();

  PageController pageController2 = PageController();

  PageController pageController3 = PageController();

  final folders = [
    {
      'name': 'ACURA ILX Base Clean 1',
    },
    {
      'name': 'ACURA ILX Base Clean 2',
    },
    {
      'name': 'ACURA ILX Base Clean 3',
    },
    {
      'name': 'ACURA ILX Base Clean 4',
    },
    {
      'name': 'ACURA ILX Base Clean 5',
    },
    {
      'name': 'ACURA ILX Base Clean 6',
    },
    {
      'name': 'ACURA ILX Base Clean 7',
    },
    {
      'name': 'ACURA ILX Base Clean 7',
    },
    {
      'name': 'ACURA ILX Base Clean 7',
    },
    {
      'name': 'ACURA ILX Base Clean 7',
    },
    {
      'name': 'ACURA ILX Base Clean 7',
    },
    {
      'name': 'ACURA ILX Base Clean 7',
    },
    {
      'name': 'ACURA ILX Base Clean 7',
    },
    {
      'name': 'ACURA ILX Base Clean 7',
    },
    {
      'name': 'ACURA ILX Base Clean 7',
    },
    {
      'name': 'ACURA ILX Base Clean 7',
    },
    {
      'name': 'ACURA ILX Base Clean 7',
    },
  ];

  final folders2 = [
    {
      'name': 'ACURA ILX Base Clean 1',
    },
    {
      'name': 'ACURA ILX Base Clean 2',
    },
  ];

  final folders3 = [
    {
      'name': 'ACURA ILX Base Clean 1',
    },
    {
      'name': 'ACURA ILX Base Clean 2',
    },
    {
      'name': 'ACURA ILX Base Clean 3',
    },
    {
      'name': 'ACURA ILX Base Clean 4',
    },
    {
      'name': 'ACURA ILX Base Clean 5',
    },
    {
      'name': 'ACURA ILX Base Clean 6',
    },
    {
      'name': 'ACURA ILX Base Clean 7',
    },
  ];
  int currentPage1 = 0;
  int currentPage2 = 0;
  int currentPage3 = 0;

  Widget circleBar(bool isActive, PageController pageController, int index) {
    return InkWell(
      onTap: () async {
        if (pageController == pageController1) {
          await pageController1.animateToPage(
            index,
            curve: Curves.easeIn,
            duration: Duration(milliseconds: 300),
          );
        }
        if (pageController == pageController2) {
          await pageController2.animateToPage(
            index,
            curve: Curves.easeIn,
            duration: Duration(milliseconds: 300),
          );
        }
        if (pageController == pageController3) {
          await pageController3.animateToPage(
            index,
            curve: Curves.easeIn,
            duration: Duration(milliseconds: 300),
          );
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        height: 5,
        width: 5,
        decoration: BoxDecoration(
            color: isActive ? const Color(0xff494949) : const Color(0xffC4C4C4),
            borderRadius: const BorderRadius.all(Radius.circular(12))),
      ),
    );
  }

  Widget folderItem(Size size, String folderName, int folderCount, List chunks,
      PageController pageController, int currentPage) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  height: 15,
                  width: 30,
                  child: SvgPicture.asset('assets/svg/folder_icon.svg',
                      color: Color(0xff36334E), fit: BoxFit.fitHeight),
                ),
                Text(
                  '$folderName ',
                ),
                Text(
                  '($folderCount)',
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
            folderCount > 3
                ? Text(
                    'VIEW ALL',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 13,
                        fontWeight: FontWeight.w500),
                  )
                : Container(),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Stack(
          children: [
            SizedBox(
              height: 130.0,
              child: PageView(
                  key: Key(folderName),
                  physics: PageScrollPhysics(),
                  controller: pageController,
                  children: chunks.map<Widget>((e) {
                    return Row(
                      children: e.map<Widget>((e) {
                        return folderCard(size, e['name']);
                      }).toList(),
                    );
                  }).toList(),
                  onPageChanged: (int page) {
                    if (pageController == pageController1) {
                      setState(() {
                        currentPage1 = page;
                      });
                    }
                    if (pageController == pageController2) {
                      setState(() {
                        currentPage2 = page;
                      });
                    }
                    if (pageController == pageController3) {
                      setState(() {
                        currentPage3 = page;
                      });
                    }
                  }),
            ),
            folderCount > 3
                ? Positioned(
                    right: 0,
                    bottom: 50,
                    child: InkWell(
                      onTap: () {
                        pageController.nextPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeIn);
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.0, 1.0), //(x,y)
                                blurRadius: 6.0,
                                spreadRadius: 0),
                          ],
                        ),
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 12,
                        ),
                      ),
                    ),
                  )
                : Container(),
            pageController.initialPage != 0 && folderCount > 3
                ? Positioned(
                    left: 0,
                    bottom: 50,
                    child: InkWell(
                      onTap: () {
                        pageController.previousPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeIn);
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.0, 1.0), //(x,y)
                                blurRadius: 6.0,
                                spreadRadius: 0),
                          ],
                        ),
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 12,
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        pageController1 == pageController
            ? Container(
                margin: const EdgeInsets.only(bottom: 0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    for (int i = 0; i < chunks.length; i++)
                      if (i == currentPage1) ...<Widget>[
                        circleBar(true, pageController, i)
                      ] else
                        circleBar(false, pageController, i),
                  ],
                ),
              )
            : Container(),
        pageController2 == pageController
            ? Container(
                margin: const EdgeInsets.only(bottom: 0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    for (int i = 0; i < chunks.length; i++)
                      if (i == currentPage2) ...<Widget>[
                        circleBar(true, pageController, i)
                      ] else
                        circleBar(false, pageController, i),
                  ],
                ),
              )
            : Container(),
        pageController3 == pageController
            ? Container(
                margin: const EdgeInsets.only(bottom: 0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    for (int i = 0; i < chunks.length; i++)
                      if (i == currentPage3) ...<Widget>[
                        circleBar(true, pageController, i)
                      ] else
                        circleBar(false, pageController, i),
                  ],
                ),
              )
            : Container(),
      ],
    );
  }

  Widget folderCard(Size size, String name) {
    return Card(
      shadowColor: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          width: size.width / 6.9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '2018',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff898989),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.clip,
                        fontSize: 14),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'WVWAR71K27W181757',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xff898989),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '9-28-2021',
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              Icon(Icons.more_horiz),
            ],
          ),
        ),
      ),
    );
  }

  List<List<T>> _generateChunks<T>(List<T> inList, int chunkSize) {
    List<List<T>> outList = [];
    List<T> tmpList = [];
    int counter = 0;

    for (int current = 0; current < inList.length; current++) {
      if (counter != chunkSize) {
        tmpList.add(inList[current]);
        counter++;
      }
      if (counter == chunkSize || current == inList.length - 1) {
        outList.add(tmpList.toList());
        tmpList.clear();
        counter = 0;
      }
    }

    return outList;
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    int chunkSize = 4;
    List<List<dynamic>> chunks = _generateChunks(folders, chunkSize);
    List<List<dynamic>> chunks2 = _generateChunks(folders2, chunkSize);
    List<List<dynamic>> chunks3 = _generateChunks(folders3, chunkSize);
    // print(chunks);
    return Container(
      height: screenSize.height / 1,
      width: screenSize.width / 1.4,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: const BoxDecoration(
        color: Color(0xffF3F3F3),
        borderRadius: BorderRadius.all(Radius.circular(5)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
              spreadRadius: 0),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 50,
            alignment: Alignment.center,
            padding: EdgeInsets.all(15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'My Folders',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 15,
                    width: 15,
                    alignment: Alignment.bottomRight,
                    padding: EdgeInsets.zero,
                    child: SvgPicture.asset('assets/svg/sort_desc_icon.svg'),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 0),
          Expanded(
              flex: 1,
              child: ListView(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: Column(
                      children: [
                        folderItem(screenSize, 'Orem Location', folders.length,
                            chunks, pageController1, currentPage1),
                        SizedBox(
                          height: 30,
                        ),
                        folderItem(
                            screenSize,
                            'Manheim Riverside',
                            folders2.length,
                            chunks2,
                            pageController2,
                            currentPage2),
                        SizedBox(
                          height: 30,
                        ),
                        folderItem(
                            screenSize,
                            'Manheim Southern Cal',
                            folders3.length,
                            chunks3,
                            pageController3,
                            currentPage3),
                      ],
                    ),
                  ),
                ],
              )),
          SizedBox(
            height: 30,
          ),
          const Divider(),
          SizedBox(
            height: 5,
          ),
          Text(
            'VIEW ALL LISTS',
            style: TextStyle(
                color: Colors.blue, fontSize: 13, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}
