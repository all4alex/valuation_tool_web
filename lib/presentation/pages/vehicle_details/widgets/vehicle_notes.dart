import 'package:flutter/material.dart';
import 'package:valuation_tool_web/presentation/widgets/add_notes_modal_body.dart';

class VehicleNotes extends StatelessWidget {
  VehicleNotes({required this.email, required this.name});
  final String email;
  final String name;

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
            name: name,
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
              Container(
                height: screenSize.height * .25,
                child: ListView.separated(
                  itemCount: 2,
                  itemBuilder: (BuildContext context, int i) {
                    return NoteItem(screenSize: screenSize, email: email);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(height: 30);
                  },
                ),
              ),
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
  const NoteItem({
    Key? key,
    required this.screenSize,
    required this.email,
  }) : super(key: key);

  final Size screenSize;
  final String email;

  @override
  Widget build(BuildContext context) {
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
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
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
