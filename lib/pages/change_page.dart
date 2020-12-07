import 'package:flutter/material.dart';

class ChangePage extends StatefulWidget {
  @override
  _ChangePageState createState() => _ChangePageState();
}

class _ChangePageState extends State<ChangePage> {
  String title;
  String desc;
  String color;
  String lastChange;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Создание новой заметки')),
      body: Text('asd'),
    );
  }
}
