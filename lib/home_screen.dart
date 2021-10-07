import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:valuation_tool_web/widgets/folder_menu_item.dart';
import 'package:valuation_tool_web/widgets/side_menu_item.dart';
import 'package:valuation_tool_web/widgets/side_sub_menu_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isAppraisalSelected = true;
  bool isListSelected = false;
  bool isSettingsSelected = false;

  bool subItem1 = true;
  bool subItem2 = false;
  bool subItem3 = false;
  bool subItem4 = false;

  TextStyle roboto = GoogleFonts.roboto();
  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xffD9DBE1),
      body: Row(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                  height: screenSize.height,
                  width: screenSize.width / 5.5,
                  margin: EdgeInsets.only(left: screenSize.width / 20),
                  padding: const EdgeInsets.only(top: 10),
                  decoration: const BoxDecoration(
                    color: Color(0xffF3F3F3),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 6.0,
                          spreadRadius: 0),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      Visibility(
                        visible: !isListSelected,
                        child: Column(
                          children: [
                            Container(
                                padding: const EdgeInsets.all(10),
                                alignment: Alignment.centerLeft,
                                child: Text('Navigation',
                                    style: roboto.copyWith(fontSize: 20))),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Divider(height: 0),
                            ),
                            SideSubMenuItem(
                              icon: SvgPicture.asset(
                                  'assets/svg/vehicle_icon.svg'),
                              title: 'All Vehicles',
                              isSelected: subItem1,
                              onPressed: () {
                                setState(() {
                                  subItem1 = true;
                                  subItem2 = false;
                                  subItem3 = false;
                                  subItem4 = false;
                                });
                              },
                            ),
                            SideSubMenuItem(
                              icon: SvgPicture.asset(
                                  'assets/svg/search_icon.svg'),
                              title: 'Search Vehicle',
                              isSelected: subItem2,
                              onPressed: () {
                                setState(() {
                                  subItem1 = false;
                                  subItem2 = true;
                                  subItem3 = false;
                                  subItem4 = false;
                                });
                              },
                            ),
                            SideSubMenuItem(
                              icon: SvgPicture.asset(
                                  'assets/svg/appraisals_icon.svg'),
                              title: 'Vehicle Appraisals',
                              isSelected: subItem3,
                              onPressed: () {
                                setState(() {
                                  subItem1 = false;
                                  subItem2 = false;
                                  subItem3 = true;
                                  subItem4 = false;
                                });
                              },
                            ),
                            SideSubMenuItem(
                              icon: SvgPicture.asset(
                                  'assets/svg/recent_search_icon.svg'),
                              title: 'Recent Vehicle Appraisals',
                              isSelected: subItem4,
                              onPressed: () {
                                setState(() {
                                  subItem1 = false;
                                  subItem2 = false;
                                  subItem3 = false;
                                  subItem4 = true;
                                });
                              },
                            ),
                            const SizedBox(height: 30),
                            ElevatedButton(
                              style: style,
                              onPressed: () {},
                              child: SizedBox(
                                width: 170,
                                height: 40,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 15,
                                      width: 40,
                                      child: SvgPicture.asset(
                                        'assets/svg/vehicle_add_icon.svg',
                                        color: Colors.white,
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                    const Text('ADD VEHICLE',
                                        style: TextStyle(fontSize: 12)),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.all(10),
                          alignment: Alignment.centerLeft,
                          child: Text('My Lists',
                              style: roboto.copyWith(fontSize: 20))),
                      FolderMenuItem(
                        icon: SvgPicture.asset('assets/svg/folder_icon.svg'),
                        title: 'Orem Location',
                        isSelected: false,
                        folderCount: 43,
                        onPressed: () {},
                      ),
                      FolderMenuItem(
                        icon: SvgPicture.asset('assets/svg/folder_icon.svg'),
                        title: 'Manheim Riverside',
                        isSelected: false,
                        folderCount: 23,
                        onPressed: () {},
                      ),
                      FolderMenuItem(
                        icon: SvgPicture.asset('assets/svg/folder_icon.svg'),
                        title: 'Manheim Southern Cal',
                        isSelected: false,
                        folderCount: 10,
                        onPressed: () {},
                      ),
                      FolderMenuItem(
                        icon: SvgPicture.asset('assets/svg/folder_icon.svg'),
                        title: 'Lehi Listing',
                        isSelected: false,
                        folderCount: 3,
                        onPressed: () {},
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        style: style,
                        onPressed: () {},
                        child: SizedBox(
                          width: 170,
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: 15,
                                width: 40,
                                child: SvgPicture.asset(
                                  'assets/svg/folder_add_icon.svg',
                                  color: Colors.white,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              const Text('ADD LIST',
                                  style: TextStyle(fontSize: 12)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  )),
              Container(
                  height: screenSize.height,
                  width: screenSize.width / 20,
                  padding: const EdgeInsets.only(top: 20),
                  margin: const EdgeInsets.only(
                      right: 6.0), //Same as `blurRadius` i guess
                  decoration: const BoxDecoration(
                    color: Color(0xffF3F3F3),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 6.0,
                          spreadRadius: 0),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      SideMenuItem(
                        icon: SvgPicture.asset('assets/svg/appraisal_icon.svg'),
                        title: 'Appraisal',
                        isSelected: isAppraisalSelected,
                        onPressed: () {
                          setState(() {
                            isAppraisalSelected = true;
                            isListSelected = false;
                            isSettingsSelected = false;
                          });
                        },
                      ),
                      SideMenuItem(
                        icon: SvgPicture.asset(
                          'assets/svg/heart_icon.svg',
                        ),
                        title: 'My List',
                        isSelected: isListSelected,
                        onPressed: () {
                          setState(() {
                            isAppraisalSelected = false;
                            isListSelected = true;
                            isSettingsSelected = false;
                          });
                        },
                      ),
                      SideMenuItem(
                        icon: SvgPicture.asset('assets/svg/settings_icon.svg'),
                        title: 'Preference',
                        isSelected: isSettingsSelected,
                        onPressed: () {
                          setState(() {
                            isAppraisalSelected = false;
                            isListSelected = false;
                            isSettingsSelected = true;
                          });
                        },
                      ),
                    ],
                  )),
            ],
          ),
          VehicleList(screenSize: screenSize)
        ],
      ),
    );
  }
}

class VehicleList extends StatelessWidget {
  const VehicleList({
    Key? key,
    required this.screenSize,
  }) : super(key: key);

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenSize.height,
      width: screenSize.width / 1.4,
      margin: const EdgeInsets.only(top: 10, bottom: 10, left: 20),
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
              height: 60,
              alignment: Alignment.center,
              padding: EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text('All Vehicles'),
                  const Text(' (35)', style: TextStyle(color: Colors.red)),
                  VerticalDivider(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                          height: 15,
                          width: 30,
                          child: SvgPicture.asset(
                              'assets/svg/vehicle_add_icon.svg',
                              fit: BoxFit.fitHeight)),
                      Text('Add Vehicle', textAlign: TextAlign.center)
                    ],
                  ),
                  Expanded(
                      flex: 1,
                      child: Container(
                        height: 15,
                        width: 15,
                        alignment: Alignment.bottomRight,
                        padding: EdgeInsets.zero,
                        child:
                            SvgPicture.asset('assets/svg/sort_desc_icon.svg'),
                      )),
                ],
              )),
          Divider(
            height: 0,
          ),
          Expanded(
            flex: 1,
            child: ListView.builder(
                itemCount: 20,
                itemBuilder: (BuildContext context, int i) {
                  return Container(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
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
                                      child: Image.asset(
                                          'assets/images/sample_vehicle.png',
                                          fit: BoxFit.fitHeight)),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const <Widget>[
                                      Text('2018 ACURA ILX Base Clean',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14)),
                                      Text('NX 300 - NX 300 FWD',
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Color(0xff898989))),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('19UDE2F35JA000993'),
                                  SizedBox(
                                      height: 15,
                                      width: 30,
                                      child: SvgPicture.asset(
                                          'assets/svg/copy_icon.svg',
                                          color: Colors.green,
                                          fit: BoxFit.fitHeight)),
                                ],
                              ),
                              Text('22,383 miles'),
                              Text('9/24/21'),
                              Row(
                                children: [
                                  SizedBox(
                                      height: 15,
                                      width: 30,
                                      child: SvgPicture.asset(
                                          'assets/svg/folder_icon.svg',
                                          color: Color(0xff36334E),
                                          fit: BoxFit.fitHeight)),
                                  Text('Orem Location')
                                ],
                              ),
                              SizedBox(
                                  height: 15,
                                  width: 30,
                                  child: SvgPicture.asset(
                                      'assets/svg/preference_icon.svg',
                                      color: Color(0xff494949),
                                      fit: BoxFit.fitHeight)),
                            ],
                          ),
                          const Divider()
                        ],
                      ));
                }),
          ),
        ],
      ),
    );
  }
}
