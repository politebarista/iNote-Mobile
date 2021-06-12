import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_note_mobile/data/entites/note.dart';
import 'package:i_note_mobile/modules/details_note/details_note_entities.dart';

class DetailsNoteBloc extends Bloc<DetailsNoteEvent, DetailsNoteState> {
  final Note note;

  DetailsNoteBloc(this.note) : super(DetailsNoteInitialState(note));

  @override
  Stream<DetailsNoteState> mapEventToState(DetailsNoteEvent event) async* {}
}
