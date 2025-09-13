import 'package:hive/hive.dart';

part 'note_model.g.dart';
@HiveType(typeId: 0)
class Note extends HiveObject{
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String content;
  @HiveField(3)
  final String date;

  Note({
    this.id,
    required this.title,
    required this.content,
    required this.date,
  });

}