import 'package:flutter/material.dart';
import 'package:i_note_mobile/models/note.dart';

import 'note_list_delegate.dart';

class NoteRowWidget extends StatelessWidget {
  final Note note;
  final NoteListDelegate _noteListDelegate;

  NoteRowWidget(this.note, this._noteListDelegate);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Dismissible(
        key: Key(note.id.toString()),
        child: Row(
          children: [
            Text(note.id.toString()),
            Text(note.title),
          ],
        ),
        onDismissed: (direction) async {
          _noteListDelegate.deleteNote(context, note.id);
        },
      ),
    );
  }
}
