import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i_note_mobile/common/ui/indent_widget.dart';
import 'package:i_note_mobile/data/entites/note.dart';
import 'package:i_note_mobile/meta/resolver.dart';
import 'package:provider/provider.dart';

import 'note_list_bloc.dart';
import 'note_list_delegate.dart';
import 'note_list_entities.dart';

class NoteRowWidget extends StatelessWidget {
  final Note note;
  final NoteListDelegate _noteListDelegate;

  NoteRowWidget(this.note, this._noteListDelegate);

  final Widget dismissIcon = Padding(
    padding: EdgeInsets.symmetric(horizontal: 8),
    child: Icon(
      Icons.delete,
      color: Colors.white,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final resolver = Provider.of<Resolver>(context);

    return Dismissible(
      key: Key(note.id.toString()),
      background: Container(
        color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            dismissIcon,
            dismissIcon,
          ],
        ),
      ),
      child: InkWell(
        child: IndentWidget(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Container(
                height: 60,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: constraints.maxWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            note.title,
                            style: TextStyle(fontSize: 18),
                            softWrap: false,
                            overflow: TextOverflow.fade,
                          ),
                          if (note.description != null &&
                              note.description!.isNotEmpty) ...[
                            Text(
                              note.description!,
                              style: TextStyle(fontSize: 16),
                              softWrap: false,
                              overflow: TextOverflow.fade,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return resolver.getDetailsNote(note);
              },
            ),
          );
          context.read<NoteListBloc>().add(NoteListUpdateEvent());
        },
      ),
      onDismissed: (direction) async {
        _noteListDelegate.deleteNote(context, note.id!);
      },
    );
  }
}
