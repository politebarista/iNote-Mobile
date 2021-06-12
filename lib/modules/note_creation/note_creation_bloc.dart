import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_note_mobile/data/entites/note.dart';
import 'package:i_note_mobile/meta/connection_tools.dart';
import 'package:i_note_mobile/modules/note_creation/note_creation_entities.dart';
import 'package:http/http.dart' as http;

class NoteCreationBloc extends Bloc<NoteCreationEvent, NoteCreationState> {
  NoteCreationBloc() : super(NoteCreationInitialState());

  Stream<NoteCreationState> mapEventToState(NoteCreationEvent event) async* {
    if (event is NoteCreationCreateNoteEvent) {
      _createNewNote(event.note);
    } else {
      throw UnimplementedError();
    }
  }

  Future<void> _createNewNote(Note note) async {
    await http.post(
      Uri.parse("${ConnectionTools.url}/addNote"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String?>{
        'title': note.title,
        'description': note.description,
      }),
    );
  }
}
