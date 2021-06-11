import 'package:equatable/equatable.dart';
import 'package:i_note_mobile/data/entites/note.dart';

abstract class NoteListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class NoteListGetNotesEvent extends NoteListEvent {}

class NoteListDeleteNoteEvent extends NoteListEvent{
  final int id;

  NoteListDeleteNoteEvent(this.id);
}

class NoteListUpdateEvent extends NoteListEvent {}

abstract class NoteListState extends Equatable {
  @override
  List<Object> get props => [];
}

class NoteListLoadingNotesState extends NoteListState {}

class NoteListDefaultState extends NoteListState {
  final List<Note> notes;

  NoteListDefaultState(this.notes);

  @override
  List<Object> get props => [notes];
}

class NotesListEmptyState extends NoteListState {}

class NotesListErrorState extends NoteListState {}
