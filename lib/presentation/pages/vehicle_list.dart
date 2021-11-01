import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:valuation_tool_web/app/utils/dialogs/app_dialogs.dart';
import 'package:valuation_tool_web/bloc/folder/folder_bloc.dart';
import 'package:valuation_tool_web/bloc/folder/folder_state.dart';
import 'package:valuation_tool_web/bloc/vehicle_list/vehicle_list_bloc.dart';
import 'package:valuation_tool_web/bloc/vehicle_list/vehicle_list_state.dart';
import 'package:valuation_tool_web/models/firestore/folder_item.dart';
import 'package:valuation_tool_web/models/firestore/vehicle_item.dart';
import 'package:valuation_tool_web/models/vehicle_response.dart';

import '../widgets/add_vehicle_modal_body.dart';
import 'vehicle_details/vehicle_details.dart';

class VehicleListArgs {
  VehicleListArgs(this.folder);
  final String? folder;
}

class VehicleList extends StatefulWidget {
  const VehicleList(
      {Key? key,
      required this.onItemSelect,
      required this.onAddButtonClicked,
      required this.folder,
      required this.onFolderDeleted
      // required this.title,
      // required this.subTitle,
      // required this.vin,
      // required this.addedDate,
      // required this.folder,
      // required this.imageUrl
      })
      : super(key: key);
  final Function onItemSelect;
  final Function(String) onAddButtonClicked;
  final String folder;
  final Function onFolderDeleted;
  @override
  State<VehicleList> createState() => _VehicleListState();
}

class _VehicleListState extends State<VehicleList> {
  late List<VehicleItem> vehicleItemList = <VehicleItem>[];
  late VehicleListBloc vehicleListBloc;
  late FolderBloc folderBloc;

  late VehicleListArgs args = VehicleListArgs('All Vehicles');
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      args = ModalRoute.of(context)!.settings.arguments as VehicleListArgs;
      vehicleListBloc = BlocProvider.of<VehicleListBloc>(context);
      folderBloc = BlocProvider.of<FolderBloc>(context);
      if (args.folder == 'All Vehicles' || args.folder == 'Initial') {
        vehicleListBloc.getVehicleList();
      } else {
        vehicleListBloc.getVehicleListPerFolder(folderName: args.folder!);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return BlocBuilder<VehicleListBloc, VehicleListState>(
        builder: (BuildContext context, VehicleListState state) {
      String vehicleCount = '';
      String folderName = '';
      FolderItem? folderItem;
      if (state is VehicleListLoadingState) {
        return Center(child: CircularProgressIndicator());
      } else if (state is VehicleListFailedState) {
        return Center(child: Text('List is empty'));
      } else if (state is VehicleListSuccessState) {
        vehicleCount = '(${state.list.length})';
        vehicleItemList = state.list;
        folderItem = state.folderItem;
      }
      return Container(
        height: screenSize.height,
        width: screenSize.width / 1.4,
        margin: const EdgeInsets.only(top: 10, bottom: 10, left: 20),
        decoration: const BoxDecoration(
          color: Color(0xffF3F3F3),
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
          children: [
            Container(
                height: 60,
                alignment: Alignment.center,
                padding: EdgeInsets.all(20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('${args.folder}: '),
                    Text(vehicleCount, style: TextStyle(color: Colors.red)),
                    VerticalDivider(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                            height: 15,
                            width: 30,
                            child: SvgPicture.asset(
                                'assets/svg/vehicle_add_icon.svg',
                                fit: BoxFit.fitHeight)),
                        TextButton(
                            onPressed: () {
                              widget.onAddButtonClicked(args.folder!);
                            },
                            child: Text('Add Vehicle',
                                textAlign: TextAlign.center)),
                      ],
                    ),
                    Visibility(
                      visible: args.folder != 'All Vehicles',
                      child: Row(children: [
                        VerticalDivider(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                width: 30,
                                padding: EdgeInsets.zero,
                                alignment: Alignment.center,
                                child: Icon(Icons.edit,
                                    size: 20, color: Colors.blue)),
                            TextButton(
                                onPressed: () {
                                  // widget.onAddButtonClicked();
                                },
                                child: Text('Rename Folder',
                                    textAlign: TextAlign.center)),
                          ],
                        ),
                        VerticalDivider(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                width: 30,
                                padding: EdgeInsets.zero,
                                alignment: Alignment.center,
                                child: Icon(Icons.delete,
                                    size: 20, color: Colors.red)),
                            TextButton(
                                onPressed: () {
                                  if (folderItem != null) {
                                    AppDialogs.showDeleteDialog(
                                        context: context,
                                        title: 'Delete folder?',
                                        message:
                                            'This will delete all vehicles under this folder. But you can still see them on All Vehicles list.',
                                        onPositive: () {
                                          Navigator.of(context).pop();
                                          folderBloc.deleteFolder(
                                              folderItem: folderItem!,
                                              vehicleItemList: vehicleItemList);
                                        },
                                        onNegative: () {
                                          Navigator.of(context).pop();
                                        });
                                  }
                                },
                                child: Text('Delete Folder',
                                    textAlign: TextAlign.center)),
                          ],
                        ),
                      ]),
                    ),
                    Expanded(
                        flex: 1,
                        child: Container(
                          height: 15,
                          width: 15,
                          alignment: Alignment.bottomRight,
                          padding: EdgeInsets.zero,
                          child:
                              SvgPicture.asset('assets/svg/sort_desc_icon.svg'),
                        )),
                  ],
                )),
            const Divider(height: 0),
            BlocListener<FolderBloc, FolderState>(
                listener: (BuildContext context, FolderState state) {
              if (state is DeleteFolderSuccessState) {
                widget.onFolderDeleted();
              } else if (state is DeleteFolderFailedState) {
                _showDeleteFailedDialog(context);
              }
            }, child: BlocBuilder<FolderBloc, FolderState>(
                    builder: (BuildContext context, FolderState state) {
              if (state is DeleteFolderLoadingState) {
                return Center(child: CircularProgressIndicator());
              }
              return Expanded(
                  flex: 1,
                  child: ListView.builder(
                      itemCount: vehicleItemList.length,
                      itemBuilder: (BuildContext context, int i) {
                        VehicleItem vehicleItem = vehicleItemList[i];
                        return InkWell(
                          onTap: () {
                            widget.onItemSelect(vehicleItem.vin);
                          },
                          child: VehicleListItemWidget(
                              screenSize: screenSize, vehicleItem: vehicleItem),
                        );
                      }));
            })),
          ],
        ),
      );
    });
  }

  void _showDeleteFailedDialog(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Delete folder failed!'),
            content: Text('Unable to delete folder'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        });
  }
}

class VehicleListItemWidget extends StatelessWidget {
  const VehicleListItemWidget(
      {Key? key, required this.screenSize, required this.vehicleItem})
      : super(key: key);

  final Size screenSize;
  final VehicleItem vehicleItem;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: screenSize.width * .2,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: <Widget>[
                      Container(
                          height: 68,
                          width: 100,
                          decoration: BoxDecoration(
                              color: const Color(0xffF3F3F3),
                              border: Border.all(
                                  width: 1,
                                  style: BorderStyle.solid,
                                  color: Colors.black)),
                          child: CachedNetworkImage(
                            fit: BoxFit.fitHeight,
                            imageUrl: '${vehicleItem.imageUrl}_200x200',
                            errorWidget: (context, url, error) =>
                                Image.asset('assets/images/no_image.jpeg'),
                          )),
                      const SizedBox(width: 10),
                      Container(
                        width: screenSize.width * .1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(vehicleItem.name!,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.clip,
                                    fontSize: 14)),
                            Text(vehicleItem.subName!,
                                style: TextStyle(
                                    fontSize: 10, color: Color(0xff898989))),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: screenSize.width * .13,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(vehicleItem.vin!),
                      SizedBox(
                          height: 15,
                          width: 30,
                          child: SvgPicture.asset('assets/svg/copy_icon.svg',
                              color: Colors.green, fit: BoxFit.fitHeight)),
                    ],
                  ),
                ),
                Container(
                    width: screenSize.width * .08,
                    alignment: Alignment.centerLeft,
                    child: Text('${vehicleItem.miles} miles',
                        style: TextStyle(overflow: TextOverflow.clip))),
                Container(
                    width: screenSize.width * .08,
                    alignment: Alignment.centerLeft,
                    child: Text('${vehicleItem.addedDate}',
                        style: TextStyle(overflow: TextOverflow.clip))),
                Container(
                  width: screenSize.width * .12,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      SizedBox(
                          height: 15,
                          width: 30,
                          child: SvgPicture.asset('assets/svg/folder_icon.svg',
                              color: Color(0xff36334E), fit: BoxFit.fitHeight)),
                      SizedBox(
                        width: screenSize.width * .09,
                        child: Text('${vehicleItem.folder}',
                            style: TextStyle(overflow: TextOverflow.clip)),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  child: PopupMenuButton(
                    tooltip: 'Show options',
                    onSelected: (selected) {
                      if (selected == 'view') {
                        Navigator.pushNamed(context, '/main/details',
                            arguments: VehicleDetailsArgs(
                                vin: vehicleItem.vin,
                                mileage: null,
                                uvc: null,
                                isNew: false));
                      } else {
                        AppDialogs.showDeleteDialog(
                            context: context,
                            title: 'Delete vehicle?',
                            message: 'This will delete vehicle in your list.',
                            onPositive: () {
                              Navigator.of(context).pop();
                              BlocProvider.of<VehicleListBloc>(context)
                                  .deleteVehicle(
                                      id: vehicleItem.id!,
                                      folderName: vehicleItem.folder!);
                            },
                            onNegative: () {
                              Navigator.of(context).pop();
                            });
                      }
                    },
                    elevation: 3.2,
                    child: Padding(
                      padding: EdgeInsets.zero,
                      child: Icon(Icons.settings, color: Color(0xff494949)),
                    ),
                    // child: null,
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'view',
                        child: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.eye,
                              color: Colors.green,
                              size: 15,
                            ),
                            Text(
                              '  View Vehicle',
                              style:
                                  TextStyle(color: Colors.green, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'remove',
                        child: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.trash,
                              color: Colors.red,
                              size: 15,
                            ),
                            Text(
                              '  Remove Vehicle',
                              style: TextStyle(color: Colors.red, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider()
          ],
        ));
  }
}
