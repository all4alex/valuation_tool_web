import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RecentlyViewedVehicles extends StatelessWidget {
  const RecentlyViewedVehicles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height / 1.25,
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
                  'Recently Viewed Vehicles',
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
            child: ListView.builder(
              itemCount: 5,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int i) {
                return InkWell(
                  onTap: () {},
                  child: Container(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: screenSize.width * .24,
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                      height: 68,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          color: const Color(0xffF3F3F3),
                                          border: Border.all(
                                              width: 1,
                                              style: BorderStyle.solid,
                                              color: Colors.black)),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.fitHeight,
                                        imageUrl: '',
                                        // '${vehicleItem.imageUrl}_200x200',
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                                'assets/images/no_image.jpeg'),
                                      )),
                                  const SizedBox(width: 10),
                                  Container(
                                    width: screenSize.width * .15,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          '2018 ACURA ILX Base Clean',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              overflow: TextOverflow.clip,
                                              fontSize: 14),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          'NX 300 - NX 300 FWD',
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Color(0xff898989),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: screenSize.width * .14,
                              alignment: Alignment.centerLeft,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('WVWAR71K27W181757'),
                                  SizedBox(
                                      height: 15,
                                      width: 30,
                                      child: SvgPicture.asset(
                                          'assets/svg/copy_icon.svg',
                                          color: Colors.green,
                                          fit: BoxFit.fitHeight)),
                                ],
                              ),
                            ),
                            Container(
                                width: screenSize.width * .08,
                                alignment: Alignment.centerLeft,
                                child: Text('22,383 miles',
                                    style: TextStyle(
                                        overflow: TextOverflow.clip))),
                            Container(
                                width: screenSize.width * .08,
                                alignment: Alignment.centerLeft,
                                child: Text('9/24/21',
                                    style: TextStyle(
                                        overflow: TextOverflow.clip))),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                width: screenSize.width * .12,
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    SizedBox(
                                        height: 15,
                                        width: 30,
                                        child: SvgPicture.asset(
                                            'assets/svg/folder_icon.svg',
                                            color: Color(0xff36334E),
                                            fit: BoxFit.fitHeight)),
                                    SizedBox(
                                      width: screenSize.width * .09,
                                      child: Text('Orem Location',
                                          style: TextStyle(
                                              overflow: TextOverflow.clip)),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              child: PopupMenuButton(
                                tooltip: 'Show options',
                                onSelected: (selected) {},
                                elevation: 3.2,
                                child: Padding(
                                  padding: EdgeInsets.zero,
                                  child: Icon(Icons.settings,
                                      color: Color(0xff494949)),
                                ),
                                // child: null,
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    value: 'view',
                                    child: Row(
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.eye,
                                          color: Colors.green,
                                          size: 15,
                                        ),
                                        Text(
                                          '  View Vehicle',
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: 'remove',
                                    child: Row(
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.trash,
                                          color: Colors.red,
                                          size: 15,
                                        ),
                                        Text(
                                          '  Remove Vehicle',
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(),
          SizedBox(
            height: 5,
          ),
          Text(
            'VIEW VEHICLES',
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
