import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:i_note_mobile/models/note.dart';
import 'package:intl/intl.dart';

import '../models/screen_arguments.dart';

class ChangePage extends StatefulWidget {
  @override
  _ChangePageState createState() => _ChangePageState();
}

class _ChangePageState extends State<ChangePage> {
  var currDt = DateTime.now();

  String title;
  String desc;
  String color = '0000FF';

  int id;
  String status;
  String mainTitle;
  String mainDesc;
  String mainColor;
  String timeButton = 'Когда напомнить?';
  DateTime pickedDateTime;

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
                  // Text('$title - $desc'),
                  TextFormField(
                    autofocus: true,
                    // initialValue: '',
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
                    initialValue: ' ',
                    decoration: const InputDecoration(
                      labelText: 'Текст',
                    ),
                    onChanged: (value) {
                      setState(() {
                        desc = value;
                      });
                    },
                    maxLines: 10,
                    validator: (val) {
                      return val.trim().isEmpty
                          ? 'Текст не должен быть пустым'
                          : null;
                    },
                  ),
                  TextButton(
                      onPressed: () async {
                        pickedDateTime = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                          builder: (context, child) {
                            return Theme(
                              data: ThemeData(
                                primarySwatch: Colors.amber,
                              ), // This will change to light theme.
                              child: child,
                            );
                          },
                        );
                        timeButton = DateFormat('dd-MM-yyyy hh:mm').format(pickedDateTime).toString();
                        setState(() {

                        });
                      },
                      child: Text(timeButton))
                  // TextButton(
                  //   onPressed: _askedToLead,
                  //   child: Text('Цвет'),
                  // ),
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

  void _askedToLead() {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text('Выбор цвета'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  color = '#F44336';
                  Navigator.of(context).pop();
                },
                child: const Text('Красный'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  color = '#FF9800';
                  Navigator.of(context).pop();
                },
                child: const Text('Оранжевый'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  color = '#FFEB3B';
                  Navigator.of(context).pop();
                },
                child: const Text('Желтый'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  color = '#4CAF50';
                  Navigator.of(context).pop();
                },
                child: const Text('Зеленый'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  color = '#2196F3';
                  Navigator.of(context).pop();
                },
                child: const Text('Синий'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  color = '#9C27B0';
                  Navigator.of(context).pop();
                },
                child: const Text('Фиолетовый'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  color = '#FFFFFF';
                  Navigator.of(context).pop();
                },
                child: const Text('Белый'),
              ),
            ],
          );
        });
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
