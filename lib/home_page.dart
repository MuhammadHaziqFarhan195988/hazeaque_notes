import 'package:flutter/material.dart';
import 'package:hazeaque_note/Notes/add_notes.dart';
import 'package:hazeaque_note/Notes/notes_content.dart';
import 'package:hazeaque_note/Storage/database.dart';
import 'package:hazeaque_note/Notes/notes_builder.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
 if(_kotak.get("NOTESLIST")){
db.loadData();
 }
    super.initState();
  }

final _kotak = Hive.box('kotak');
NotesDatabase db = NotesDatabase();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[300],
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: ((context) => AddNotes(inputCatatan: _savedNotes,))));
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
      body: db.notes.isEmpty ? const Center(
        child: Text("Looks like your home page is empty, click on the add button to add notes",
         textAlign: TextAlign.center,),
      ) : Padding(
        padding: const EdgeInsets.all(8),
        child: NotesBuilder(inputNotes: db.notes, deleteNotes: _deleteNotes,)
      ),

    );
  }

  void _savedNotes(String title, String content){
  setState(() {
  db.notes.add(NotesContent(title: title, content: content, dateCreated: DateTime.now()));
  db.updateDatabase();
});
}

void _deleteNotes(NotesContent notesData){
  final notesIndex = db.notes.indexOf(notesData);
  setState(() {
    db.notes.remove(notesData);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
        duration:const Duration(seconds: 3),
        content:  const Text("Notes Deleted"),
        action: SnackBarAction(label: "Undo", onPressed: (){
          setState(() {
            db.notes.insert(notesIndex, notesData);
          });
        }),
        )
      );
  });
}
}