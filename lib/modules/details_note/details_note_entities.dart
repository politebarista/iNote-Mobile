import 'package:equatable/equatable.dart';
import 'package:i_note_mobile/data/entites/note.dart';

abstract class DetailsNoteEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DetailsNoteUpdateEvent extends DetailsNoteEvent {
  final int id;

  DetailsNoteUpdateEvent(this.id);
}

abstract class DetailsNoteState extends Equatable {
  @override
  List<Object> get props => [];
}

class DetailsNoteInitialState extends DetailsNoteState {
  final Note note;

  DetailsNoteInitialState(this.note);

  @override
  List<Object> get props => [];
}

class DetailsNoteUpdateSuccessState extends DetailsNoteState {
  final Note note;

  DetailsNoteUpdateSuccessState(this.note);
}

class DetailsNoteUpdateFailureState extends DetailsNoteState {}
