import 'package:hazeaque_note/Notes/notes_content.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NotesDatabase{
static final NotesDatabase _instance = NotesDatabase._internal();
  factory NotesDatabase() => _instance;
  static Database? _database;

  NotesDatabase._internal(); //creates a new instance of database

   Future<Database> get database async { //to execute the initialization of database
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;//if database exists then return database otherwise create one
  }

  Future<Database> _initDatabase() async {//we initalize the table, hopefully once then
    String path = join(await getDatabasesPath(), 'example.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(// once that's done it will create a table
          'CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT, content TEXT, date_created TEXT)',
        );
      },
    );
  }

List<Map<String, dynamic>> notes =  [

  ];
  
Future<void> insertDataToLaunchPod(NotesContent data) async {
    final db = await database;
    await db.insert(
      'notes',
      data.packageForLaunch(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

}


  Future<List<Map<String, dynamic>>> getNotes() async {
  final db = await database;
  return await db.query('notes');
}

  Future<void> updateNotes(String id, NotesContent updatedData) async {
    final db = await database;
    await db.update(
      'notes',
      updatedData.packageForLaunch(),
      where: 'id = ?',
      whereArgs: [id], //Anti SQL injection measures
    );
  }

    Future<void> deleteNote(String id) async {
    final db = await database;
    await db.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }


}