import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i_note_mobile/common/ui/indent_widget.dart';
import 'package:i_note_mobile/data/entites/note.dart';
import 'dart:math' as math;

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
          height: 55,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    note.title,
                    style: TextStyle(fontSize: 18),
                  ),
                  if (note.description != null && note.description!.isNotEmpty)...[
                    Text(
                      note.description!,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
      onDismissed: (direction) async {
        _noteListDelegate.deleteNote(context, note.id!);
      },
    );
  }
}
