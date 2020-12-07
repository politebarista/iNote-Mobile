import 'package:flutter/material.dart';

class ViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Второе окно')),
      body: Center(
          child: RaisedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Назад'))),
    );
  }
}
