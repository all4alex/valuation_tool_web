import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  CustomDropdown(
      {required this.items,
      required this.hint,
      required this.onChanged,
      this.initialVal});
  final List<String?> items;
  final String hint;
  final Function(String?) onChanged;
  final String? initialVal;
  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? _chosenValue;
  @override
  void initState() {
    _chosenValue = widget.initialVal;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      height: 50,
      width: double.infinity,
      padding: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          )),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          focusColor: Colors.white,
          value: _chosenValue,
          isExpanded: true,
          style: TextStyle(color: Colors.white),
          iconEnabledColor: Colors.black,
          items: widget.items.map<DropdownMenuItem<String>>((String? value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value!,
                style: TextStyle(color: Colors.black),
              ),
            );
          }).toList(),
          hint: Container(
            child: Text(
              widget.hint,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
          ),
          onChanged: (String? value) {
            widget.onChanged(value);
            setState(() {
              _chosenValue = value!;
            });
          },
        ),
      ),
    );
  }
}
