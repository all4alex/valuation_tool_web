import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:valuation_tool_web/bloc/folder/folder_bloc.dart';
import 'package:valuation_tool_web/bloc/folder/folder_state.dart';
import 'package:valuation_tool_web/models/vehicle_response.dart';

import 'category_search.dart';
import 'custom_dropdown.dart';

class AddVehicleModalBody extends StatefulWidget {
  const AddVehicleModalBody(
      {Key? key, required this.onDataFound, this.folderName = 'Add to folder'})
      : super(key: key);
  final Function(String, String, String, String) onDataFound;
  final String folderName;
  @override
  State<AddVehicleModalBody> createState() => _AddVehicleModalBodyState();
}

class _AddVehicleModalBodyState extends State<AddVehicleModalBody> {
  TextEditingController vinTextEditingController = TextEditingController();
  TextEditingController mileageTextEditingController = TextEditingController();

  bool roughSelected = false;
  bool averageSelected = true;
  bool cleanSelected = false;
  final ButtonStyle selectedStyle =
      ElevatedButton.styleFrom(primary: const Color(0xff494949));
  final ButtonStyle unSelectedStyle =
      ElevatedButton.styleFrom(primary: const Color(0xffD9DBE1), elevation: 0);
  bool isVinSearch = true;
  String categoryUVC = '';
  //"Add to folder" means no folder is selected
  String selectedFolderName = 'Add to folder';
  late FToast fToast;
  late FolderBloc folderBloc;
  List<String?> folderList = <String>[];

  @override
  void initState() {
    fToast = FToast();
    fToast.init(context);
    folderBloc = BlocProvider.of<FolderBloc>(context);
    folderBloc.getAllFolderFromDialog();
    super.initState();
  }

  void showErrorToast(String message) {
    Widget toastBody = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.red,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(Icons.error, color: Colors.white),
          SizedBox(
            width: 12.0,
          ),
          Text(message, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
    fToast.removeCustomToast();
    fToast.showToast(
      child: toastBody,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: Container(
          width: 450,
          alignment: Alignment.center,
          child: Material(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                      height: 70,
                      width: double.infinity,
                      padding: const EdgeInsets.all(15),
                      decoration: const BoxDecoration(
                        color: Color(0xffF3F3F3),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 1.0),
                              blurRadius: 6.0,
                              spreadRadius: 0),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              widget.folderName == 'Add to folder'
                                  ? 'Add Vehicle'
                                  : 'Add Vehicle - ${widget.folderName}',
                              style: GoogleFonts.roboto(
                                  fontSize: 18,
                                  color: Color(0xff191919),
                                  fontWeight: FontWeight.bold)),
                          Text('Kindly fill out this form',
                              style: GoogleFonts.roboto(
                                  fontSize: 12, color: Color(0xff191919)))
                        ],
                      )),
                  const SizedBox(height: 30),
                  CustomSwitch(
                    onChange: (int val) {
                      if (val == 0) {
                        isVinSearch = true;
                      } else {
                        isVinSearch = false;
                      }
                      setState(() {});
                    },
                  ),
                  const Divider(thickness: 3, height: 0),
                  Container(
                      height: screenSize.height * .7,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(height: 20),
                          Text('Add VIN',
                              style: GoogleFonts.roboto(
                                  fontSize: 14, color: Color(0xff191919))),
                          const SizedBox(height: 5),
                          isVinSearch
                              ? Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(5),
                                      )),
                                  child: TextFormField(
                                    controller: vinTextEditingController,
                                    textAlignVertical: TextAlignVertical.center,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 16),
                                    onChanged: (String text) {
                                      // onChanged!(text);
                                    },
                                    onEditingComplete: () {
                                      // onEditingComplete;
                                    },
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.all(15),
                                        hintText: 'Enter VIN',
                                        hintStyle: TextStyle(fontSize: 14)),
                                  ),
                                )
                              : CategorySearch(
                                  onFilledUp: (String uvc) {
                                    categoryUVC = uvc;
                                  },
                                ),
                          //hide folder dropdown if folder is specified. "Add to folder" means not folder is specified
                          Visibility(
                              visible: widget.folderName == 'Add to folder',
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 20),
                                  Text('Add to Folder (Optional)',
                                      style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          color: Color(0xff191919))),
                                  const SizedBox(height: 5),
                                  BlocBuilder<FolderBloc, FolderState>(builder:
                                      (BuildContext context,
                                          FolderState state) {
                                    if (state
                                        is GetFoldersFromDialogLoadingState) {
                                      return CircularProgressIndicator();
                                    }
                                    if (state
                                        is GetFoldersFromDialogSuccessState) {
                                      folderList = state.list
                                          .map((e) => e.folderName)
                                          .toList();
                                    }
                                    return CustomDropdown(
                                      hint: 'Select a Folder',
                                      items: folderList,
                                      onChanged: (String? val) {
                                        if (val!.isNotEmpty) {
                                          selectedFolderName = val;
                                        }
                                      },
                                    );
                                  }),
                                  Row(
                                    children: [
                                      Text('Don’t have a list yet?  Kindly ',
                                          style: GoogleFonts.roboto(
                                              fontSize: 12,
                                              color: Color(0xff191919))),
                                      InkWell(
                                        onTap: () {},
                                        child: Text('create list',
                                            style: GoogleFonts.roboto(
                                                fontSize: 12,
                                                color: Colors.blue)),
                                      ),
                                    ],
                                  ),
                                ],
                              )),

                          const SizedBox(height: 20),
                          Text('Add Mileage',
                              textAlign: TextAlign.start,
                              style: GoogleFonts.roboto(fontSize: 14)),
                          const SizedBox(height: 5),
                          Container(
                            alignment: Alignment.center,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(5),
                                )),
                            child: TextFormField(
                              controller: mileageTextEditingController,
                              textAlignVertical: TextAlignVertical.center,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                              onChanged: (String text) {
                                // onChanged!(text);
                              },
                              onEditingComplete: () {
                                // onEditingComplete;
                              },
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(15),
                                  hintText: 'Enter Mileage',
                                  hintStyle: TextStyle(fontSize: 14)),
                            ),
                          ),
                        ],
                      )),
                  Container(
                      height: 70,
                      width: double.infinity,
                      padding: const EdgeInsets.all(15),
                      alignment: Alignment.bottomCenter,
                      decoration: const BoxDecoration(
                        color: Color(0xffF3F3F3),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 1.0),
                              blurRadius: 6.0,
                              spreadRadius: 0),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.close, color: Colors.red),
                                  Text('  CANCEL',
                                      style: TextStyle(color: Colors.red)),
                                ],
                              )),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xff494949),
                            ),
                            onPressed: () {
                              String inputedVin = vinTextEditingController.text;

                              String mileage =
                                  mileageTextEditingController.text;

                              if (inputedVin.length != 17 && isVinSearch) {
                                showErrorToast('Vin is not valid');
                              } else if (inputedVin.isEmpty && isVinSearch) {
                                showErrorToast('Please input a VIN');
                              } else if (mileage.isEmpty) {
                                showErrorToast('Please input a Mileage');
                              } else {
                                Navigator.pop(context);
                                widget.onDataFound(inputedVin, mileage,
                                    categoryUVC, selectedFolderName);
                              }
                            },
                            child: Container(
                              width: 200,
                              height: 60,
                              alignment: Alignment.center,
                              child: const Text('Add Vehicle',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15)),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomSwitch extends StatefulWidget {
  const CustomSwitch({
    required this.onChange,
    Key? key,
  }) : super(key: key);
  final Function(int) onChange;

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: InkWell(
            onTap: () {
              widget.onChange(0);
              setState(() {
                selectedIndex = 0;
              });
            },
            child: Column(
              children: [
                Text('Add Vehicle VIN',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                        fontSize: 14, color: Color(0xff191919))),
                selectedIndex == 0
                    ? Divider(thickness: 8, color: Color(0xff494949))
                    : const SizedBox(height: 14)
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: InkWell(
            onTap: () {
              widget.onChange(1);
              setState(() {
                selectedIndex = 1;
              });
            },
            child: Column(
              children: [
                Text('Browse Vehicle',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                        fontSize: 14, color: Color(0xff191919))),
                selectedIndex == 1
                    ? Divider(thickness: 8, color: Color(0xff494949))
                    : const SizedBox(height: 14)
              ],
            ),
          ),
        )
      ],
    );
  }
}
