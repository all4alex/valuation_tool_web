import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:valuation_tool_web/main.dart';
import 'package:valuation_tool_web/pages/vehicle_details.dart';
import 'package:valuation_tool_web/pages/HelpPage.dart';
import 'package:valuation_tool_web/pages/HomePage.dart';
import 'package:valuation_tool_web/pages/ProfilePage.dart';
import 'package:valuation_tool_web/pages/SettingsPage.dart';
import 'package:valuation_tool_web/pages/vin_page.dart';
import 'package:valuation_tool_web/widgets/add_vehicle_modal_body.dart';
import 'package:valuation_tool_web/widgets/folder_menu_item.dart';
import 'package:valuation_tool_web/widgets/side_menu_item.dart';
import 'package:valuation_tool_web/widgets/side_sub_menu_item.dart';
import 'package:valuation_tool_web/widgets/vehicle_list.dart';

import 'bloc/folder/folder_bloc.dart';
import 'bloc/folder/folder_state.dart';
import 'bloc/vehicle_list/vehicle_list_bloc.dart';
import 'models/firestore/folder_item.dart';

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
  late FolderBloc folderBloc;
  List<FolderItem> folderItemList = <FolderItem>[];
  TextEditingController folderTextController = TextEditingController();
  @override
  void initState() {
    folderBloc = BlocProvider.of<FolderBloc>(context);
    folderBloc.getAllFolder();
    super.initState();
  }

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
                                Navigator.pushNamed(context, '/main/vehicles',
                                    arguments: VehicleListArgs('all'));
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
                                _showDialogModal(context);
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
                      Container(
                          padding: const EdgeInsets.all(10),
                          alignment: Alignment.centerLeft,
                          child: Text('My Lists',
                              style: roboto.copyWith(fontSize: 20))),
                      BlocBuilder<FolderBloc, FolderState>(
                          builder: (BuildContext context, FolderState state) {
                        if (state is GetFoldersSuccessState) {
                          folderItemList = state.list;
                        } else if (state is AddFolderLoadingState) {
                          return CircularProgressIndicator();
                        }
                        return Container(
                          height: screenSize.height * .3,
                          child: ListView.builder(
                              itemCount: folderItemList.length,
                              itemBuilder: (BuildContext context, int i) {
                                return FolderMenuItem(
                                  icon: SvgPicture.asset(
                                      'assets/svg/folder_icon.svg'),
                                  title: ' ${folderItemList[i].folderName}',
                                  isSelected: false,
                                  folderCount: folderItemList[i].folderCount!,
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, '/main/vehicles',
                                        arguments: VehicleListArgs(
                                            folderItemList[i].folderName));
                                  },
                                );
                              }),
                        );
                      }),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        style: style,
                        onPressed: () {
                          _showNewFolderModal(context);
                        },
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
          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            child: Center(
              child: IndexedStack(
                index: pages.indexOf(widget.page),
                children: [
                  VehicleList(
                      onItemSelect: (String vin) {
                        Navigator.pushNamed(context, '/main/details/$vin',
                            arguments: VehicleDetailsArgs(null));
                      },
                      onAddButtonClicked: () {
                        _showDialogModal(context);
                      },
                      folder: folderFilter),
                  Home(onPressed: () {
                    Navigator.pushNamed(context, '/main/${pages[5]}/Scott');
                  }),
                  VehicleDetails(widget.extra ?? '', onAddSuccess: () {
                    BlocProvider.of<VehicleListBloc>(context).getVehicleList();
                  }),
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

  void _showNewFolderModal(BuildContext context) async {
    showGeneralDialog(
      barrierDismissible: false,
      transitionDuration: const Duration(milliseconds: 0),
      context: context,
      pageBuilder: (BuildContext context, anim1, anim2) {
        return Align(
            alignment: Alignment.center,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                width: 570,
                height: 300,
                alignment: Alignment.center,
                child: Material(
                  child: Column(
                    children: <Widget>[
                      Container(
                          height: 70,
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          color: Colors.blue,
                          child: Text('Add Folder',
                              style: GoogleFonts.roboto(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white))),
                      Column(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 30),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Folder name',
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.roboto(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 10),
                                Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10),
                                      )),
                                  child: TextFormField(
                                    controller: folderTextController,
                                    textAlignVertical: TextAlignVertical.center,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 20),
                                    onChanged: (String text) {
                                      // onChanged!(text);
                                    },
                                    onEditingComplete: () {
                                      // onEditingComplete;
                                    },
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.all(15),
                                        hintText:
                                            'Please enter a folder name here',
                                        hintStyle: TextStyle(fontSize: 15)),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.red),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Container(
                                        width: 220,
                                        height: 60,
                                        alignment: Alignment.center,
                                        child: const Text('Cancel',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.blue),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        folderBloc.addFolder(
                                            folderItem: FolderItem(
                                                folderName:
                                                    folderTextController.text,
                                                user:
                                                    'alex.ayso@valuation.com'));
                                        folderTextController.clear();
                                      },
                                      child: Container(
                                        width: 220,
                                        height: 60,
                                        alignment: Alignment.center,
                                        child: const Text('Add Vehicle',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
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

  void _showDialogModal(BuildContext context) async {
    showGeneralDialog(
      barrierDismissible: false,
      transitionDuration: const Duration(milliseconds: 0),
      context: context,
      pageBuilder: (BuildContext context, anim1, anim2) {
        return Align(
            alignment: Alignment.center,
            child: AddVehicleModalBody(
              onDataFound: (String vin, String mileage) {
                Navigator.pushNamed(context, '/main/${pages[2]}/$vin',
                    arguments: VehicleDetailsArgs(mileage));
              },
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
