import 'package:flutter/material.dart';
import 'package:hazeaque_note/Notes/notes_blueprint.dart';
import 'package:hazeaque_note/Notes/notes_content.dart';
import 'package:hazeaque_note/Notes/notes_display.dart';

class NotesBuilder extends StatelessWidget {
  const NotesBuilder({super.key, required this.inputNotes, required this.deleteNotes, required this.saveNotes});
 final List<NotesContent> inputNotes;
  final void Function(NotesContent notesData) deleteNotes;
  final void Function(String id, NotesContent updatedData) saveNotes;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) =>  Dismissible(
        background:  Container(// convenient, we can customize the error visibility color
        color: Theme.of(context).colorScheme.error.withOpacity(1),//dark shade of red
        margin: Theme.of(context).cardTheme.margin,),
        key: ValueKey(inputNotes[index]),
      onDismissed: (direction){
deleteNotes(inputNotes[index]);
      },
        child: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: ((context) => NotesDisplay(inputNotes[index].title, inputNotes[index].content!,inputNotes[index] , saveNotes: saveNotes,))));
            },
            child: NoteBlueprint(inputNotes[index],deleteNotes: deleteNotes)),
      ),
  
      itemCount: inputNotes.length,
    );
  }
}