import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_note_mobile/data/api/project_api.dart';
import 'package:i_note_mobile/data/entites/note.dart';
import 'package:i_note_mobile/modules/details_note/details_note_bloc.dart';
import 'package:i_note_mobile/modules/details_note/details_note_widget.dart';
import 'package:i_note_mobile/modules/note_creation/note_creation_bloc.dart';
import 'package:i_note_mobile/modules/note_creation/note_creation_widget.dart';
import 'package:i_note_mobile/modules/note_editing/note_editing_bloc.dart';
import 'package:i_note_mobile/modules/note_editing/note_editing_widget.dart';
import 'package:i_note_mobile/modules/note_list/note_list_bloc.dart';
import 'package:i_note_mobile/modules/note_list/note_list_entities.dart';
import 'package:i_note_mobile/modules/note_list/note_list_widget.dart';

abstract class BaseResolver {
  Widget getNoteListWidget();

  Widget getNoteCreationWidget();

  Widget getDetailsNote(Note note);

  Widget getNoteEditingWidget(Note note);
}

class Resolver implements BaseResolver {
  @override
  Widget getNoteListWidget() {
    return BlocProvider(
      create: (context) => NoteListBloc(
        context.read<BaseProjectApi>(),
      )..add(
          NoteListGetNotesEvent(),
        ),
      child: NoteListWidget(),
    );
  }

  @override
  Widget getNoteCreationWidget() {
    return BlocProvider(
      create: (context) => NoteCreationBloc(
        context.read<BaseProjectApi>(),
      ),
      child: NoteCreationWidget(),
    );
  }

  @override
  Widget getDetailsNote(Note note) {
    return BlocProvider(
      create: (context) => DetailsNoteBloc(
        note,
        context.read<BaseProjectApi>(),
      ),
      child: DetailsNoteWidget(),
    );
  }

  @override
  Widget getNoteEditingWidget(Note note) {
    return BlocProvider(
      create: (context) => NoteEditingBloc(
        note,
        context.read<BaseProjectApi>(),
      ),
      child: NoteEditingWidget(),
    );
  }
}
