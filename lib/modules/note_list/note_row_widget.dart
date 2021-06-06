import 'package:flutter/material.dart';
import 'package:i_note_mobile/models/note.dart';

class NoteRowWidget extends StatelessWidget {
  final Note note;

  NoteRowWidget(this.note);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Row(
        children: [
          Text(note.id.toString()),
          Text(note.title),
        ],
      ),
    );
  }
}
