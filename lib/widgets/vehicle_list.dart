import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class VehicleList extends StatefulWidget {
  const VehicleList({
    Key? key,
    // required this.title,
    // required this.subTitle,
    // required this.vin,
    // required this.addedDate,
    // required this.folder,
    // required this.imageUrl
  }) : super(key: key);

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

  void _showDialogModal(BuildContext context) async {
    showGeneralDialog(
      barrierDismissible: false,
      transitionDuration: const Duration(milliseconds: 0),
      context: context,
      pageBuilder: (BuildContext context, anim1, anim2) {
        return const Align(
            alignment: Alignment.center, child: AddVehicleModalBody());
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

class AddVehicleModalBody extends StatefulWidget {
  const AddVehicleModalBody({Key? key}) : super(key: key);

  @override
  State<AddVehicleModalBody> createState() => _AddVehicleModalBodyState();
}

class _AddVehicleModalBodyState extends State<AddVehicleModalBody> {
  bool roughSelected = false;
  bool averageSelected = true;
  bool cleanSelected = false;
  final ButtonStyle selectedStyle =
      ElevatedButton.styleFrom(primary: const Color(0xff494949));
  final ButtonStyle unSelectedStyle =
      ElevatedButton.styleFrom(primary: const Color(0xffD9DBE1), elevation: 0);
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
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
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
                        textAlignVertical: TextAlignVertical.center,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 40),
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
                        style:
                            const TextStyle(color: Colors.black, fontSize: 20),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          style: ElevatedButton.styleFrom(primary: Colors.red),
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
                          style: ElevatedButton.styleFrom(primary: Colors.blue),
                          onPressed: () {
                            Navigator.of(context).pop();
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
