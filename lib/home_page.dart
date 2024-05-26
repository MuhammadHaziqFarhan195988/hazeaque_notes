import 'package:flutter/material.dart';
import 'package:hazeaque_note/Notes/add_notes.dart';
import 'package:hazeaque_note/Notes/notes_content.dart';
import 'package:hazeaque_note/Storage/database.dart';
import 'package:hazeaque_note/Notes/notes_builder.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
List<Map<String, dynamic>> notesFromDatabase = [];
List<NotesContent> notesPurified = [];

  @override
  void initState() {
    setState(() {
  getFromDatabase();
});
    super.initState();
  }
NotesDatabase db = NotesDatabase();

Future<List<Map<String, dynamic>>> getFromDatabase() async {

notesFromDatabase = await db.getNotes();

notesPurified = notesFromDatabase.map((note) {
          return NotesContent(
            id: note['id'].toString(),
            title: note['title'],
            content: note['content'],
            dateCreated: DateTime.parse(note['date_created'])
          );
        } ).toList();

return notesFromDatabase;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[300],
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: ((context) => AddNotes(inputCatatan: _savedNotes,)))).then((value) => setState((){ getFromDatabase(); }) );
          }, icon: const Icon(Icons.add, color: Colors.black,))
        ],
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
        title: const Text("Home Page", style: TextStyle(color: Colors.teal),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: FutureBuilder<List<Map<String, dynamic>>>(
              future: getFromDatabase(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Looks like your home page is empty, click on the add button to add notes'));
                } else {
                  return NotesBuilder(inputNotes: notesPurified, deleteNotes: _deleteNotes, saveNotes: _updateNote,);
                }
              },
            ),
      ),

    );
  }

  void _savedNotes(String title, String content){
  setState(() {
    db.insertDataToLaunchPod(NotesContent(title: title, content: content, dateCreated: DateTime.now()));

});
}

  void _updateNote( String id, NotesContent updatedData){
  setState(() {
    db.updateNotes(id,updatedData);

});
}

void _deleteNotes(NotesContent notesData){
  // final notesIndex = db.notes.indexOf(notesData);
  setState(() {
    db.deleteNote(notesData.id!);
    notesPurified.remove(notesData);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
        duration:const Duration(seconds: 3),
        content:  const Text("Notes Deleted"),
        action: SnackBarAction(label: "Undo", onPressed: (){
          setState(() {
            _savedNotes(notesData.title, notesData.content!);
          });
        }),
        )
      );
  });
}
}