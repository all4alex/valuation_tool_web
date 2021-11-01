import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:valuation_tool_web/presentation/widgets/modal/modal_footer.dart';
import 'package:valuation_tool_web/presentation/widgets/modal/modal_header.dart';

class UpdateNotesModalBody extends StatefulWidget {
  final String subTitle;
  final String name;
  final String notes;

  const UpdateNotesModalBody(
      {Key? key,
      required this.name,
      required this.notes,
      required this.subTitle})
      : super(key: key);
  @override
  State<UpdateNotesModalBody> createState() => _UpdateNotesModalBodyState();
}

class _UpdateNotesModalBodyState extends State<UpdateNotesModalBody> {
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController noteTextEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    nameTextEditingController.text = widget.name;
    noteTextEditingController.text = widget.notes;
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
                  ModalHeader(title: 'Edit Notes', subTitle: widget.subTitle),
                  const SizedBox(height: 10),
                  Container(
                    height: screenSize.height * .5,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 20),
                        Text('Name',
                            textAlign: TextAlign.start,
                            style: GoogleFonts.roboto(fontSize: 14)),
                        const SizedBox(height: 5),
                        Container(
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Name is required.';
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
                              hintText: 'John Doe',
                              border: OutlineInputBorder(),
                            ),
                            controller: nameTextEditingController,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Text('Notes',
                            textAlign: TextAlign.start,
                            style: GoogleFonts.roboto(fontSize: 14)),
                        const SizedBox(height: 5),
                        Container(
                          child: TextFormField(
                            textCapitalization: TextCapitalization.sentences,
                            maxLines: 4,
                            keyboardType: TextInputType.multiline,
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
                              hintText: 'Add Notes',
                              border: OutlineInputBorder(),
                            ),
                            controller: noteTextEditingController,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ModalFooter(
                    onSave: _onSave,
                    color: Colors.green,
                    icon: FontAwesomeIcons.syncAlt,
                    submitName: 'UPDATE',
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
