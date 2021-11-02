import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:valuation_tool_web/bloc/folder/add_to_folder/add_to_folder_bloc.dart';
import 'package:valuation_tool_web/bloc/folder/add_to_folder/add_to_folder_state.dart';
import 'package:valuation_tool_web/bloc/folder/folder_bloc.dart';
import 'package:valuation_tool_web/bloc/folder/folder_state.dart';
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
  late FolderBloc folderBloc;
  late AddToFolderBloc addToFolderBloc;

  @override
  void initState() {
    folderBloc = BlocProvider.of<FolderBloc>(context);
    addToFolderBloc = BlocProvider.of<AddToFolderBloc>(context);
    folderBloc.getAllFolderFromDialog();
    print('FOLDER NAME: ${widget.vehicleItem.folder}');
    super.initState();
  }

  void _onSave() {
    print('SAVE...');
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
                    title: 'Change Folder',
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
                          // BlocListener<AddToFolderBloc, AddToFolderState>(
                          //     listener: (BuildContext context,
                          //         AddToFolderState state) {
                          //   if (state is AddToFolderSuccessState) {
                          //     BlocProvider.of<FolderBloc>(context)
                          //         .getAllFolder();
                          //   }
                          // }, child: BlocBuilder<AddToFolderBloc,
                          //             AddToFolderState>(
                          //         builder: (BuildContext context,
                          //             AddToFolderState state) {
                          //   String? newFolderName;
                          //   if (state is AddToFolderLoadingState) {
                          //     return Text('  Adding...',
                          //         style: TextStyle(fontSize: 10));
                          //   } else if (state is AddToFolderSuccessState) {
                          //     newFolderName = state.folderName;
                          //   }
                          //   return Text(newFolderName ?? folderName,
                          //       style: TextStyle(fontSize: 10));
                          // })),
                          BlocBuilder<FolderBloc, FolderState>(builder:
                              (BuildContext context, FolderState state) {
                            List<FolderItem> listOfFolder = <FolderItem>[];
                            if (state is GetFoldersFromDialogLoadingState) {
                              return Center(
                                  child:
                                      Text('Loading folders... Please wait.'));
                            } else if (state
                                is GetFoldersFromDialogSuccessState) {
                              print('FOLDERS: ${state.list}');
                              listOfFolder = state.list;
                            }
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: listOfFolder.map((folder) {
                                bool isTrue =
                                    widget.vehicleItem.folder!.toLowerCase() ==
                                        folder.folderName!.toLowerCase();

                                return InkWell(
                                  onTap: () {
                                    addToFolderBloc.addToFolder(
                                        folderName: folder.folderName!,
                                        id: widget.vehicleItem.id!);
                                    Navigator.pop(context, folder.folderName);
                                  },
                                  child: Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: isTrue
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
                                                    fontWeight: FontWeight.w500,
                                                    color: isTrue
                                                        ? Colors.white
                                                        : Colors.black),
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                '${folder.folderCount} vehicles',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: isTrue
                                                      ? Colors.white
                                                      : Colors.black,
                                                ),
                                              ),
                                              SizedBox(height: isTrue ? 0 : 5),
                                              isTrue
                                                  ? Container()
                                                  : Container(
                                                      height: 1,
                                                      color: Colors.grey[400],
                                                      width: 500 - 60,
                                                    ),
                                            ],
                                          ),
                                          isTrue
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
                          const SizedBox(height: 30),
                        ],
                      ),
                    ],
                  ),
                ),
                ModalFooter(
                  onSave: widget.vehicleItem.folder == 'Add to folder'
                      ? () {}
                      : _onSave,
                  color: widget.vehicleItem.folder == 'Add to folder'
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
