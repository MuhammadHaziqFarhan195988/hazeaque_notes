import 'package:flutter/material.dart';
import 'package:hazeaque_note/Notes/notes_blueprint.dart';
import 'package:hazeaque_note/Notes/notes_content.dart';
import 'package:hazeaque_note/Notes/notes_display.dart';

class NotesBuilder extends StatelessWidget {
  const NotesBuilder({super.key, required this.inputNotes, required this.deleteNotes});
 final List<NotesContent> inputNotes;
  final void Function(NotesContent notesData) deleteNotes;

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
              Navigator.push(context, MaterialPageRoute(builder: ((context) => NotesDisplay(inputNotes[index].title, inputNotes[index].content))));
            },
            child: NoteBlueprint(inputNotes[index],deleteNotes: deleteNotes)),
      ),
  
      itemCount: inputNotes.length,
    );
  }
}