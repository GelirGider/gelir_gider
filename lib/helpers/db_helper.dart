import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {

// Veritabanı işlemlerinin yapıldığı kısım

// Veritbanının ve tablolarının oluşturulması
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'expenses.db'),
        onCreate: (db, version) async {
      // Bireysel ve Kurumsal için iki ayrı tablo oluşturduk
      await db.execute(
          'CREATE TABLE user_expenses(id TEXT PRIMARY KEY, description TEXT, price REAL,time TEXT,category INT,isExpense TEXT)');
      await db.execute(
          'CREATE TABLE corporation_expenses(id TEXT PRIMARY KEY, description TEXT, price REAL,time TEXT,category INT,isExpense TEXT)');
    }, version: 1);
  }
// Harcamaların eklenmesi
  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    await db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
// Harcamaların silinmesi
  static Future<int> delete(String table, String id) async {
    final db = await DBHelper.database();
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }
// Harcamaların alınması
  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }
}
