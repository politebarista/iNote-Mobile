import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_note_mobile/modules/note_list/note_list_bloc.dart';
import 'package:i_note_mobile/modules/note_list/note_list_entities.dart';
import 'package:i_note_mobile/modules/note_list/note_row_widget.dart';

import 'note_list_delegate.dart';

class NoteListWidget extends StatelessWidget implements NoteListDelegate {
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
            return _buildNotesList(context, state);
          } else if (state is NotesListEmptyState) {
            return _buildRefreshWidget(
              context,
              Text('To bad, the list of notes is empty.'),
            );
          } else if (state is NotesListErrorState) {
            return _buildRefreshWidget(
              context,
              Text('Oppps. Some went wrong.'),
            );
          } else {
            return _buildRefreshWidget(
              context,
              Text('Some mistakes. So sorry.'),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, 'createNote'),
      ),
    );
  }

  Widget _buildNotesList(BuildContext context, NoteListDefaultState state) {
    return _buildRefreshWidget(
      context,
      ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return NoteRowWidget(state.notes[index], this);
        },
        itemCount: state.notes.length,
      ),
    );
  }

  Widget _buildRefreshWidget(BuildContext context, Widget child) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<NoteListBloc>().add(NoteListUpdateEvent());
      },
      child: child,
    );
  }

  void deleteNote(BuildContext context, int id) {
    context.read<NoteListBloc>().add(NoteListDeleteNoteEvent(id));
  }
}
