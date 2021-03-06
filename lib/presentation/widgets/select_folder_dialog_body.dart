import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valuation_tool_web/bloc/folder/add_to_folder/add_to_folder_bloc.dart';
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
  late AddToFolderBloc addToFolderBloc;

  @override
  void initState() {
    folderBloc = BlocProvider.of<FolderBloc>(context);
    addToFolderBloc = BlocProvider.of<AddToFolderBloc>(context);
    folderBloc.getAllFolderFromDialog();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FolderBloc, FolderState>(
        builder: (BuildContext context, FolderState state) {
      List<Widget> listOfFolder = <Widget>[];
      if (state is GetFoldersFromDialogLoadingState) {
        return SimpleDialog(title: Text('Select folder'), children: [
          SimpleDialogOption(
              onPressed: null, child: Text('Loding folders... Please wait.'))
        ]);
      } else if (state is GetFoldersFromDialogSuccessState) {
        listOfFolder = state.list.map((e) {
          return DialogFolderItem(
            icon: Icons.folder,
            color: Colors.orange,
            text: e.folderName,
            onPressed: () {
              addToFolderBloc.addToFolder(
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
