import 'package:flutter/material.dart';

class CustomizedTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;

  CustomizedTextField({
    required this.controller,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }
}
