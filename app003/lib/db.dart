import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

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

  _initDatabase() async{
    return await openDatabase(
      join(await getDatabasesPath() )
    )
  }
}
