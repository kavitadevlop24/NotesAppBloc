import 'db_helper.dart';

class NotesModel {
  int? id;
  String title;
  String desc;

  NotesModel({this.id, required this.title, required this.desc});

  factory NotesModel.fromMap(Map<String, dynamic> map) {
    return NotesModel(
        id: map[DbHelper.note_id],
        title: map[DbHelper.note_title],
        desc: map[DbHelper.note_desc]);
  }

  Map<String, dynamic> toMap() {
    return {
      DbHelper.note_id: id,
      DbHelper.note_desc: desc,
      DbHelper.note_title: title,
    };
  }
}