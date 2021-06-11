import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_note_mobile/data/entites/note.dart';
import 'package:i_note_mobile/modules/note_creation/note_creation_entities.dart';

class NoteCreationBloc extends Bloc<NoteCreationEvent, NoteCreationState> {
  final Note note;

  NoteCreationBloc(this.note) : super(NoteCreationInitialState(note));

  Stream<NoteCreationState> mapEventToState(NoteCreationEvent event) async* {}
}
