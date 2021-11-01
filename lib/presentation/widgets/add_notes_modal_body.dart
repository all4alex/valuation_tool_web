import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:valuation_tool_web/bloc/notes/notes_bloc.dart';
import 'package:valuation_tool_web/models/firestore/note_item_model.dart';
import 'package:valuation_tool_web/presentation/widgets/modal/modal_footer.dart';
import 'package:valuation_tool_web/presentation/widgets/modal/modal_header.dart';

class AddNotesModalBody extends StatefulWidget {
  const AddNotesModalBody(
      {Key? key, required this.name, required this.vin, required this.user})
      : super(key: key);
  final String name;
  final String vin;
  final String user;

  @override
  State<AddNotesModalBody> createState() => _AddNotesModalBodyState();
}

class _AddNotesModalBodyState extends State<AddNotesModalBody> {
  late TextEditingController nameTextEditingController;
  TextEditingController noteTextEditingController = TextEditingController();
  late NotesBloc notesBloc;
  late FToast fToast;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    notesBloc = BlocProvider.of<NotesBloc>(context);
    nameTextEditingController = TextEditingController(text: widget.user);
    fToast = FToast();
    fToast.init(context);
    super.initState();
  }

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pop();
      NoteItemModel noteItemModel = NoteItemModel(
          user: widget.user,
          vin: widget.vin,
          note: noteTextEditingController.text);
      notesBloc.addNotes(noteItemModel: noteItemModel);
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
            child: Column(
              children: <Widget>[
                ModalHeader(title: 'Add Notes', subTitle: widget.name),
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
                          textCapitalization: TextCapitalization.sentences,
                          enabled: false,
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
                      Form(
                        key: _formKey,
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Notes is required';
                            }
                          },
                        ),
                      ),
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
    );
  }
}
