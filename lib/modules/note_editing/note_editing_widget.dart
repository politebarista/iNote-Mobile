import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_note_mobile/common/ui/customized_button.dart';
import 'package:i_note_mobile/common/ui/customized_text_field.dart';
import 'package:i_note_mobile/common/ui/indent_widget.dart';
import 'package:i_note_mobile/data/entites/note.dart';
import 'package:i_note_mobile/modules/note_editing/note_editing_bloc.dart';
import 'package:i_note_mobile/modules/note_editing/note_editing_entities.dart';

class NoteEditingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Редактирование заметки')),
        body: BlocConsumer<NoteEditingBloc, NoteEditingState>(
          buildWhen: (previous, current) {
            return current is NoteEditingInitialState;
          },
          builder: (context, state) {
            if (state is NoteEditingInitialState) {
              return _buildNoteEditingWidget(context, state.note);
            } else {
              return Center(child: Text('Some went wrong'));
            }
          },
          listenWhen: (previous, current) {
            return current is NoteEditingSavingSuccessState ||
                current is NoteEditingErrorWhileSavingState;
          },
          listener: (context, state) {
            if (state is NoteEditingSavingSuccessState) {
              final snackBar = SnackBar(
                content: Text('Заметка успешно изменена.'),
                backgroundColor: Colors.lightGreen,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              Navigator.pop(context);
            } else if (state is NoteEditingErrorWhileSavingState) {
              final snackBar = SnackBar(
                content: Text('Заметка не была изменена.'),
                backgroundColor: Colors.red,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
        ));
  }

  Widget _buildNoteEditingWidget(BuildContext context, Note note) {
    TextEditingController titleEditingController = TextEditingController();
    TextEditingController descriptionEditingController =
        TextEditingController();

    return IndentWidget(
      child: Column(
        children: [
          CustomizedTextField(
            controller: titleEditingController,
            labelText: 'Заголовок',
            hintText: note.title,
          ),
          SizedBox(height: 8),
          CustomizedTextField(
            controller: descriptionEditingController,
            labelText: 'Описание',
            hintText: note.description,
          ),
          SizedBox(height: 8),
          CustomizedButton(
            text: 'Сохранить изменения',
            onPressed: () {
              final newNote = Note(
                note.id,
                  titleEditingController.text,
                descriptionEditingController.text,
              );
              context.read<NoteEditingBloc>().add(
                    NoteEditingSaveNoteEvent(newNote),
                  );
            },
          )
        ],
      ),
    );
  }
}
