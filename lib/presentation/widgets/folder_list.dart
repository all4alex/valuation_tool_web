import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:valuation_tool_web/bloc/folder/folder_bloc.dart';
import 'package:valuation_tool_web/bloc/folder/folder_state.dart';
import 'package:valuation_tool_web/models/firestore/folder_item.dart';
import 'package:valuation_tool_web/presentation/pages/vehicle_list.dart';

import 'folder_menu_item.dart';

class FolderList extends StatefulWidget {
  @override
  State<FolderList> createState() => _FolderListState();
}

class _FolderListState extends State<FolderList> {
  late FolderBloc folderBloc;
  List<FolderItem> folderItemList = <FolderItem>[];
  TextStyle roboto = GoogleFonts.roboto();
  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
  final ScrollController _scrollController = ScrollController();
  TextEditingController folderTextController = TextEditingController();

  @override
  void initState() {
    folderBloc = BlocProvider.of<FolderBloc>(context);

    if (window.location.href.contains('/main/vehicles')) {
      folderBloc.getAllFolder();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.centerLeft,
            child: Text('My Lists', style: roboto.copyWith(fontSize: 20))),
        BlocBuilder<FolderBloc, FolderState>(
            builder: (BuildContext context, FolderState state) {
          if (state is GetFoldersSuccessState) {
            folderItemList = state.list;
          } else if (state is AddFolderLoadingState ||
              state is GetFoldersLoadingState) {
            return CircularProgressIndicator();
          }
          return Container(
            height: screenSize.height * .3,
            child: Scrollbar(
              controller: _scrollController,
              isAlwaysShown: true,
              child: ListView.separated(
                controller: _scrollController,
                itemCount: folderItemList.length,
                itemBuilder: (BuildContext context, int i) {
                  return FolderMenuItem(
                    icon: SvgPicture.asset('assets/svg/folder_icon.svg'),
                    title: ' ${folderItemList[i].folderName}',
                    isSelected: false,
                    folderCount: folderItemList[i].folderCount!,
                    onPressed: () {
                      Navigator.pushNamed(context,
                          '/main/folders/${folderItemList[i].folderName}',
                          arguments:
                              VehicleListArgs(folderItemList[i].folderName));
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(height: 0);
                },
              ),
            ),
          );
        }),
        const SizedBox(height: 30),
        ElevatedButton(
          style: style,
          onPressed: () {
            _showNewFolderModal(context);
          },
          child: SizedBox(
            width: 170,
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 15,
                  width: 40,
                  child: SvgPicture.asset(
                    'assets/svg/folder_add_icon.svg',
                    color: Colors.white,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                const Text('ADD LIST', style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showNewFolderModal(BuildContext context) async {
    showGeneralDialog(
      barrierDismissible: false,
      transitionDuration: const Duration(milliseconds: 0),
      context: context,
      pageBuilder: (BuildContext context, anim1, anim2) {
        return Align(
            alignment: Alignment.center,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                width: 570,
                height: 300,
                alignment: Alignment.center,
                child: Material(
                  child: Column(
                    children: <Widget>[
                      Container(
                          height: 70,
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          color: Colors.blue,
                          child: Text('Add Folder',
                              style: GoogleFonts.roboto(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white))),
                      Column(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 30),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Folder name',
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.roboto(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 10),
                                Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10),
                                      )),
                                  child: TextFormField(
                                    controller: folderTextController,
                                    textAlignVertical: TextAlignVertical.center,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 20),
                                    onChanged: (String text) {
                                      // onChanged!(text);
                                    },
                                    onEditingComplete: () {
                                      // onEditingComplete;
                                    },
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.all(15),
                                        hintText:
                                            'Please enter a folder name here',
                                        hintStyle: TextStyle(fontSize: 15)),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.red),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Container(
                                        width: 220,
                                        height: 60,
                                        alignment: Alignment.center,
                                        child: const Text('Cancel',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.blue),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        folderBloc.addFolder(
                                            folderItem: FolderItem(
                                                folderName:
                                                    folderTextController.text,
                                                user: 'alex.ayso@valuation.com',
                                                folderCount: 0));
                                        folderTextController.clear();
                                      },
                                      child: Container(
                                        width: 220,
                                        height: 60,
                                        alignment: Alignment.center,
                                        child: const Text('Add Vehicle',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ));
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
}
