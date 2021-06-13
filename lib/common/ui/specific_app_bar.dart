import 'package:flutter/material.dart';

class SpecificAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  SpecificAppBar(this.title);

  @override
  Size get preferredSize => const Size.fromHeight(55);

  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        ElevatedButton(
          onPressed: () {},
          child: Icon(Icons.account_circle, size: 28),
          style: ElevatedButton.styleFrom(
            fixedSize: Size(12,12),
            padding: EdgeInsets.all(10),
            shadowColor: Colors.transparent,
            shape: CircleBorder(),
          ),
        ),
      ],
    );
  }
}
