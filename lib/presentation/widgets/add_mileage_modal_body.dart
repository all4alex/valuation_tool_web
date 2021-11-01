import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:valuation_tool_web/presentation/widgets/modal/modal_footer.dart';
import 'package:valuation_tool_web/presentation/widgets/modal/modal_header.dart';

class AddMileageModalBody extends StatefulWidget {
  const AddMileageModalBody({Key? key}) : super(key: key);
  @override
  State<AddMileageModalBody> createState() => _AddMileageModalBodyState();
}

class _AddMileageModalBodyState extends State<AddMileageModalBody> {
  TextEditingController mileageTextEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  void _onSave() {
    print('SAVE...');
    if (_formKey.currentState!.validate()) {
      // api call...
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
                      title: 'Mileage', subTitle: 'Place vehicle mileage'),
                  const SizedBox(height: 10),
                  Container(
                    height: screenSize.height * .2,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 20),
                        Text('Mileage',
                            textAlign: TextAlign.start,
                            style: GoogleFonts.roboto(fontSize: 14)),
                        const SizedBox(height: 5),
                        Container(
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Mileage is required.';
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
                              hintText: 'Enter Vehicle Mileage',
                              border: OutlineInputBorder(),
                            ),
                            controller: mileageTextEditingController,
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
