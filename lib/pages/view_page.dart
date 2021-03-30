import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:i_note_mobile/models/hex_color.dart';
import 'package:i_note_mobile/models/note.dart';
import 'package:i_note_mobile/models/screen_arguments.dart';

class ViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(title: Text(args.title)),
      body: Container(
        padding: EdgeInsets.only(
          left: 15.0,
          top: 10.0,
          right: 15.0,
        ),
        child: ValueListenableBuilder(
          valueListenable: Hive.box<Note>('note_box').listenable(),
          builder: (context, Box<Note> box, _) {
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    box.getAt(args.id).title,
                    style: TextStyle(
                      fontSize: 22,
                      // backgroundColor: HexColor(box.getAt(args.id).color),
                    ),
                  ),
                  Divider(),
                  Text(
                    box.getAt(args.id).desc,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Divider(),
                  Text(
                    box.getAt(args.id).lastChange,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  // Text(box.getAt(args.id).color),
                  // Text('${HexColor('#FF0000')}'),
                ],
              ),
            );
          },
        ),
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
