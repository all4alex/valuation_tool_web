import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
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
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
    _suggestionsBoxController = SuggestionsBoxController();

    _statusListener = (AnimationStatus status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        _suggestionsBoxController.resize();
      }
    };

    _animationController.addStatusListener(_statusListener);
  }

  @override
  void dispose() {
    _animationController.removeStatusListener(_statusListener);
    _animationController.dispose();
    super.dispose();
  }

  void _onSave() {
    print('SAVE...${_typeAheadController.text}');

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
                        TypeAheadFormField(
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
                            return RegionService.getSuggestions(pattern);
                          },
                          itemBuilder: (context, Map suggestion) {
                            print('ITEM BUILDER: $suggestion');
                            return ListTile(
                              title: Text(suggestion['name']),
                            );
                          },
                          transitionBuilder:
                              (context, suggestionsBox, controller) {
                            return suggestionsBox;
                          },
                          onSuggestionSelected: (Map suggestion) {
                            print('SUGGESTION SELECTED: $suggestion');
                            this._typeAheadController.text = suggestion['name'];
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please select a region';
                            }
                          },
                          // onSaved: (value) => this._selectedCity = value,
                        ),
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

class RegionService {
  static final List<Map> regions = [
    {"name": "Alabama", "shortCode": "AL"},
    {"name": "Alaska", "shortCode": "AK"},
    {"name": "American Samoa", "shortCode": "AS"},
    {"name": "Arizona", "shortCode": "AZ"},
    {"name": "Arkansas", "shortCode": "AR"},
    {"name": "California", "shortCode": "CA"},
    {"name": "Colorado", "shortCode": "CO"},
    {"name": "Connecticut", "shortCode": "CT"},
    {"name": "Delaware", "shortCode": "DE"},
    {"name": "District of Columbia", "shortCode": "DC"},
    {"name": "Micronesia", "shortCode": "FM"},
    {"name": "Florida", "shortCode": "FL"},
    {"name": "Georgia", "shortCode": "GA"},
    {"name": "Guam", "shortCode": "GU"},
    {"name": "Hawaii", "shortCode": "HI"},
    {"name": "Idaho", "shortCode": "ID"},
    {"name": "Illinois", "shortCode": "IL"},
    {"name": "Indiana", "shortCode": "IN"},
    {"name": "Iowa", "shortCode": "IA"},
    {"name": "Kansas", "shortCode": "KS"},
    {"name": "Kentucky", "shortCode": "KY"},
    {"name": "Louisiana", "shortCode": "LA"},
    {"name": "Maine", "shortCode": "ME"},
    {"name": "Marshall Islands", "shortCode": "MH"},
    {"name": "Maryland", "shortCode": "MD"},
    {"name": "Massachusetts", "shortCode": "MA"},
    {"name": "Michigan", "shortCode": "MI"},
    {"name": "Minnesota", "shortCode": "MN"},
    {"name": "Mississippi", "shortCode": "MS"},
    {"name": "Missouri", "shortCode": "MO"},
    {"name": "Montana", "shortCode": "MT"},
    {"name": "Nebraska", "shortCode": "NE"},
    {"name": "Nevada", "shortCode": "NV"},
    {"name": "New Hampshire", "shortCode": "NH"},
    {"name": "New Jersey", "shortCode": "NJ"},
    {"name": "New Mexico", "shortCode": "NM"},
    {"name": "New York", "shortCode": "NY"},
    {"name": "North Carolina", "shortCode": "NC"},
    {"name": "North Dakota", "shortCode": "ND"},
    {"name": "Northern Mariana Islands", "shortCode": "MP"},
    {"name": "Ohio", "shortCode": "OH"},
    {"name": "Oklahoma", "shortCode": "OK"},
    {"name": "Oregon", "shortCode": "OR"},
    {"name": "Palau", "shortCode": "PW"},
    {"name": "Pennsylvania", "shortCode": "PA"},
    {"name": "Puerto Rico", "shortCode": "PR"},
    {"name": "Rhode Island", "shortCode": "RI"},
    {"name": "South Carolina", "shortCode": "SC"},
    {"name": "South Dakota", "shortCode": "SD"},
    {"name": "Tennessee", "shortCode": "TN"},
    {"name": "Texas", "shortCode": "TX"},
    {"name": "Utah", "shortCode": "UT"},
    {"name": "Vermont", "shortCode": "VT"},
    {"name": "Virgin Islands", "shortCode": "VI"},
    {"name": "Virginia", "shortCode": "VA"},
    {"name": "Washington", "shortCode": "WA"},
    {"name": "West Virginia", "shortCode": "WV"},
    {"name": "Wisconsin", "shortCode": "WI"},
    {"name": "Wyoming", "shortCode": "WY"},
    {"name": "Armed Forces Americas", "shortCode": "AA"},
    {
      "name": "Armed Forces Europe, Canada, Africa and Middle East",
      "shortCode": "AE"
    },
    {"name": "Armed Forces Pacific", "shortCode": "AP"}
  ];

  static List<Map> getSuggestions(String query) {
    List<Map> matches = <Map>[];

    matches.addAll(regions);

    matches.retainWhere(
        (region) => region['name'].toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}
