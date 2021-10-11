import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:valuation_tool_web/bloc/black_book_bloc.dart';
import 'package:valuation_tool_web/bloc/black_book_state.dart';
import 'package:valuation_tool_web/models/add_deduct_list.dart';
import 'package:valuation_tool_web/models/used_vehicle_list.dart';
import 'package:valuation_tool_web/models/used_vehicles.dart';
import 'package:valuation_tool_web/widgets/blackbook/black_book_retail_data.dart';
import 'package:valuation_tool_web/widgets/blackbook/black_book_trade_in_data.dart';
import 'package:valuation_tool_web/widgets/blackbook/black_book_wholesale_data.dart';
import 'package:valuation_tool_web/widgets/info_item_with_spacing.dart';
import 'package:valuation_tool_web/widgets/page_view.dart';

class VehicleDetails extends StatefulWidget {
  final String vin;

  const VehicleDetails(this.vin);

  @override
  State<VehicleDetails> createState() => _VehicleDetailsState();
}

class _VehicleDetailsState extends State<VehicleDetails> {
  late BlackBookBloc blackBookBloc;

  @override
  void initState() {
    blackBookBloc = BlocProvider.of<BlackBookBloc>(context);
    blackBookBloc.getVehiclDataByVin(vin: widget.vin);
    super.initState();
  }

  TextStyle roboto = GoogleFonts.roboto();
  final ButtonStyle buttonStyle =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

  final ButtonStyle buttonStyle2 = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), primary: Colors.green);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: screenSize.height * .7,
          width: screenSize.width * .35,
          padding: EdgeInsets.all(20),
          margin: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
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
          child: BlocListener<BlackBookBloc, BlackBookState>(
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
            } else if (state is BlackBookSuccessState) {
              UsedVehicleListItem usedVehicleListItem =
                  state.vehicleResponse.usedVehicles!.usedVehicleList![0];
              String driveTrain = usedVehicleListItem.drivetrain.toString();
              String transmission = usedVehicleListItem.transmission.toString();
              String year = usedVehicleListItem.modelYear.toString();
              String make = usedVehicleListItem.make.toString();
              String model = usedVehicleListItem.model.toString();
              String location =
                  '${usedVehicleListItem.country}, ${usedVehicleListItem.state}';
              String style = usedVehicleListItem.style.toString();
              String fuelType = usedVehicleListItem.fuelType.toString();

              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 170,
                          height: 110,
                          color: Colors.grey,
                          child: Icon(Icons.image),
                        ),
                        const SizedBox(width: 5),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$year $make $model',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                              Text('$driveTrain | $transmission',
                                  style: TextStyle(
                                      fontSize: 10, color: Color(0xff777777))),
                              Divider(thickness: 2, height: 10),
                              Text(
                                widget.vin,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              SizedBox(
                                  height: 15,
                                  width: 30,
                                  child: SvgPicture.asset(
                                      'assets/svg/folder_icon.svg',
                                      color: Color(0xff36334E),
                                      fit: BoxFit.fitHeight)),
                              Text('Orem Location',
                                  style: TextStyle(fontSize: 10)),
                              const SizedBox(width: 10),
                              Icon(Icons.ios_share, color: Colors.green)
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Divider(),
                    Container(
                      child: Container(
                        width: screenSize.width * .25,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InfoItemWithSpacing('STYLE:  ', style),
                            InfoItemWithSpacing('DRIVE TRAIN:  ', driveTrain),
                            InfoItemWithSpacing('FUEL TYPE:  ', fuelType),
                            InfoItemWithSpacing('LOCATION:  ', location),
                          ],
                        ),
                      ),
                    ),
                    Divider(),
                    ElevatedButton(
                      style: buttonStyle,
                      onPressed: () {},
                      child: SizedBox(
                        width: screenSize.width * .30,
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Text('(3) RETAIL MARKET',
                                style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      style: buttonStyle2,
                      onPressed: () {},
                      child: SizedBox(
                        width: screenSize.width * .30,
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Text('PROFIT',
                                style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(child: const Text('Unable to get vehicle data'));
            }
          })),
        ),
        Container(
          height: screenSize.height * .5,
          width: screenSize.width * .35,
          padding: EdgeInsets.all(20),
          margin: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
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
          child: BlocListener<BlackBookBloc, BlackBookState>(
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
            } else if (state is BlackBookSuccessState) {
              UsedVehicles usedVehicleListItem =
                  state.vehicleResponse.usedVehicles!;
              String year =
                  usedVehicleListItem.usedVehicleList![0].modelYear.toString();
              String make =
                  usedVehicleListItem.usedVehicleList![0].make.toString();
              String model =
                  usedVehicleListItem.usedVehicleList![0].model.toString();
              return Container(
                height: screenSize.height * .5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Image.asset(
                        'assets/images/ic_blackbook.png',
                        width: 120,
                        height: 60,
                      ),
                    ),
                    Container(child: Text('$year $make $model')),
                    Container(
                      padding: EdgeInsets.only(left: 5, bottom: 5),
                      child: Text(
                        'Updated: ${usedVehicleListItem.usedVehicleList![0].publishDate}',
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                            fontSize: 11,
                            color: Colors.black.withOpacity(.6),
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                    Container(
                      height: 180,
                      child: BlackBookPageView(
                        listOfPage: [
                          Container(
                            padding: EdgeInsets.only(left: 5, right: 5),
                            child: BlackBookRetailData(
                              usedVehicles: usedVehicleListItem,
                              vehicleIndex: 0,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 5, right: 5),
                            child: BlackBookTradeInData(
                              usedVehicles: usedVehicleListItem,
                              vehicleIndex: 0,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 5, right: 5),
                            child: BlackBookWholeSaleData(
                              usedVehicles: usedVehicleListItem,
                              vehicleIndex: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 30,
                      padding: EdgeInsets.only(right: 5),
                      alignment: Alignment.centerRight,
                      child: RaisedButton(
                        color: Color(0xff18A0FB),
                        onPressed: () {
                          // _showOptionsDialog(
                          //     context, usedVehicleList.addDeductList);
                        },
                        child: Text(
                          'OPTIONS',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).accentColor),
                        ),
                      ),
                    )
                  ],
                ),
              );
            } else {
              return Center(child: const Text('Unable to get vehicle data'));
            }
          })),
        ),
      ],
    );
  }

  // void _showOptionsDialog(context, List<AddDeductList> addDeductList) {
  //   // flutter defined function
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       // return alert dialog object
  //       return AlertDialog(
  //         title: new Text('Select options'),
  //         content: Column(
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             mainAxisSize: MainAxisSize.min,
  //             children: generateOptions(addDeductList)),
  //       );
  //     },
  //   );
  // }

  // List<Widget> generateOptions(List<AddDeductList> addDeductList) {
  //   List<Widget> optionCheckBoxList = List<Widget>();
  //   for (AddDeductList item in addDeductList) {
  //     bool isChecked = options.contains(', ' + item.uoc);
  //     optionCheckBoxList.add(Container(
  //       height: 35,
  //       width: 180,
  //       alignment: Alignment.centerLeft,
  //       child: StatefulBuilder(
  //         builder: (context, setState) => CheckboxListTile(
  //           title: Text(
  //             item.name,
  //             style: TextStyle(fontSize: 13),
  //           ),
  //           value: isChecked,
  //           onChanged: (bool newValue) {
  //             setState(() {
  //               isChecked = newValue;
  //             });
  //             if (newValue) {
  //               options = options + ', ' + item.uoc;
  //             } else {
  //               options = options.replaceAll(', ' + item.uoc, '');
  //             }
  //             print(options);
  //           },
  //           checkColor: Colors.white,
  //           activeColor: Theme.of(context).primaryColor,
  //           controlAffinity: ListTileControlAffinity.leading,
  //         ),
  //       ),
  //     ));
  //   }
  //   RaisedButton raisedButton = RaisedButton(
  //     color: Color(0xff18A0FB),
  //     onPressed: () {
  //       Navigator.of(context).pop();
  //       updateVehicleDetail();
  //     },
  //     child: Text(
  //       'UPDATE',
  //       style: TextStyle(
  //           fontWeight: FontWeight.bold, color: Theme.of(context).accentColor),
  //     ),
  //   );
  //   optionCheckBoxList.add(Container(
  //     padding: EdgeInsets.only(top: 15),
  //     child: raisedButton,
  //   ));
  //   return optionCheckBoxList;
  // }
}