import 'package:equatable/equatable.dart';
import 'package:i_note_mobile/data/entites/note.dart';

abstract class NoteCreationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class NoteCreationCreateNoteEvent extends NoteCreationEvent {
  final Note note;

  NoteCreationCreateNoteEvent(this.note);

  @override
  List<Object> get props => [];
}

abstract class NoteCreationState extends Equatable {
  @override
  List<Object> get props => [];
}

class NoteCreationInitialState extends NoteCreationState {}

class NoteCreationNoteCreateSuccessState extends NoteCreationState {}

class NoteCreationNoteCreateFailureState extends NoteCreationState {}
