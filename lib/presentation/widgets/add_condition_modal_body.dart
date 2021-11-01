import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:valuation_tool_web/presentation/widgets/modal/modal_footer.dart';
import 'package:valuation_tool_web/presentation/widgets/modal/modal_header.dart';

class AddConditionModalBody extends StatefulWidget {
  const AddConditionModalBody({Key? key}) : super(key: key);
  @override
  State<AddConditionModalBody> createState() => _AddConditionModalBodyState();
}

class _AddConditionModalBodyState extends State<AddConditionModalBody> {
  final _formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> conditionList = [
    {
      'name': 'Rough',
      'description': 'Significant damage and wear. Needs repairs.',
      'isSelected': false
    },
    {
      'name': 'Average',
      'description':
          'Typical wear and tear for a vehicle with this mileage. Systems all functional.',
      'isSelected': true
    },
    {
      'name': 'Clean',
      'description':
          'In better condition than most vehicles with this mileage. No damage and very few cosmetic defects.',
      'isSelected': false
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  void _onSave() {
    print('SAVE...');
    if (_formKey.currentState!.validate()) {
      // api call...
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      width: 350,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: Material(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  ModalHeader(
                      title: 'Change Condition',
                      subTitle: 'select based on your needs'),
                  const SizedBox(height: 10),
                  Container(
                    height: screenSize.height * .45,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: conditionList
                          .map(
                            (e) => Container(
                              margin: EdgeInsets.only(bottom: 20),
                              width: double.infinity,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: e['isSelected'] == true
                                    ? Color(0xffFFC32E)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    e['name']!,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    e['description']!,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: e['isSelected'] == true
                                          ? Colors.black
                                          : Color(0xff898989),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  ModalFooter(
                    onSave: _onSave,
                    color: Colors.green,
                    icon: FontAwesomeIcons.syncAlt,
                    submitName: 'UPDATE',
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
