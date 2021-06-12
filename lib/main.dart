import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'meta/resolver.dart';
import 'modules/note_list/note_list_bloc.dart';
import 'modules/note_list/note_list_entities.dart';
import 'modules/note_list/note_list_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Resolver>(
          create: (_) => DefaultResolver(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocProvider(
          create: (_) => NoteListBloc()..add(NoteListGetNotesEvent()),
          child: NoteListWidget(),
        ),
      ),
    );
  }
}
