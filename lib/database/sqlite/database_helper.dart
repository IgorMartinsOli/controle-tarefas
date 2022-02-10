/*import 'package:app_ad/database/sqlite/anuncio_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  Database? _db;

  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper.internal();

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDB();
      return _db;
    }
  }

  Future<Database?> initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'anuncioDatabase.db');

    return _db = await openDatabase(path,
        version: 2, onCreate: _onCreateDb, onUpgrade: _onUpgradeDb);
  }

  Future _onCreateDb(Database db, int newVersion) async {
    await db.execute(AnuncioHelper.createScript);
  }

  Future _onUpgradeDb(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      await db.execute("DROP TABLE ${AnuncioHelper.tableName};");
      await _onCreateDb(db, newVersion);
    }
  }
}
*/