import 'package:hive/hive.dart';
part 'note.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String desc;
  @HiveField(3)
  String color;
  @HiveField(4)
  String lastChange;

  Note({this.title = '', this.desc, this.color, this.lastChange});
}

// flutter packages pub run build_runner build --delete-conflicting-outputs
