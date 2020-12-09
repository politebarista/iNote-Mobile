import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:i_note_mobile/models/note.dart';

import '../models/screen_arguments.dart';

class ChangePage extends StatefulWidget {
  @override
  _ChangePageState createState() => _ChangePageState();
}

class _ChangePageState extends State<ChangePage> {
  var currDt = DateTime.now();

  String title;
  String desc;
  String color = 'blue';

  int id;
  String status;
  String mainTitle;
  String mainDesc;
  String mainColor;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;

    if (args.status == 'changing') {
      mainTitle = Hive.box<Note>('note_box').getAt(args.id).title;
      mainDesc = Hive.box<Note>('note_box').getAt(args.id).desc;
      mainColor = Hive.box<Note>('note_box').getAt(args.id).color;
    }
    id = args.id;
    status = args.status;

    return WillPopScope(
      onWillPop: () async {
        if (title == null || desc == null) {
          Navigator.of(context).pop();
        } else {
          status == 'creating'
              ? Navigator.of(context).pop()
              : _validateAndSave();
        }

        // Замена события
        // Navigator.of(context).pop();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title:
              Text(args.title != null ? args.title : 'Создание новой заметки'),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Text('$status - $id'),
                  Text('$title - $desc'),
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
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (status == 'changing') status = 'saving';
            _validateAndSave();
          },
          tooltip: 'Сохранение',
          child: Icon(
            Icons.save,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      switch (status) {
        case 'creating':
          _onFormSubmit();
          break;
        case 'changing':
          _checkChanges();
          break;
        case 'saving':
          _onFormChange();
          break;
      }
      // status == 'creating' ? _onFormSubmit() : _checkChanges();
    } else {
      print(
          'Форма заполнена неверно'); // желательно заменить на всплывающий бар
    }
  }

  void _onFormSubmit() {
    Box<Note> noteBox = Hive.box<Note>('note_box');
    noteBox.add(
      Note(
        title: title,
        desc: desc,
        color: color,
        lastChange:
            '${currDt.hour + 7}:${currDt.minute} - ${currDt.day}.${currDt.month}.${currDt.year}',
      ),
    );
    Navigator.of(context).pop();
  }

  void _checkChanges() {
    if (mainTitle != title || mainDesc != desc || mainColor != color) {
      _showMyDialog();
      // _onFormChange();
    } else {
      _onFormChange();
    }
  }

  void _onFormChange() {
    Box<Note> noteBox = Hive.box<Note>('note_box');
    noteBox.putAt(
      id,
      Note(
        title: title,
        desc: desc,
        color: color,
        lastChange:
            '${currDt.hour + 7}:${currDt.minute} - ${currDt.day}.${currDt.month}.${currDt.year}',
      ),
    );
    Navigator.of(context).pop();
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // title: Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Были внесены изменения.'),
                Text('Сохранить их?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Сохранить'),
              onPressed: () {
                // Navigator.of(context).pop();
                _onFormChange();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Не сохранять'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
