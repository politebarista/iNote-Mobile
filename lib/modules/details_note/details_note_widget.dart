import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_note_mobile/common/ui/indent_widget.dart';
import 'package:i_note_mobile/meta/resolver.dart';
import 'package:i_note_mobile/modules/details_note/details_note_entities.dart';
import 'package:provider/provider.dart';

import 'details_note_bloc.dart';

class DetailsNoteWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final resolver = Provider.of<BaseResolver>(context);

    return BlocBuilder<DetailsNoteBloc, DetailsNoteState>(
        builder: (context, state) {
      if (state is DetailsNoteInitialState) {
        return Scaffold(
          appBar: AppBar(title: Text(state.note.title)),
          body: IndentWidget(
            child: Padding(
              padding: EdgeInsets.only(top: 8),
              child: Column(
                children: [
                  Text(
                    state.note.description ?? '',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.edit),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return resolver.getNoteEditingWidget(state.note);
                  },
                ),
              );
              context
                  .read<DetailsNoteBloc>()
                  .add(DetailsNoteUpdateEvent(state.note.id!));
            },
          ),
        );
      } else {
        return Scaffold(
          appBar: AppBar(
            title: Text('Error 0_o'),
          ),
          body: Center(child: Text('Oppps, some went wrong')),
        );
      }
    });
  }
}
