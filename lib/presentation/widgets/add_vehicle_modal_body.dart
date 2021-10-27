import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:valuation_tool_web/models/vehicle_response.dart';

import 'category_search.dart';

class AddVehicleModalBody extends StatefulWidget {
  const AddVehicleModalBody({Key? key, required this.onDataFound})
      : super(key: key);
  final Function(String, String, String) onDataFound;
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
  late FToast fToast;

  @override
  void initState() {
    fToast = FToast();
    fToast.init(context);
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

    fToast.showToast(
      child: toastBody,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        width: 570,
        height: MediaQuery.of(context).size.height - 50,
        alignment: Alignment.center,
        child: Material(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                    height: 70,
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    color: Colors.blue,
                    child: Text('Add Vehicle',
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
                          Text(isVinSearch ? 'VIN' : 'BROWSE VEHICLES',
                              textAlign: TextAlign.start,
                              style: GoogleFonts.roboto(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          isVinSearch
                              ? Container(
                                  alignment: Alignment.center,
                                  height: 70,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10),
                                      )),
                                  child: TextFormField(
                                    controller: vinTextEditingController,
                                    textAlignVertical: TextAlignVertical.center,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 40),
                                    onChanged: (String text) {
                                      // onChanged!(text);
                                    },
                                    onEditingComplete: () {
                                      // onEditingComplete;
                                    },
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.all(15),
                                        hintText: 'Please enter a VIN here',
                                        hintStyle: TextStyle(fontSize: 25)),
                                  ),
                                )
                              : CategorySearch(
                                  onFilledUp: (String uvc) {
                                    categoryUVC = uvc;
                                  },
                                ),
                          Container(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  isVinSearch = !isVinSearch;
                                });
                              },
                              child: Text(
                                  isVinSearch
                                      ? 'Switch to category search'
                                      : 'Switch to VIN search',
                                  style: TextStyle(color: Colors.blue)),
                            ),
                          ),
                          const Divider(thickness: 2, height: 40),
                          Text('MILEAGE',
                              textAlign: TextAlign.start,
                              style: GoogleFonts.roboto(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
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
                              controller: mileageTextEditingController,
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
                                  hintText: 'Please enter a mileage here',
                                  hintStyle: TextStyle(fontSize: 15)),
                            ),
                          ),
                          const Divider(thickness: 2, height: 40),
                          Text('CONDITION',
                              textAlign: TextAlign.start,
                              style: GoogleFonts.roboto(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                          Container(
                              width: double.infinity,
                              alignment: Alignment.bottomCenter,
                              height: 50,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  ElevatedButton(
                                    style: roughSelected
                                        ? selectedStyle
                                        : unSelectedStyle,
                                    onPressed: () {
                                      setState(() {
                                        roughSelected = true;
                                        averageSelected = false;
                                        cleanSelected = false;
                                      });
                                    },
                                    child: Container(
                                      width: 130,
                                      height: 40,
                                      alignment: Alignment.center,
                                      child: Text('Rough',
                                          style: TextStyle(
                                              color: roughSelected
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: averageSelected
                                        ? selectedStyle
                                        : unSelectedStyle,
                                    onPressed: () {
                                      setState(() {
                                        roughSelected = false;
                                        averageSelected = true;
                                        cleanSelected = false;
                                      });
                                    },
                                    child: Container(
                                      width: 130,
                                      height: 40,
                                      alignment: Alignment.center,
                                      child: Text('Average',
                                          style: TextStyle(
                                              color: averageSelected
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: cleanSelected
                                        ? selectedStyle
                                        : unSelectedStyle,
                                    onPressed: () {
                                      setState(() {
                                        roughSelected = false;
                                        averageSelected = false;
                                        cleanSelected = true;
                                      });
                                    },
                                    child: Container(
                                      width: 130,
                                      height: 40,
                                      alignment: Alignment.center,
                                      child: Text('Clean',
                                          style: TextStyle(
                                              color: cleanSelected
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                ],
                              )),
                          const SizedBox(height: 80),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  String inputedVin =
                                      vinTextEditingController.text;

                                  String mileage =
                                      mileageTextEditingController.text;

                                  if (inputedVin.length != 17 && isVinSearch) {
                                    showErrorToast('Vin is not valid');
                                  } else if (inputedVin.isEmpty &&
                                      isVinSearch) {
                                    showErrorToast('Please input a VIN');
                                  } else if (mileage.isEmpty) {
                                    showErrorToast('Please input a Mileage');
                                  } else {
                                    Navigator.pop(context);
                                    widget.onDataFound(
                                        inputedVin, mileage, categoryUVC);
                                  }
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
      ),
    );
  }
}
