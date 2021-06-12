import 'package:equatable/equatable.dart';
import 'package:i_note_mobile/data/entites/note.dart';

abstract class DetailsNoteEvent extends Equatable {
  @override
  List<Object> get props => [];
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
