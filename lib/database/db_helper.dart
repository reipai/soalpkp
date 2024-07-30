import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class dbHelper {
  static Database? _database;

  static Future<void> initDb() async{
    if (_database != null) return;

    _database = await openDatabase(
      join(await getDatabasesPath(), 'app_log.db'),
      onCreate: (db, version){
        return db.execute(
          'CREATE TABLE logs(id INTEGER PRIMARY KEY, date TEXT, response TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<void> insertLog(String response) async {
    await initDb();
    final db = _database;
    if (db == null) return;

    await db.insert(
      'logs',
      {'date': DateTime.now().toIso8601String(), 'response': response},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getLogs() async {
    await initDb();
    final db = _database;
    if (db == null) return [];

    return await db.query('logs');
  }
}