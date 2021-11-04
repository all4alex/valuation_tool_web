import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:valuation_tool_web/bloc/folder/folder_bloc.dart';
import 'package:valuation_tool_web/bloc/folder/folder_state.dart';
import 'package:valuation_tool_web/bloc/vehicle_list/vehicle_list_bloc.dart';
import 'package:valuation_tool_web/main.dart';
import 'package:valuation_tool_web/models/firestore/folder_item.dart';
import 'package:valuation_tool_web/presentation/pages/HelpPage.dart';
import 'package:valuation_tool_web/presentation/pages/ProfilePage.dart';
import 'package:valuation_tool_web/presentation/pages/SettingsPage.dart';
import 'package:valuation_tool_web/presentation/pages/dashboard.dart';
import 'package:valuation_tool_web/presentation/pages/vin_page.dart';
import 'package:valuation_tool_web/presentation/widgets/add_vehicle_modal_body.dart';
import 'package:valuation_tool_web/presentation/widgets/folder_list.dart';
import 'package:valuation_tool_web/presentation/widgets/folder_menu_item.dart';
import 'package:valuation_tool_web/presentation/widgets/side_menu_item.dart';
import 'package:valuation_tool_web/presentation/widgets/side_sub_menu_item.dart';
import 'package:valuation_tool_web/presentation/pages/vehicle_list.dart';

import 'pages/vehicle_details/vehicle_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.page, this.extra})
      : super(key: key);
  final String page;
  final String? extra;
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
  String folderFilter = 'all';

  TextStyle roboto = GoogleFonts.roboto();
  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xfff5f7fd),
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
                                Navigator.pushNamed(context, '/main/vehicles',
                                    arguments: VehicleListArgs('All Vehicles'));
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
                              onPressed: () {
                                _showAddVehicleModal(context);
                              },
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
                      FolderList(),
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
          Container(
            color: Color(0xffD9DBE1),
            width: MediaQuery.of(context).size.width * 0.75,
            child: Center(
              child: IndexedStack(
                index: pages.indexOf(widget.page),
                children: [
                  Dashboard(),
                  VehicleList(
                      onItemSelect: (String vin) {
                        Navigator.pushNamed(context, '/main/details',
                            arguments: VehicleDetailsArgs(
                                vin: vin,
                                mileage: null,
                                uvc: null,
                                isNew: false));
                      },
                      onAddButtonClicked: (String folderName) {
                        _showAddVehicleWithDefaultFolderModal(
                            context, folderName);
                      },
                      folder: folderFilter,
                      onFolderDeleted: () {
                        Navigator.pushNamed(context, '/main/vehicles',
                            arguments: VehicleListArgs('All Vehicles'));
                      }),
                  VehicleList(
                      onItemSelect: (String vin) {
                        Navigator.pushNamed(context, '/main/details',
                            arguments: VehicleDetailsArgs(
                                vin: vin,
                                mileage: null,
                                uvc: null,
                                isNew: false));
                      },
                      onAddButtonClicked: (String folderName) {
                        _showAddVehicleWithDefaultFolderModal(
                            context, folderName);
                      },
                      folder: folderFilter,
                      onFolderDeleted: () {
                        Navigator.pushNamed(context, '/main/vehicles',
                            arguments: VehicleListArgs('All Vehicles'));
                      }),
                  VehicleDetails(
                    onAddSuccess: () {
                      BlocProvider.of<VehicleListBloc>(context)
                          .getVehicleList();
                    },
                  ),
                  Profile(),
                  Settings(),
                  Help(),
                  VinPage(
                    vin: widget.extra ?? '',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddVehicleModal(BuildContext context) async {
    showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 0),
      context: context,
      pageBuilder: (BuildContext context, anim1, anim2) {
        return Align(
            alignment: Alignment.center,
            child: AddVehicleModalBody(onDataFound: (String vin, String mileage,
                String categoryUVC, String selectedFolderName) {
              Navigator.pushNamed(context, '/main/details',
                  arguments: VehicleDetailsArgs(
                      mileage: mileage,
                      vin: vin,
                      uvc: categoryUVC,
                      isNew: true,
                      folderName: selectedFolderName));
            }));
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

  void _showAddVehicleWithDefaultFolderModal(
      BuildContext context, String folderName) async {
    showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 0),
      context: context,
      pageBuilder: (BuildContext context, anim1, anim2) {
        return Align(
            alignment: Alignment.center,
            child: AddVehicleModalBody(
              onDataFound: (String vin, String mileage, String categoryUVC,
                  String selectedFolderName) {
                Navigator.pushNamed(context, '/main/details',
                    arguments: VehicleDetailsArgs(
                        mileage: mileage,
                        vin: vin,
                        uvc: categoryUVC,
                        isNew: true,
                        folderName: selectedFolderName));
              },
              folderName: folderName,
            ));
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
}
