import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:i_note_mobile/models/note.dart';
import 'package:i_note_mobile/models/screen_arguments.dart';

class ViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(title: Text(args.title)),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Note>('note_box').listenable(),
        builder: (context, Box<Note> box, _) {
          return Column(
            children: <Widget>[
              Text(box.getAt(args.id).title),
              Text(box.getAt(args.id).desc),
              Text(box.getAt(args.id).lastChange),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/change',
            arguments:
                ScreenArguments('changing', args.id, 'Редактировать заметку'),
          );
        },
        tooltip: 'Создание новой заметки',
        child: Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
    );
  }
}
