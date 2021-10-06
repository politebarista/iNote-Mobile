import 'package:flutter/material.dart';
import 'package:i_note_mobile/data/api/project_api.dart';
import 'package:i_note_mobile/meta/resolver.dart';
import 'package:provider/provider.dart';

class INoteMobile extends StatelessWidget {
  const INoteMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BaseResolver resolver = Resolver();

    return MultiProvider(
      providers: [
        Provider<BaseResolver>(
          create: (_) => resolver,
        ),
        Provider<BaseProjectApi>(
          create: (_) => ProjectApi(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        home: resolver.getNoteListWidget(),
      ),
    );
  }
}
