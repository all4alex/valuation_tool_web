import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyFolders extends StatelessWidget {
  const MyFolders({Key? key}) : super(key: key);

  Widget folderItem(Size size, String folderName, int folderCount) {
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
            Text(
              'VIEW ALL',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 13,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            folderCard(size),
            folderCard(size),
            folderCard(size),
            folderCard(size),
          ],
        ),
      ],
    );
  }

  Widget folderCard(Size size) {
    return Card(
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
                    'ACURA ILX Base Clean',
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

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    print(screenSize.width / 4);
    return Container(
      height: screenSize.height / 1.1,
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
            child: Container(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Column(
                children: [
                  folderItem(screenSize, 'Orem Location', 7),
                  SizedBox(
                    height: 30,
                  ),
                  folderItem(screenSize, 'Manheim Riverside', 2),
                  SizedBox(
                    height: 30,
                  ),
                  folderItem(screenSize, 'Manheim Southern Cal', 7),
                ],
              ),
            ),
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
