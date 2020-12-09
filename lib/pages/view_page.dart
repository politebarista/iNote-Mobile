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
          return ListView(
            children: <Widget>[
              Container(
                child: ListTile(
                  title: Text(box.getAt(args.id).title == null
                      ? ''
                      : box.getAt(args.id).title),
                  subtitle: Text(box.getAt(args.id).desc == null
                      ? ''
                      : box.getAt(args.id).desc),
                ),
              ),
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
