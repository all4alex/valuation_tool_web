import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valuation_tool_web/bloc/notes/notes_bloc.dart';
import 'package:valuation_tool_web/bloc/notes/notes_state.dart';
import 'package:valuation_tool_web/models/firestore/note_item_model.dart';
import 'package:valuation_tool_web/presentation/widgets/add_notes_modal_body.dart';

class VehicleNotes extends StatefulWidget {
  VehicleNotes({required this.email, required this.name, required this.vin});
  final String email;
  final String name;
  final String vin;

  @override
  State<VehicleNotes> createState() => _VehicleNotesState();
}

class _VehicleNotesState extends State<VehicleNotes> {
  void _showAddNotesModal(BuildContext context) async {
    showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 0),
      context: context,
      pageBuilder: (BuildContext context, anim1, anim2) {
        return Align(
          alignment: Alignment.center,
          child: AddNotesModalBody(
            name: widget.name,
            user: widget.email,
            vin: widget.vin,
          ),
        );
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

  late NotesBloc notesBloc;
  List<NoteItemModel> list = <NoteItemModel>[];

  @override
  void initState() {
    notesBloc = BlocProvider.of<NotesBloc>(context);
    notesBloc.getAllNotes(vin: widget.vin);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
        width: screenSize.width * .32 + 15,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Color(0xffFFFFFF),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SelectableText(
                    'Notes',
                    style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff191919),
                        fontWeight: FontWeight.w500),
                  ),
                  InkWell(
                    onTap: () => _showAddNotesModal(context),
                    child: Row(children: [
                      SizedBox(
                          height: 15,
                          child: Icon(Icons.message_outlined,
                              color: Colors.blue, size: 17)),
                      Text('  Add Notes',
                          style: TextStyle(fontSize: 13, color: Colors.blue))
                    ]),
                  )
                ],
              ),
              Divider(),
              SizedBox(height: 5),
              BlocBuilder<NotesBloc, NotesState>(
                  builder: (BuildContext context, NotesState state) {
                if (state is GetNotesLoadingState) {
                  return Center(child: const CircularProgressIndicator());
                } else if (state is GetNotesSuccessState) {
                  list = state.list;
                }
                if (state is GetNotesFailedState) {
                  return Center(child: const CircularProgressIndicator());
                }
                return Container(
                  height: screenSize.height * .25,
                  child: ListView.separated(
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int i) {
                      return NoteItem(
                          notes: list[i].note!, email: list[i].user!);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(height: 30);
                    },
                  ),
                );
              }),
              Divider(),
              InkWell(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text(
                    'SHOW ALL NOTES',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ]));
  }
}

class NoteItem extends StatelessWidget {
  const NoteItem({Key? key, required this.email, required this.notes})
      : super(key: key);

  final String email;
  final String notes;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: screenSize.width * .28,
              child: SelectableText(
                notes,
                style: TextStyle(overflow: TextOverflow.clip, fontSize: 12),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.zero,
                child: Icon(Icons.more_horiz),
              ),
            )
          ],
        ),
        const SizedBox(height: 10),
        SelectableText('By: $email',
            style: TextStyle(fontWeight: FontWeight.bold))
      ],
    ));
  }
}
