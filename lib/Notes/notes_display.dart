import 'package:flutter/material.dart';
import 'package:hazeaque_note/Notes/notes_content.dart';
import 'package:hazeaque_note/Notes/notes_update.dart';

// ignore: must_be_immutable
class NotesDisplay extends StatelessWidget {
  NotesDisplay(this.title,this.content,this.notes,{super.key, required this.saveNotes});
  final String title;
  final String content;
  final void Function( String id, NotesContent updatedData) saveNotes;
  NotesContent notes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.teal,), onPressed: () => Navigator.pop(context),),
        actions: [IconButton(onPressed: () {Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => NotesUpdate(existingContent: content ,existingTitle: title,updateNotes: saveNotes, notes: notes,)));}, icon: const Icon(Icons.edit))],
        flexibleSpace: Container(
          height: 110,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.0, 1.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
              colors: [Colors.black, Colors.teal])
          ),
        ),
        title: Text(title, style: const TextStyle(color: Colors.teal),),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding:const EdgeInsets.all(20.0),
        color: Colors.blue,
        child: Text(content, style: const TextStyle(fontSize: 23),),
      ),
    );
  }
}