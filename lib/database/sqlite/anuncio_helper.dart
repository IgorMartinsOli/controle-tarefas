import 'package:app_ad/database/sqlite/database_helper.dart';
import 'package:app_ad/models/ad.dart';
import 'package:sqflite/sqflite.dart';

class AnuncioHelper {
  static final String tableName = 'anuncios';
  static final String idColumn = 'id';
  static final String tituloColumn = 'titulo';
  static final String descricaoColumn = 'descricao';
  static final String precoColumn = 'preco';
  static final String imagePathColumn = 'image';

  static String get createScript {
    return "CREATE TABLE ${tableName}( " +
        "$idColumn INTEGER PRIMARY KEY AUTOINCREMENT, " +
        "$tituloColumn TEXT NOT NULL, " +
        "$descricaoColumn TEXT NOT NULL, " +
        "$precoColumn REAL NOT NULL, " +
        "$imagePathColumn TEXT NULL);";
  }

  Future<Ad?> save(Ad anuncio) async {
    Database? db = await DatabaseHelper().db;
    if (db != null) {
      anuncio.id = await db.insert(tableName, anuncio.toMap());
      return anuncio;
    }
    return null;
  }

  Future<List<Ad>> getAll() async {
    Database? db = await DatabaseHelper().db;
    List<Ad> anuncios = List.empty(growable: true);

    if (db != null) {
      List<Map> mapAnuncios = await db.query(tableName);

      for (Map anuncio in mapAnuncios) {
        anuncios.add(Ad.fromMap(anuncio));
      }
    }

    return anuncios;
  }

  Future<int?> edit(Ad anuncio) async {
    Database? db = await DatabaseHelper().db;
    if (db != null) {
      return await db.update(tableName, anuncio.toMap(),
          where: "$idColumn = ?", whereArgs: [anuncio.id]);
    }
  }

  Future<int?> delete(Ad anuncio) async {
    Database? db = await DatabaseHelper().db;
    if (db != null) {
      return await db
          .delete(tableName, where: "$idColumn = ?", whereArgs: [anuncio.id]);
    }
  }
}
