import 'package:flutter/material.dart';

abstract class NoteListDelegate {
  void deleteNote(BuildContext context, int id);
}