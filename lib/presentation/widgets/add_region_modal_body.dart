import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:valuation_tool_web/bloc/states/states_bloc.dart';
import 'package:valuation_tool_web/bloc/states/states_state.dart';
import 'package:valuation_tool_web/bloc/vehicle_info/vehicle_info_state.dart';
import 'package:valuation_tool_web/models/blackbook/state_response.dart';
import 'package:valuation_tool_web/presentation/widgets/modal/modal_footer.dart';
import 'package:valuation_tool_web/presentation/widgets/modal/modal_header.dart';

class AddRegionModalBody extends StatefulWidget {
  const AddRegionModalBody({Key? key}) : super(key: key);
  @override
  State<AddRegionModalBody> createState() => _AddRegionModalBodyState();
}

class _AddRegionModalBodyState extends State<AddRegionModalBody>
    with SingleTickerProviderStateMixin {
  TextEditingController regionTextEditingController = TextEditingController();
  final TextEditingController _typeAheadController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  List regions = [];
  late void Function(AnimationStatus) _statusListener;
  late AnimationController _animationController;
  late SuggestionsBoxController _suggestionsBoxController;
  List<StateList> stateList = <StateList>[];
  late StatesBloc statesBloc;

  @override
  void initState() {
    statesBloc = BlocProvider.of<StatesBloc>(context);
    statesBloc.getAllStates();
    _animationController = AnimationController(vsync: this);
    _suggestionsBoxController = SuggestionsBoxController();

    _statusListener = (AnimationStatus status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        _suggestionsBoxController.resize();
      }
    };
    _animationController.addStatusListener(_statusListener);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.removeStatusListener(_statusListener);
    _animationController.dispose();
    super.dispose();
  }

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      // api call...
    }
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
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  ModalHeader(
                      title: 'Region', subTitle: 'Place vehicle region'),
                  const SizedBox(height: 10),
                  Container(
                    // height: screenSize.height * .3,
                    height: screenSize.height * .2,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 20),
                        Text('Region',
                            textAlign: TextAlign.start,
                            style: GoogleFonts.roboto(fontSize: 14)),
                        const SizedBox(height: 5),
                        BlocBuilder<StatesBloc, StatesState>(
                            builder: (BuildContext context, StatesState state) {
                          if (state is GetStatesLoadingState) {
                            return Center(
                                child: const CircularProgressIndicator());
                          } else if (state is GetStatesSuccessState) {
                            stateList = state.stateList!;
                          }
                          return TypeAheadFormField(
                            textFieldConfiguration: TextFieldConfiguration(
                              controller: this._typeAheadController,
                              decoration: InputDecoration(
                                hintText: 'Enter Vehicle Region',
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                              ),
                            ),
                            suggestionsCallback: (pattern) {
                              final List<Map> regions =
                                  stateList.map((e) => e.toJson()).toList();
                              List<Map> matches = <Map>[];

                              matches.addAll(regions);
                              matches.retainWhere((region) => region['name']
                                  .toLowerCase()
                                  .contains(pattern.toLowerCase()));
                              return matches;
                            },
                            itemBuilder: (context, Map suggestion) {
                              return ListTile(
                                title: Text(suggestion['name']),
                              );
                            },
                            transitionBuilder:
                                (context, suggestionsBox, controller) {
                              return suggestionsBox;
                            },
                            onSuggestionSelected: (Map suggestion) {
                              this._typeAheadController.text =
                                  suggestion['name'];
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please select a region';
                              }
                            },
                            // onSaved: (value) => this._selectedCity = value,
                          );
                        }),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                  ModalFooter(
                    onSave: _onSave,
                    color: Colors.blue,
                    icon: FontAwesomeIcons.save,
                    submitName: 'SAVE',
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
