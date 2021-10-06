import 'dart:convert';

import 'package:i_note_mobile/data/entites/note.dart';
import 'package:http/http.dart' as http;
import 'package:i_note_mobile/meta/connection_tools.dart';

abstract class BaseProjectApi {
  Future<List<Note>> getNotes();

  Future<Note> getNote(int id);

  Future<void> createNote(Note note);

  Future<void> updateNote(Note note);

  Future<void> deleteNote(int id);
}

class ProjectApi extends BaseProjectApi {
  Future<List<Note>> getNotes() async {
    final response = await http
        .get(Uri.parse('${ConnectionTools.url}/getNotes'))
        .timeout(Duration(seconds: 15));
    List jsonedResponse = json.decode(response.body);
    List<Note> notes =
        jsonedResponse.map((note) => Note.fromJson(note)).toList();

    return notes;
  }

  Future<Note> getNote(int id) async {
    final response = await http.get(
      Uri.parse("${ConnectionTools.url}/getNote?id=$id"),
    );
    Note note = Note.fromJson(jsonDecode(response.body));

    return note;
  }

  Future<void> createNote(Note note) async {
    await http
        .post(
          Uri.parse("${ConnectionTools.url}/addNote"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String?>{
            'title': note.title,
            'description': note.description,
          }),
        )
        .timeout(
          Duration(seconds: 5),
        );
  }

  Future<void> updateNote(Note note) async {
    await http
        .post(
          Uri.parse("${ConnectionTools.url}/editNote"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'id': note.id,
            'title': note.title,
            'description': note.description,
          }),
        )
        .timeout(Duration(seconds: 10));
  }

  Future<void> deleteNote(int id) async {
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
