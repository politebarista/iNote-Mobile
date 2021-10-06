import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_note_mobile/data/api/project_api.dart';
import 'package:i_note_mobile/data/entites/note.dart';
import 'package:i_note_mobile/modules/note_list/note_list_entities.dart';

class NoteListBloc extends Bloc<NoteListEvent, NoteListState> {
  final BaseProjectApi _projectApi;

  NoteListBloc(this._projectApi) : super(NoteListLoadingNotesState());

  @override
  Stream<NoteListState> mapEventToState(NoteListEvent event) async* {
    if (event is NoteListGetNotesEvent) {
      try {
        List<Note> notes = await _projectApi.getNotes();
        if (notes.isEmpty) {
          yield NotesListEmptyState();
        } else {
          yield NoteListDefaultState(notes);
        }
      } catch (e) {
        print(e);
        yield NotesListErrorState();
      }
    } else if (event is NoteListDeleteNoteEvent) {
      await _projectApi.deleteNote(event.id);
    } else if (event is NoteListUpdateEvent) {
      yield NoteListLoadingNotesState();
      add(NoteListGetNotesEvent());
    } else {
      throw UnimplementedError();
    }
  }
}
