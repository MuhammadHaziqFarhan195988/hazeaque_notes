import 'package:flutter/material.dart';
import 'package:hazeaque_note/Notes/notes_content.dart';
import 'package:hazeaque_note/Storage/sample.dart';

class NoteBlueprint extends StatelessWidget {
  const NoteBlueprint(this.notesData,{super.key, required this.deleteNotes});
  final NotesContent notesData;
  final void Function(NotesContent notesData) deleteNotes;

  @override
  Widget build(BuildContext context) {
    return  Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
Text(notesData.title,
style: Theme.of(context).textTheme.titleLarge,),

Column(
  children: [
    Text(formatter.format(notesData.dateCreated)),
    Text(timeFormat.format(notesData.dateCreated)),
  ],
),
        ]),
      ),
      
      );
  }
}