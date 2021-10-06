import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_note_mobile/data/api/project_api.dart';
import 'package:i_note_mobile/data/entites/note.dart';
import 'package:i_note_mobile/modules/note_editing/note_editing_entities.dart';

class NoteEditingBloc extends Bloc<NoteEditingEvent, NoteEditingState> {
  final Note _note;
  final BaseProjectApi _projectApi;

  NoteEditingBloc(
    this._note,
    this._projectApi,
  ) : super(NoteEditingInitialState(_note));

  Stream<NoteEditingState> mapEventToState(NoteEditingEvent event) async* {
    if (event is NoteEditingSaveNoteEvent) {
      try {
        await _projectApi.updateNote(event.note);
        yield NoteEditingSavingSuccessState();
      } catch (e) {
        yield NoteEditingErrorWhileSavingState();
      }
    } else {
      throw UnimplementedError();
    }
  }
}
