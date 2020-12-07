import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Главное окно')),
      body: Center(
          child: RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/view');
              },
              child: Text('Открыть второе окно'))),
    );
  }
}
