import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  late FToast fToast;
  @override
  void initState() {
    fToast = FToast();
    fToast.init(context);
    folderBloc = BlocProvider.of<FolderBloc>(context);

    if (window.location.href.contains('/main/vehicles')) {
      folderBloc.getAllFolder();
    }

    super.initState();
  }

  void showErrorToast(String message) {
    Widget toastBody = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.red,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(Icons.error, color: Colors.white),
          SizedBox(
            width: 12.0,
          ),
          Text(message, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
    fToast.removeCustomToast();
    fToast.showToast(
      child: toastBody,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
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
                width: 450,
                height: 270,
                alignment: Alignment.center,
                child: Material(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                            height: 70,
                            width: double.infinity,
                            padding: const EdgeInsets.all(15),
                            decoration: const BoxDecoration(
                              color: Color(0xffF3F3F3),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0.0, 1.0),
                                    blurRadius: 6.0,
                                    spreadRadius: 0),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Add Folder',
                                    style: GoogleFonts.roboto(
                                        fontSize: 18,
                                        color: Color(0xff191919),
                                        fontWeight: FontWeight.bold)),
                                Text('Create a folder of your vehicle list',
                                    style: GoogleFonts.roboto(
                                        fontSize: 12, color: Color(0xff191919)))
                              ],
                            )),
                        const SizedBox(height: 30),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Folder Name',
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.roboto(fontSize: 14)),
                              const SizedBox(height: 5),
                              Container(
                                alignment: Alignment.center,
                                height: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(5),
                                    )),
                                child: TextFormField(
                                  controller: folderTextController,
                                  textAlignVertical: TextAlignVertical.center,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 16),
                                  onChanged: (String text) {
                                    // onChanged!(text);
                                  },
                                  onEditingComplete: () {
                                    // onEditingComplete;
                                  },
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(15),
                                      hintText: 'Enter Folder Name',
                                      hintStyle: TextStyle(fontSize: 14)),
                                ),
                              ),
                              const SizedBox(height: 30),
                            ],
                          ),
                        ),
                        Container(
                            height: 70,
                            width: double.infinity,
                            padding: const EdgeInsets.all(15),
                            alignment: Alignment.bottomCenter,
                            decoration: const BoxDecoration(
                              color: Color(0xffF3F3F3),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0.0, 1.0),
                                    blurRadius: 6.0,
                                    spreadRadius: 0),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Row(
                                      children: [
                                        Icon(Icons.close, color: Colors.red),
                                        Text('  CANCEL',
                                            style:
                                                TextStyle(color: Colors.red)),
                                      ],
                                    )),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xff494949),
                                  ),
                                  onPressed: () {
                                    if (folderTextController.text.isNotEmpty) {
                                      Navigator.of(context).pop();
                                      folderBloc.addFolder(
                                          folderItem: FolderItem(
                                              folderName:
                                                  folderTextController.text,
                                              user: 'alex.ayso@valuation.com',
                                              folderCount: 0));
                                      folderTextController.clear();
                                    } else {
                                      showErrorToast(
                                          'Folder Name cannot be empty');
                                    }
                                  },
                                  child: Container(
                                    width: 220,
                                    height: 60,
                                    alignment: Alignment.center,
                                    child: const Text('Add Folder',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
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
