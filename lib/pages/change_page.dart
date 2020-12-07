import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:i_note_mobile/models/note.dart';

class ChangePage extends StatefulWidget {
  @override
  _ChangePageState createState() => _ChangePageState();
}

class _ChangePageState extends State<ChangePage> {
  String title;
  String desc;
  String color = 'blue';
  String lastChange = 'some date'; // заменить

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Создание новой заметки')),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  autofocus: true,
                  initialValue: '',
                  decoration: const InputDecoration(
                    labelText: 'Название',
                  ),
                  onChanged: (value) {
                    setState(() {
                      title = value;
                    });
                  },
                  validator: (val) {
                    return val.trim().isEmpty
                        ? 'Название не должно быть пустым'
                        : null;
                  },
                ),
                TextFormField(
                  initialValue: '',
                  decoration: const InputDecoration(
                    labelText: 'Текст',
                  ),
                  onChanged: (value) {
                    setState(() {
                      desc = value;
                    });
                  },
                  validator: (val) {
                    return val.trim().isEmpty
                        ? 'Название не должно быть пустым'
                        : null;
                  },
                ),
                OutlineButton(
                  child: Text('Добавить к списку'),
                  onPressed: _validateAndSave,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      _onFormSubmit();
    } else {
      print('Форма заполнена неверно'); // желательно заменить
    }
  }

  void _onFormSubmit() {
    Box<Note> contactsBox = Hive.box<Note>('note_box');
    contactsBox.add(
      Note(
        title: title,
        desc: desc,
        color: color,
        lastChange: lastChange,
      ),
    );
    Navigator.of(context).pop();
  }
}
