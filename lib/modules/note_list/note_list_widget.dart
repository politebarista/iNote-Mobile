import 'package:flutter/material.dart';
import 'package:i_note_mobile/models/note.dart';
import 'package:i_note_mobile/modules/note_list/note_row_widget.dart';

class NoteListWidget extends StatelessWidget {
  List<Note> notes = [
    Note(1, 'сделать матешу'),
    Note(2, 'переделать матешу'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return NoteRowWidget(notes[index]);
      },
      itemCount: notes.length,
    ));
  }
}
