import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_note_mobile/data/api/project_api.dart';
import 'package:i_note_mobile/data/entites/note.dart';
import 'package:i_note_mobile/modules/details_note/details_note_entities.dart';

class DetailsNoteBloc extends Bloc<DetailsNoteEvent, DetailsNoteState> {
  final Note _note;
  final BaseProjectApi _projectApi;

  DetailsNoteBloc(
    this._note,
    this._projectApi,
  ) : super(DetailsNoteInitialState(_note));

  @override
  Stream<DetailsNoteState> mapEventToState(DetailsNoteEvent event) async* {
    if (event is DetailsNoteUpdateEvent) {
      Note note = await _projectApi.getNote(event.id);
      yield DetailsNoteInitialState(note);
    }
  }
}
