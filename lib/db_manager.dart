import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBManager {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialize();
      return _db;
    } else {
      return _db;
    }
  }

  Future<Database> initialize() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, "note_app.db");
    Database myDB = await openDatabase(path, onCreate: _create, version: 1);
    return myDB;
  }

  Future<void> _create(Database db, int version) async {
    try {
      await db.execute(
        'CREATE TABLE Notes (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, description TEXT NOT NULL)',
      );
      print("Database Created ===========================>");
    } catch (e) {
      print("error table: $e");
    }
  }
}
