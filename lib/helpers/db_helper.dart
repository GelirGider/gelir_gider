import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'expenses.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_expenses(id TEXT PRIMARY KEY, description TEXT, price INTEGER,time TEXT,category TEXT,isExpense TEXT)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    await db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> delete(int id) async {
    final db = await DBHelper.database();
    var result = await db.rawDelete('DELETE FROM user_expenses WHERE id = $id');
    return result;
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }
}
