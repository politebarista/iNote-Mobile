import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_note_mobile/data/api/project_api.dart';
import 'package:i_note_mobile/modules/note_creation/note_creation_entities.dart';

class NoteCreationBloc extends Bloc<NoteCreationEvent, NoteCreationState> {
  final BaseProjectApi _projectApi;

  NoteCreationBloc(this._projectApi) : super(NoteCreationInitialState());

  Stream<NoteCreationState> mapEventToState(NoteCreationEvent event) async* {
    if (event is NoteCreationCreateNoteEvent) {
      try {
        await _projectApi.createNote(event.note);
        yield NoteCreationNoteCreateSuccessState();
      } catch (_) {
        yield NoteCreationNoteCreateFailureState();
      }
    } else {
      throw UnimplementedError();
    }
  }
}
