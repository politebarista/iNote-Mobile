import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_note_mobile/common/ui/customized_button.dart';
import 'package:i_note_mobile/common/ui/customized_text_field.dart';
import 'package:i_note_mobile/common/ui/indent_widget.dart';
import 'package:i_note_mobile/data/entites/note.dart';
import 'package:i_note_mobile/modules/note_creation/note_creation_entities.dart';

import 'note_creation_bloc.dart';

class NoteCreationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Создание заметки'),
      ),
      body: BlocConsumer<NoteCreationBloc, NoteCreationState>(
        buildWhen: (previous, current) {
          return current is NoteCreationInitialState;
        },
        builder: (context, state) {
          if (state is NoteCreationInitialState) {
            return _buildNoteCreationWiget(context);
          } else {
            return Center(
              child: Text('Some went wrong'),
            );
          }
        },
        listenWhen: (previous, current) {
          return current is NoteCreationNoteCreateFailureState ||
              current is NoteCreationNoteCreateSuccessState;
        },
        listener: (context, state) {
          if (state is NoteCreationNoteCreateFailureState) {
            final snackBar = SnackBar(
              content: Text('Заметка не была создана.'),
              backgroundColor: Colors.red,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else if (state is NoteCreationNoteCreateSuccessState) {
            final snackBar = SnackBar(
              content: Text('Заметка была создана.'),
              backgroundColor: Colors.lightGreen,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Navigator.pop(context);
          }
        },
      ),
    );
  }

  Widget _buildNoteCreationWiget(BuildContext context) {
    TextEditingController titleEditingController = TextEditingController();
    TextEditingController descriptionEditingController =
        TextEditingController();

    return IndentWidget(
      child: Column(
        children: [
          CustomizedTextField(
            controller: titleEditingController,
            hintText: 'Заголовок',
          ),
          SizedBox(height: 16),
          CustomizedTextField(
            controller: descriptionEditingController,
            hintText: 'Описание',
          ),
          SizedBox(height: 16),
          CustomizedButton(
            text: 'Сохранить',
            onPressed: () {
              Note note = Note(
                null,
                titleEditingController.text,
                descriptionEditingController.text,
              );
              context.read<NoteCreationBloc>().add(
                    NoteCreationCreateNoteEvent(note),
                  );
            },
          ),
        ],
      ),
    );
  }
}
