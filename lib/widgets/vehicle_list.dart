import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:valuation_tool_web/bloc/black_book_bloc.dart';
import 'package:valuation_tool_web/bloc/black_book_state.dart';
import 'package:valuation_tool_web/models/vehicle_response.dart';

import 'add_vehicle_modal_body.dart';

class VehicleList extends StatefulWidget {
  const VehicleList({Key? key, required this.onItemSelect
      // required this.title,
      // required this.subTitle,
      // required this.vin,
      // required this.addedDate,
      // required this.folder,
      // required this.imageUrl
      })
      : super(key: key);
  final Function onItemSelect;
  @override
  State<VehicleList> createState() => _VehicleListState();
}

class _VehicleListState extends State<VehicleList> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
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
                      TextButton(
                          onPressed: () {
                            _showDialogModal(context);
                          },
                          child:
                              Text('Add Vehicle', textAlign: TextAlign.center))
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
          const Divider(height: 0),
          Expanded(
            flex: 1,
            child: ListView.builder(
                itemCount: 20,
                itemBuilder: (BuildContext context, int i) {
                  return InkWell(
                    onTap: () {
                      widget.onItemSelect(i);
                    },
                    child: Container(
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
                        )),
                  );
                }),
          ),
        ],
      ),
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
              onDataFound: (String vin) {},
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
