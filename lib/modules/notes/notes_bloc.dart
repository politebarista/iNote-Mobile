import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'notes_entites.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc(NotesState initialState) : super(initialState);

  @override
  Stream<NotesState> mapEventToState(
      NotesEvent event,
      ) async* {
    if (event is FetchNotesEvent) {

    }
  }
}