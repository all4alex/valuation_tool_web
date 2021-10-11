import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:valuation_tool_web/bloc/black_book_bloc.dart';
import 'package:valuation_tool_web/bloc/black_book_state.dart';
import 'package:valuation_tool_web/models/vehicle_response.dart';

class AddVehicleModalBody extends StatefulWidget {
  const AddVehicleModalBody({Key? key, required this.onDataFound})
      : super(key: key);
  final Function(String) onDataFound;
  @override
  State<AddVehicleModalBody> createState() => _AddVehicleModalBodyState();
}

class _AddVehicleModalBodyState extends State<AddVehicleModalBody> {
  TextEditingController vinTextEditingController = TextEditingController();
  bool roughSelected = false;
  bool averageSelected = true;
  bool cleanSelected = false;
  final ButtonStyle selectedStyle =
      ElevatedButton.styleFrom(primary: const Color(0xff494949));
  final ButtonStyle unSelectedStyle =
      ElevatedButton.styleFrom(primary: const Color(0xffD9DBE1), elevation: 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        width: 570,
        height: 600,
        alignment: Alignment.center,
        child: Material(
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
              BlocListener<BlackBookBloc, BlackBookState>(
                  listener: (BuildContext context, BlackBookState state) {
                if (state is BlackBookLoadingState) {
                } else if (state is BlackBookSuccessState) {
                } else if (state is BlackBookFailedState) {
                  print('THE error: ${state.error}');
                }
              }, child: BlocBuilder<BlackBookBloc, BlackBookState>(
                      builder: (BuildContext context, BlackBookState state) {
                if (state is BlackBookLoadingState) {
                  return Center(child: const CircularProgressIndicator());
                }
                return Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('VIN',
                              textAlign: TextAlign.start,
                              style: GoogleFonts.roboto(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          Container(
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
                                  Navigator.pop(context);
                                  widget.onDataFound(inputedVin);
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
                );
              })),
            ],
          ),
        ),
      ),
    );
  }
}
