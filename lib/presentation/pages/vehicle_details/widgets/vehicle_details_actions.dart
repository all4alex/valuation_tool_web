import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:valuation_tool_web/bloc/folder/add_to_folder/add_to_folder_state.dart';
import 'package:valuation_tool_web/bloc/folder/add_to_folder/add_to_folder_bloc.dart';
import 'package:valuation_tool_web/bloc/folder/folder_bloc.dart';
import 'package:valuation_tool_web/models/firestore/vehicle_item.dart';
import 'package:valuation_tool_web/presentation/pages/vehicle_details/vehicle_details.dart';
import 'package:valuation_tool_web/presentation/widgets/add_vehicle_modal_body.dart';
import 'package:valuation_tool_web/presentation/widgets/select_folder_dialog_body.dart';

class VehicleDetailsActions extends StatefulWidget {
  VehicleDetailsActions({required this.folderName, required this.vehicleItem});
  final String folderName;
  final VehicleItem vehicleItem;
  @override
  State<VehicleDetailsActions> createState() => _VehicleDetailsActionsState();
}

class _VehicleDetailsActionsState extends State<VehicleDetailsActions> {
  String folderName = '';
  @override
  void initState() {
    folderName = widget.folderName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      height: 110,
      child: Column(
        children: [
          Container(
            height: 30,
            child: Row(
              children: [
                InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SelectFolderDialogBody(
                              vehicleItem: widget.vehicleItem,
                            );
                          });
                    },
                    child: Row(children: [
                      SizedBox(
                          height: 15,
                          child: SvgPicture.asset('assets/svg/folder_icon.svg',
                              color: Color(0xff36334E), fit: BoxFit.fitHeight)),
                      BlocListener<AddToFolderBloc, AddToFolderState>(listener:
                          (BuildContext context, AddToFolderState state) {
                        if (state is AddToFolderSuccessState) {
                          BlocProvider.of<FolderBloc>(context).getAllFolder();
                        }
                      }, child: BlocBuilder<AddToFolderBloc, AddToFolderState>(
                          builder:
                              (BuildContext context, AddToFolderState state) {
                        String? newFolderName;
                        if (state is AddToFolderLoadingState) {
                          return Text('  Adding...',
                              style: TextStyle(fontSize: 10));
                        } else if (state is AddToFolderSuccessState) {
                          newFolderName = state.folderName;
                        }
                        return Text(newFolderName ?? folderName,
                            style: TextStyle(fontSize: 10));
                      })),
                    ])),
                VerticalDivider(),
                InkWell(
                    onTap: () {
                      // showDialog(
                      //     context: context,
                      //     builder: (BuildContext context) {
                      //       return SelectFolderDialogBody(
                      //           vehicleItem: widget.vehicleItem);
                      //     });
                    },
                    child: Row(children: [
                      SizedBox(
                          height: 15,
                          child: Icon(Icons.camera_alt,
                              color: Colors.blue, size: 17)),
                      Text('  Upload Photo',
                          style: TextStyle(fontSize: 10, color: Colors.blue))
                    ])),
                VerticalDivider(),
                InkWell(
                    onTap: () {},
                    child: Row(children: [
                      SizedBox(
                          height: 15,
                          child: Icon(Icons.ios_share,
                              color: Colors.green, size: 17)),
                      Text('  Share Vehicle', style: TextStyle(fontSize: 10))
                    ])),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
