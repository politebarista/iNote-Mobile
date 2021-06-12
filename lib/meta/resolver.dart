import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_note_mobile/data/entites/note.dart';
import 'package:i_note_mobile/modules/note_creation/note_creation_bloc.dart';
import 'package:i_note_mobile/modules/note_creation/note_creation_widget.dart';
import 'package:i_note_mobile/modules/note_list/note_list_bloc.dart';
import 'package:i_note_mobile/modules/note_list/note_list_entities.dart';
import 'package:i_note_mobile/modules/note_list/note_list_widget.dart';

abstract class Resolver {
  Widget getNoteListWidget();

  Widget getNoteCreationWidget();
}

class DefaultResolver implements Resolver{
  @override
  Widget getNoteListWidget() {
    return BlocProvider(
      create: (_) => NoteListBloc()..add(NoteListGetNotesEvent()),
      child: NoteListWidget(),
    );
  }

  @override
  Widget getNoteCreationWidget() {
    return BlocProvider(
      create: (_) => NoteCreationBloc(),
      child: NoteCreationWidget(),
    );
  }
}