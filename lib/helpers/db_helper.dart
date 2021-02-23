import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'expenses.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_expenses(id TEXT PRIMARY KEY, description TEXT, price REAL,time TEXT,category INT,isExpense TEXT)');
    }, version: 1);
  }

  static Future<Database> database2() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'expenses2.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_expenses(id TEXT PRIMARY KEY, description TEXT, price REAL,time TEXT,category INT,isExpense TEXT)');
    }, version: 2);
  }
  //----------------------------------------------------------------------------

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    await db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> insert2(String table, Map<String, Object> data) async {
    final db = await DBHelper.database2();
    await db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //----------------------------------------------------------------------------

  static Future<int> delete(String id) async {
    final db = await DBHelper.database();
    return await db.delete('user_expenses', where: 'id = ?', whereArgs: [id]);
  }

  static Future<int> delete2(String id) async {
    final db = await DBHelper.database();
    return await db.delete('user_expenses', where: 'id = ?', whereArgs: [id]);
  }
  //----------------------------------------------------------------------------

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }

  static Future<List<Map<String, dynamic>>> getData2(String table) async {
    final db = await DBHelper.database2();
    return db.query(table);
  }
  static Future<List> getCategoriesPrices() async {
    final db = await DBHelper.database();
    final uniqueCategories = await db.rawQuery(
      'SELECT category,SUM(price) FROM user_expenses GROUP BY category',
    );
    return uniqueCategories.toList();
  }
}
