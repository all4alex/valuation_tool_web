import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:valuation_tool_web/bloc/folder/folder_bloc.dart';
import 'package:valuation_tool_web/bloc/folder/folder_state.dart';
import 'package:valuation_tool_web/bloc/vehicle_list/vehicle_list_bloc.dart';
import 'package:valuation_tool_web/models/firestore/folder_item.dart';
import 'package:valuation_tool_web/presentation/widgets/modal/modal_footer.dart';
import 'package:valuation_tool_web/presentation/widgets/modal/modal_header.dart';

class RenameFolderModalBody extends StatefulWidget {
  final FolderItem folderItem;
  const RenameFolderModalBody({Key? key, required this.folderItem})
      : super(key: key);
  @override
  State<RenameFolderModalBody> createState() => _RenameFolderModalBodyState();
}

class _RenameFolderModalBodyState extends State<RenameFolderModalBody> {
  TextEditingController folderNameTextEditingController =
      TextEditingController();
  late FolderBloc folderBloc;
  @override
  void initState() {
    super.initState();
    folderNameTextEditingController.text = widget.folderItem.folderName!;
    folderBloc = BlocProvider.of<FolderBloc>(context);
  }

  void _onSave() {
    folderBloc.renameFolder(
        oldFolderName: widget.folderItem.folderName!,
        folderName: folderNameTextEditingController.text,
        id: widget.folderItem.id!);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return BlocListener<FolderBloc, FolderState>(
      listener: (BuildContext context, FolderState state) {
        if (state is RenameFolderSuccessState) {
          BlocProvider.of<VehicleListBloc>(context).getVehicleListPerFolder(
              folderName: folderNameTextEditingController.text);
          BlocProvider.of<FolderBloc>(context).getAllFolder();
        }
      },
      child: Container(
        width: 500,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Material(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ModalHeader(
                      title: 'Rename Folder',
                      subTitle: 'Replace with new folder name'),
                  const SizedBox(height: 10),
                  Container(
                    height: screenSize.height * .2,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 20),
                        Text('Folder Name',
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
                              hintText: 'Enter Folder Name',
                              border: OutlineInputBorder(),
                            ),
                            controller: folderNameTextEditingController,
                          ),
                        ),
                        const SizedBox(height: 30),
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
