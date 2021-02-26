import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {

  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'expenses.db'),
        onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE user_expenses(id TEXT PRIMARY KEY, description TEXT, price REAL,time TEXT,category INT,isExpense TEXT)');
      await db.execute(
          'CREATE TABLE corporation_expenses(id TEXT PRIMARY KEY, description TEXT, price REAL,time TEXT,category INT,isExpense TEXT)');
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

  static Future<int> delete(String table, String id) async {
    final db = await DBHelper.database();
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }

  static Future<List> getCategoriesPrices(String table) async {
    final db = await DBHelper.database();
    final uniqueCategories = await db.rawQuery(
      'SELECT ' + table + ',SUM(price) FROM user_expenses GROUP BY category',
    );
    return uniqueCategories.toList();
  }
}
