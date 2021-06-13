import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_note_mobile/data/entites/note.dart';
import 'package:i_note_mobile/meta/connection_tools.dart';
import 'package:i_note_mobile/modules/details_note/details_note_entities.dart';
import 'package:http/http.dart' as http;

class DetailsNoteBloc extends Bloc<DetailsNoteEvent, DetailsNoteState> {
  final Note note;

  DetailsNoteBloc(this.note) : super(DetailsNoteInitialState(note));

  @override
  Stream<DetailsNoteState> mapEventToState(DetailsNoteEvent event) async* {
    if (event is DetailsNoteUpdateEvent) {
      Note note = await _updateNoteInfo(event.id);
      yield DetailsNoteInitialState(note);
    }
  }
  
  Future<Note> _updateNoteInfo(int id) async {
    final response = await http.get(
      Uri.parse("${ConnectionTools.url}/getNote?id=$id"),
    );
    Note note = Note.fromJson(jsonDecode(response.body));
    return note;
  } 
}
