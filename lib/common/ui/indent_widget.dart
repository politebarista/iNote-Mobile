import 'package:flutter/material.dart';

class IndentWidget extends StatelessWidget {
  final Widget child;

  IndentWidget({required this.child});

  final double horizontalPadding = 16;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: child,
    );
  }
}
