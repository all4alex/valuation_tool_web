import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valuation_tool_web/bloc/folder/folder_bloc.dart';
import 'package:valuation_tool_web/bloc/folder/folder_state.dart';
import 'package:valuation_tool_web/models/firestore/folder_item.dart';
import 'package:valuation_tool_web/models/firestore/vehicle_item.dart';

import 'dialog_folder_item.dart';

class SelectFolderDialogBody extends StatefulWidget {
  SelectFolderDialogBody({required this.vehicleItem});
  final VehicleItem vehicleItem;

  @override
  State<SelectFolderDialogBody> createState() => _SelectFolderDialogBodyState();
}

class _SelectFolderDialogBodyState extends State<SelectFolderDialogBody> {
  late FolderBloc folderBloc;
  @override
  void initState() {
    folderBloc = BlocProvider.of<FolderBloc>(context);
    folderBloc.getAllFolder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FolderBloc, FolderState>(
        builder: (BuildContext context, FolderState state) {
      List<Widget> listOfFolder = <Widget>[];
      if (state is GetFoldersSuccessState) {
        listOfFolder = state.list.map((e) {
          return DialogFolderItem(
            icon: Icons.folder,
            color: Colors.orange,
            text: e.folderName,
            onPressed: () {
              folderBloc.addToFolder(
                  folderName: e.folderName!, id: widget.vehicleItem.id!);
              Navigator.pop(context, e.folderName);
            },
          );
        }).toList();
      }
      return SimpleDialog(title: Text('Select folder'), children: listOfFolder);
    });
  }
}
