import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('iNote')),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/view');
          },
          child: Text('Открыть второе окно'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/change');
        },
        tooltip: 'Создание новой заметки',
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
