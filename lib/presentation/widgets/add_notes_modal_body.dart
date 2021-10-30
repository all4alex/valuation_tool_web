import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddNotesModalBody extends StatefulWidget {
  final String name;

  const AddNotesModalBody({Key? key, required this.name}) : super(key: key);
  @override
  State<AddNotesModalBody> createState() => _AddNotesModalBodyState();
}

class _AddNotesModalBodyState extends State<AddNotesModalBody> {
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController noteTextEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
                            onPressed: () {},
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
