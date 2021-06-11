import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_note_mobile/modules/note_list/note_list_bloc.dart';
import 'package:i_note_mobile/modules/note_list/note_list_entities.dart';
import 'package:i_note_mobile/modules/note_list/note_list_widget.dart';

class Routes {
  final BuildContext context;

  late final Map<String, Widget Function(BuildContext)> routes;

  Routes(this.context) {
    routes = {
      '/': (context) => BlocProvider(
            create: (_) => NoteListBloc()..add(NoteListGetNotesEvent()),
            child: NoteListWidget(),
          ),
    };
  }
}
