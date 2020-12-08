import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/note.dart';
import 'pages/change_page.dart';
import 'pages/home_page.dart';
import 'pages/view_page.dart';
//import 'package:i_note_mobile/widgets/nav_bar.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  await Hive.openBox<Note>('note_box');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomePage(),
        '/view': (BuildContext context) => ViewPage(),
        '/change': (BuildContext context) => ChangePage(),
      },
      theme: ThemeData(
        primaryColor: Colors.amber,
        accentColor: Colors.amberAccent[400],
      ),
    );
  }
}
