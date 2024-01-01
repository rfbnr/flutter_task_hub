import 'package:flutter/material.dart';

import '../../../core/constants/font_weight.dart';

class RadioButton extends StatefulWidget {
  const RadioButton({super.key});

  @override
  State<RadioButton> createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  String _userType = "user";
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Roles",
            style: TextStyle(
              fontSize: 14,
              fontWeight: AppFontWeight.regular,
            ),
          ),
          const SizedBox(height: 6),
          RadioListTile(
            value: "user",
            title: const Text("User"),
            groupValue: _userType,
            onChanged: (value) {
              setState(() {
                _userType = value as String;
              });
            },
          ),
          RadioListTile(
            value: "admin",
            title: const Text("Admin"),
            groupValue: _userType,
            onChanged: (value) {
              setState(() {
                _userType = value as String;
              });
            },
          ),
          // SizedBox(height: 20),
          // Text(
          //   'Selected: $_userType',
          //   style: TextStyle(fontSize: 18),
          // ),
        ],
      ),
    );
  }
}
