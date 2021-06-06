import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_note_mobile/models/note.dart';
import 'package:i_note_mobile/modules/note_list/note_list_entities.dart';
import 'package:http/http.dart' as http;

class NoteListBloc extends Bloc<NoteListEvent, NoteListState> {
  NoteListBloc() : super(NoteListLoadingNotesState());

  @override
  Stream<NoteListState> mapEventToState(NoteListEvent event) async* {
    if (event is NoteListGetNotesEvent) {
      yield NoteListDefaultState();
    } else {
      throw UnimplementedError();
    }
  }

  Future<List<Note>> _takeNotes() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:5000/getNotes'));
    final jsonedResponse = json.decode(response.body);
    List<Note> notes = Note.fromJson(jsonedResponse);
  }
}