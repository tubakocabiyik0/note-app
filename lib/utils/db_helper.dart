import 'package:flutter/services.dart';
import 'package:notes_app/Model/category.dart';
import 'package:notes_app/Model/notes.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  Database _database;

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper.internal();
      return _databaseHelper;
    } else {
      return _databaseHelper;
    }
  }

  DatabaseHelper.internal();

  Future<Database> _getDatabase() async {
    if (_database == null) {
      _database = await initDb();
      return _database;
    } else {
      return _database;
    }
  }

  Future<Database> initDb() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "appDb.db");

// Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", "notes2.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }
// open the database
    return await openDatabase(path, readOnly: false);
  }

  Future<List<Map<String, dynamic>>> getAllCategory() async {
    Database db = await _getDatabase();
    var result = await db.query("category");
    return result;
  }

  Future<int> addCategory(Category category) async {
    Database db = await _getDatabase();
    var result = await db.insert("category", category.toMap());
    return result;
  }

  Future<int> deleteCategory(int id) async {
    Database db = await _getDatabase();
    var result =
        await db.delete("category", where: 'categoryId=?', whereArgs: [id]);
    return result;
  }

  Future<int> updateCategory(Category category) async {
    Database db = await _getDatabase();
    var result = await db.update("category", category.toMap(),
        where: 'categoryId=?', whereArgs: [category.categoryId]);
    return result;
  }

  Future<List<Map<String, dynamic>>> getAllNotes() async {
    Database db = await _getDatabase();
    var result = await db.rawQuery("select * from notes inner join category on category.categoryId = notes.categoryId; ");
    return result;
  }

  Future<int> addNote(Notes notes) async {
    Database db = await _getDatabase();
    var result = await db.insert("notes", notes.toMap());
    return result;
  }

  Future<int> deleteNote(int id) async {
    Database db = await _getDatabase();
    var result = await db.delete("notes", where: 'notesId=?', whereArgs: [id]);
    return result;
  }

  Future<int> updateNote(Notes notes) async {
    Database db = await _getDatabase();
    var result = await db
        .update("notes", notes.toMap(), where: 'notesId=?', whereArgs: [notes.notesId]);
    return result;
  }

  Future<List<Notes>> getNotesList() async{
   var list= new List<Notes>();
   var notes= await getAllNotes();
   for( Map map in notes){
     list.add(Notes.fromMap(map));
   }
    return list;
  }

}
