import 'package:hive/hive.dart';

import 'note_model.dart';

class NoteDatabase {
final _myBox = Hive.box<Note>('notes');

void addNote(Note note){
  _myBox.add(note);
}

List<Note>getNotes(){
 return _myBox.values.toList();
}

void deleteNote (int index){
  _myBox.deleteAt(index);
}

void updateNote (int index, Note note){
  _myBox.putAt(index, note);
}


}