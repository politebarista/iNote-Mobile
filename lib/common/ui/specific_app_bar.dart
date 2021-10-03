import 'package:flutter/material.dart';

class SpecificAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  SpecificAppBar(this.title);

  @override
  Size get preferredSize => const Size.fromHeight(55);

  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
    );
  }
}
