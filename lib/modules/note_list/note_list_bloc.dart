import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_note_mobile/data/entites/note.dart';
import 'package:i_note_mobile/meta/connection_tools.dart';
import 'package:i_note_mobile/modules/note_list/note_list_entities.dart';
import 'package:http/http.dart' as http;

class NoteListBloc extends Bloc<NoteListEvent, NoteListState> {
  NoteListBloc() : super(NoteListLoadingNotesState());

  @override
  Stream<NoteListState> mapEventToState(NoteListEvent event) async* {
    if (event is NoteListGetNotesEvent) {
      try {
        List<Note> notes = await _takeNotes();
        if (notes.isEmpty) {
          yield NotesListEmptyState();
        } else {
          yield NoteListDefaultState(notes);
        }
      } catch (e) {
        print(e);
        yield NotesListErrorState();
      }
    } else if (event is NoteListDeleteNoteEvent) {
      await _deleteNote(event.id);
    } else if (event is NoteListUpdateEvent) {
      yield NoteListLoadingNotesState();
      add(NoteListGetNotesEvent());
    } else {
      throw UnimplementedError();
    }
  }

  Future<List<Note>> _takeNotes() async {
    final response =
        await http.get(Uri.parse('${ConnectionTools.url}/getNotes')).timeout(
              Duration(seconds: 15));
    List jsonedResponse = json.decode(response.body);
    List<Note> notes =
        jsonedResponse.map((note) => Note.fromJson(note)).toList();
    return notes;
  }

  Future<void> _deleteNote(int id) async {
    await http.post(
      Uri.parse('${ConnectionTools.url}/deleteNote'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, int>{
        'id': id,
      }),
    );
  }
}
