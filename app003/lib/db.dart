import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  //Construtor com acesso privado
  DB._();
  //Criar uma instância de DB
  static final DB instance = DB._();
  //Instância de SQLite
  static Database? _database;

  get database async {
    if (_database != null) {
      return _database;
    }
    return await _initDatabase();
  }

  _initDatabase() async {
    return await openDatabase(join(await getDatabasesPath(), 'banco.db'),
        version: 1, onCreate: _onCreate);
  }

  _onCreate(db, versao) async {
    await db.execute(_favorite);
    await db.insert('favorite', {'name': 'Pêra'});
    await db.insert('favorite', {'name': 'Uva'});
    await db.insert('favorite', {'name': 'Maçã'});
    await db.insert('favorite', {'name': 'Salada Mista'});
  }

  String get _favorite => '''
    CREATE TABLE favorite(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name VARCHAR NOT NULL
    );
  ''';
}
