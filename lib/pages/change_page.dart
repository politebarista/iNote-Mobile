import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:i_note_mobile/models/note.dart';

import '../models/screen_arguments.dart';

class ChangePage extends StatefulWidget {
  @override
  _ChangePageState createState() => _ChangePageState();
}

class _ChangePageState extends State<ChangePage> {
  String title;
  String desc;
  String color = 'blue';
  String lastChange = 'some date'; // заменить

  int id;
  String status;
  String mainTitle;
  String mainDesc;
  String mainColor;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;

    switch (args.status) {
      case ('changing'):
        mainTitle = Hive.box<Note>('note_box').getAt(args.id).title;
        mainDesc = Hive.box<Note>('note_box').getAt(args.id).desc;
        mainColor = Hive.box<Note>('note_box').getAt(args.id).color;
        id = args.id;
        status = args.status;
        break;
      case ('creating'):
        mainTitle = 'Название';
        mainDesc = 'Текст';
        mainColor = 'amber';
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(args.title != null ? args.title : 'Создание новой заметки'),
      ),
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
                        ? 'Текст не должен быть пустым'
                        : null;
                  },
                ),
                OutlineButton(
                  child: Text(status == 'creating'
                      ? 'Добавить к списку'
                      : 'Сохранить изменения'),
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
      status == 'creating' ? _onFormSubmit() : _checkChanges();
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

  void _checkChanges() {
    if (mainTitle != title || mainDesc != desc || mainColor != color) {
      _onFormChange();
    } else {
      _onFormChange();
    }
  }

  void _onFormChange() {
    Box<Note> contactsBox = Hive.box<Note>('note_box');
    contactsBox.put(
      id,
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
