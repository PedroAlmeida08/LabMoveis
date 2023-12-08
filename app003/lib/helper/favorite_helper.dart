import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/favorite.dart';

class FavoriteHelper {
  static final tableName = "favorite";
  static Database? _db;
  static final FavoriteHelper _favoriteHelper = FavoriteHelper._internal();

  factory FavoriteHelper() {
    return _favoriteHelper;
  }

  FavoriteHelper._internal();

  initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "favorite.db");

    Database db = await openDatabase(path, version: 1, onCreate: _onCreateDb);

    return db;
  }

  void _onCreateDb(Database db, int version) {
    String sql = """
    CREATE TABLE $tableName(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name VARCHAR NOT NULL
    );
    """;

    db.execute(sql);
  }

  Future<Database?> get db async {
    /*if (_db == null) {
      _db = initDb();
    }*/

    _db ??= await initDb();

    return _db;
  }

  Future<int> insertTask(Favorite favorite) async {
    var database = await db;
    print("Insert Favorite");

    int result = await database!.insert(tableName, favorite.toMap());

    return result;
  }

  Future<int> updateTask(Favorite favorite) async {
    var database = await db;

    int result = await database!.update(tableName, favorite.toMap(),
        where: "id=?", whereArgs: [favorite.id]);

    return result;
  }

  Future<int> deleteFavorite(int id) async {
    var database = await db;

    int result =
        await database!.delete(tableName, where: "id=?", whereArgs: [id]);

    return result;
  }

  getFavorites() async {
    var database = await db;

    String sql = "SELECT * FROM $tableName;";

    List results = await database!.rawQuery(sql);

    return results;
  }
}
