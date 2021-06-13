import 'package:equatable/equatable.dart';
import 'package:i_note_mobile/data/entites/note.dart';

abstract class NoteEditingEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class NoteEditingSaveNoteEvent extends NoteEditingEvent {
  final Note note;

  NoteEditingSaveNoteEvent(this.note);
}

abstract class NoteEditingState extends Equatable {
  @override
  List<Object> get props => [];
}

class NoteEditingInitialState extends NoteEditingState {
  final Note note;

  NoteEditingInitialState(this.note);
}

class NoteEditingErrorWhileSavingState extends NoteEditingState {}

class NoteEditingSavingSuccessState extends NoteEditingState {}