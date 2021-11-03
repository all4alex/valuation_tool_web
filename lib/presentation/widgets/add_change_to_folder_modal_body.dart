import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:valuation_tool_web/bloc/folder/add_to_folder/add_to_folder_bloc.dart';
import 'package:valuation_tool_web/bloc/folder/add_to_folder/add_to_folder_state.dart';
import 'package:valuation_tool_web/bloc/folder/folder_bloc.dart' as FolderBloc;
import 'package:valuation_tool_web/bloc/folder/folder_dialog/folder_dialog_bloc.dart';
import 'package:valuation_tool_web/bloc/folder/folder_dialog/folder_dialog_state.dart';
// import 'package:valuation_tool_web/bloc/folder/folder_state.dart';
import 'package:valuation_tool_web/bloc/vehicle_list/vehicle_list_bloc.dart';
import 'package:valuation_tool_web/models/firestore/folder_item.dart';
import 'package:valuation_tool_web/models/firestore/vehicle_item.dart';
import 'package:valuation_tool_web/presentation/widgets/modal/modal_footer.dart';
import 'package:valuation_tool_web/presentation/widgets/modal/modal_header.dart';

class AddChangeToFolderModalBody extends StatefulWidget {
  final VehicleItem vehicleItem;
  const AddChangeToFolderModalBody({Key? key, required this.vehicleItem})
      : super(key: key);
  @override
  State<AddChangeToFolderModalBody> createState() =>
      _AddChangeToFolderModalBodyState();
}

class _AddChangeToFolderModalBodyState
    extends State<AddChangeToFolderModalBody> {
  late FolderDialogBloc folderDialogBloc;
  late AddToFolderBloc addToFolderBloc;
  String selectedFolder = '';
  bool isSubmitting = false;
  @override
  void initState() {
    folderDialogBloc = BlocProvider.of<FolderDialogBloc>(context);
    addToFolderBloc = BlocProvider.of<AddToFolderBloc>(context);
    folderDialogBloc.getAllFolderFromDialog();
    selectedFolder = widget.vehicleItem.folder!;
    print('FOLDER NAME: ${widget.vehicleItem.folder}');
    super.initState();
  }

  void _onSave() {
    addToFolderBloc.addToFolder(
        folderName: selectedFolder, id: widget.vehicleItem.id!);
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
                ModalHeader(
                    title: selectedFolder == 'Add to folder'
                        ? 'Add To Folder'
                        : 'Change Folder',
                    subTitle: 'Select a folder from the list'),
                Container(
                  color: Color(0xffF4F7FC),
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Text(
                    widget.vehicleItem.name!,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                // const SizedBox(height: 10),
                Container(
                  height: screenSize.height * .65,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: ListView(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(height: 20),
                          BlocListener<AddToFolderBloc, AddToFolderState>(
                            listener:
                                (BuildContext context, AddToFolderState state) {
                              if (state is AddToFolderSuccessState) {
                                BlocProvider.of<VehicleListBloc>(context)
                                    .getVehicleList();
                                BlocProvider.of<FolderBloc.FolderBloc>(context)
                                    .getAllFolder();

                                folderDialogBloc.getAllFolderFromDialog();
                              }
                            },
                            child: BlocBuilder<FolderDialogBloc,
                                    FolderDialogState>(
                                builder: (BuildContext context,
                                    FolderDialogState state) {
                              List<FolderItem> listOfFolder = <FolderItem>[];
                              if (state is GetFoldersDialogLoadingState) {
                                return Center(
                                  child:
                                      Text('Loading folders... Please wait.'),
                                );
                              } else if (state
                                  is GetFoldersDialogSuccessState) {
                                listOfFolder = state.list;
                              }
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: listOfFolder.map((folder) {
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedFolder = folder.folderName!;
                                      });
                                    },
                                    child: Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: selectedFolder ==
                                                  folder.folderName
                                              ? Colors.blue
                                              : Colors.transparent,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  folder.folderName!,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: selectedFolder ==
                                                              folder.folderName
                                                          ? Colors.white
                                                          : Colors.black),
                                                ),
                                                const SizedBox(height: 5),
                                                Text(
                                                  '${folder.folderCount} vehicles',
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: selectedFolder ==
                                                            folder.folderName
                                                        ? Colors.white
                                                        : Colors.black,
                                                  ),
                                                ),
                                                SizedBox(
                                                    height: selectedFolder ==
                                                            folder.folderName
                                                        ? 0
                                                        : 5),
                                                selectedFolder ==
                                                        folder.folderName
                                                    ? Container()
                                                    : Container(
                                                        height: 1,
                                                        color: Colors.grey[400],
                                                        width: 500 - 60,
                                                      ),
                                              ],
                                            ),
                                            selectedFolder == folder.folderName
                                                ? Icon(
                                                    FontAwesomeIcons.check,
                                                    color: Colors.white,
                                                    size: 15,
                                                  )
                                                : Container(),
                                          ],
                                        )),
                                  );
                                }).toList(),
                              );
                            }),
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ],
                  ),
                ),
                ModalFooter(
                  onSave: selectedFolder == 'Add to folder' ? () {} : _onSave,
                  color: selectedFolder == 'Add to folder'
                      ? Color(0xffAAAAAA)
                      : Colors.green,
                  icon: FontAwesomeIcons.syncAlt,
                  submitName: 'UPDATE',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
