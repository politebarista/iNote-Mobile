import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_note_mobile/data/entites/note.dart';
import 'package:i_note_mobile/meta/connection_tools.dart';
import 'package:i_note_mobile/modules/note_editing/note_editing_entities.dart';
import 'package:http/http.dart' as http;

class NoteEditingBloc extends Bloc<NoteEditingEvent, NoteEditingState> {
  final Note note;

  NoteEditingBloc(this.note) : super(NoteEditingInitialState(note));

  Stream<NoteEditingState> mapEventToState(NoteEditingEvent event) async* {
    if (event is NoteEditingSaveNoteEvent) {
      try{
        await _updateNote(event.note);
        yield NoteEditingSavingSuccessState();
      } catch(e) {
        yield NoteEditingErrorWhileSavingState();
      }
    } else {
      throw UnimplementedError();
    }
  }
  
  Future<void> _updateNote(Note note) async {
    await http.post(
      Uri.parse("${ConnectionTools.url}/editNote"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': note.id,
        'title': note.title,
        'description': note.description,
      }),
    ).timeout(Duration(seconds: 10));
  }
}