import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_note_mobile/models/note.dart';
import 'package:i_note_mobile/modules/note_list/note_list_bloc.dart';
import 'package:i_note_mobile/modules/note_list/note_list_entities.dart';
import 'package:i_note_mobile/modules/note_list/note_row_widget.dart';

class NoteListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('iNote'),
      ),
      body: BlocBuilder<NoteListBloc, NoteListState>(
        builder: (context, state) {
          if (state is NoteListLoadingNotesState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is NoteListDefaultState) {
            return _buildNotesList(state);
          } else if (state is NotesListEmptyState) {
            return Center(child: Text('To bad, the list of notes is empty.'));
          } else if (state is NotesListErrorState) {
            return Center(child: Text('Oppps. Some went wrong.'));
          } else {
            return Center(child: Text('Some mistakes. So sorry.'));
          }
        },
      ),
    );
  }

  Widget _buildNotesList(NoteListDefaultState state) {
    return Container(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return NoteRowWidget(state.notes[index]);
        },
        itemCount: state.notes.length,
      ),
    );
  }
}
