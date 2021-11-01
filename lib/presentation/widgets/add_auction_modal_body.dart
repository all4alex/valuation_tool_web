import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:valuation_tool_web/bloc/vehicle_info/vehicle_info_bloc.dart';
import 'package:valuation_tool_web/models/firestore/vehicle_item.dart';
import 'package:valuation_tool_web/presentation/widgets/modal/modal_footer.dart';
import 'package:valuation_tool_web/presentation/widgets/modal/modal_header.dart';

class AddAuctionModalBody extends StatefulWidget {
  const AddAuctionModalBody({Key? key, required this.vehicleItem})
      : super(key: key);
  final VehicleItem vehicleItem;

  @override
  State<AddAuctionModalBody> createState() => _AddAuctionModalBodyState();
}

class _AddAuctionModalBodyState extends State<AddAuctionModalBody> {
  late TextEditingController auctionTextEditingController;
  final _formKey = GlobalKey<FormState>();
  late VehicleInfoBloc vehicleInfoBloc;
  @override
  void initState() {
    vehicleInfoBloc = BlocProvider.of<VehicleInfoBloc>(context);
    auctionTextEditingController =
        TextEditingController(text: widget.vehicleItem.auction);
    super.initState();
  }

  void _onSave() {
    print('SAVE...');
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pop();
      vehicleInfoBloc.updateAuction(
          vehicleItem: widget.vehicleItem
              .copyWith(auction: auctionTextEditingController.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      width: 500,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: Material(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  ModalHeader(
                      title: 'Auction', subTitle: 'Place auction place'),
                  const SizedBox(height: 10),
                  Container(
                    height: screenSize.height * .2,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 20),
                        Text('Auction',
                            textAlign: TextAlign.start,
                            style: GoogleFonts.roboto(fontSize: 14)),
                        const SizedBox(height: 5),
                        Container(
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Auction is required.';
                              }
                              return null;
                            },
                            textCapitalization: TextCapitalization.sentences,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 2),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2),
                              ),
                              hintText: 'Enter Auction',
                              border: OutlineInputBorder(),
                            ),
                            controller: auctionTextEditingController,
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                  ModalFooter(
                    onSave: _onSave,
                    color: Colors.blue,
                    icon: FontAwesomeIcons.save,
                    submitName: 'SAVE',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
