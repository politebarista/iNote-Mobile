import 'package:flutter/material.dart';

class CustomizedButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;

  CustomizedButton({
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(text),
      onPressed: onPressed,
    );
  }
}
