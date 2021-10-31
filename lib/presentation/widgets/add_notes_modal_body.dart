import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:valuation_tool_web/bloc/notes/notes_bloc.dart';
import 'package:valuation_tool_web/models/firestore/note_item_model.dart';

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

  @override
  void initState() {
    notesBloc = BlocProvider.of<NotesBloc>(context);
    nameTextEditingController = TextEditingController(text: widget.user);
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
      width: 500,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: Material(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                    height: 80,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                      color: Color(0xffFFFFFF),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Color(0xffE6E6E6),
                            offset: Offset(0.0, 1.0),
                            blurRadius: 6.0,
                            spreadRadius: 0),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Add Notes',
                          style: GoogleFonts.roboto(
                              fontSize: 20,
                              color: Color(0xff191919),
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(widget.name,
                            style: GoogleFonts.roboto(
                                fontSize: 16, color: Color(0xff191919)))
                      ],
                    )),
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
                    )),
                Container(
                    height: 70,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                      color: Color(0xffFFFFFF),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Color(0xffE6E6E6),
                            offset: Offset(0.0, 1.0),
                            blurRadius: 6.0,
                            spreadRadius: 0),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.close, color: Colors.red),
                                Text('  CANCEL',
                                    style: TextStyle(color: Colors.red)),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xff17A0FB),
                            ),
                            onPressed: () {
                              String note = noteTextEditingController.text;
                              if (note.isNotEmpty) {
                                Navigator.of(context).pop();
                                NoteItemModel noteItemModel = NoteItemModel(
                                    user: widget.user,
                                    vin: widget.vin,
                                    note: note);
                                notesBloc.addNotes(
                                    noteItemModel: noteItemModel);
                              } else {
                                showErrorToast('Note must not be empty!');
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.save, color: Colors.white),
                                  Text('  SAVE',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
