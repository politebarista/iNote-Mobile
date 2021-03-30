import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:i_note_mobile/models/hex_color.dart';
import 'package:i_note_mobile/models/note.dart';
import 'package:i_note_mobile/models/screen_arguments.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('iNote')),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Note>('note_box').listenable(),
        builder: (context, Box<Note> box, _) {
          if (box.values.isEmpty)
            return Center(
              child: Text('Список дел пуст'),
            );
          return ListView.builder(
              itemCount: box.values.length,
              itemBuilder: (context, index) {
                Note res = box.getAt(index);
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/view',
                      arguments: ScreenArguments('viewing', index, res.title),
                    );
                  },
                  child: Dismissible(
                    background: Container(color: Colors.red),
                    key: UniqueKey(),
                    onDismissed: (direction) {
                      res.delete();
                    },
                    child: ListTile(
                      title: Text(
                        res.title == null ? '' : res.title,
                        // style: TextStyle(color: Colors.black),
                        // style: TextStyle(color: HexColor(res.color)),
                      ),
                      subtitle: Text(
                        res.desc == null ? '' : res.desc,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                      ),
                    ),
                  ),
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/change',
            arguments: ScreenArguments('creating'),
          );
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
