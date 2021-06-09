import 'package:flutter/material.dart';
import 'package:i_note_mobile/common/ui/indent_widget.dart';
import 'package:i_note_mobile/models/note.dart';

import 'note_list_delegate.dart';

class NoteRowWidget extends StatelessWidget {
  final Note note;
  final NoteListDelegate _noteListDelegate;

  NoteRowWidget(this.note, this._noteListDelegate);

  final Widget dismissIcon = Padding(
    padding: EdgeInsets.symmetric(horizontal: 8),
    child: Icon(
      Icons.delete,
      color: Colors.white,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(note.id.toString()),
      background: Container(
        color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            dismissIcon,
            dismissIcon,
          ],
        ),
      ),
      child: IndentWidget(
        child: Container(
          height: 50,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(note.id.toString()),
              SizedBox(width: 16),
              Text(note.title),
            ],
          ),
        ),
      ),
      onDismissed: (direction) async {
        _noteListDelegate.deleteNote(context, note.id);
      },
    );
  }
}
