import 'package:hazeaque_note/Notes/notes_content.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NotesDatabase{
List<NotesContent> notes =  [

  ];

final _kotak = Hive.box('kotak');

void createInitialData(){
  //first time execute only

}

void loadData(){
  notes = _kotak.get("NOTESLIST");
}

void updateDatabase(){
_kotak.put("NOTESLIST", notes);
}
}