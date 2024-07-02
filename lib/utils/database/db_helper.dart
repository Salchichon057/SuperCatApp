import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  final int version = 1;
  Database? db;

  static final DbHelper _dbHelper = DbHelper._internal();

  DbHelper._internal(); // Para que no se pueda instanciar

  factory DbHelper() {
    // Singleton
    return _dbHelper;
  }

  Future<Database> openDb() async {
    db ??= await openDatabase(join(await getDatabasesPath(), 'movies.db'),
        onCreate: (db, version) {
      // Query  para crear la tabla
      // db.execute('CREATE TABLE movies(id INTEGER PRIMARY KEY, title TEXT)');
    }, version: version);
    return db!;
  }
  // Crear los métodos para insertar, actualizar, eliminar y consultar usando el conflicto de reemplazo en caso de que ya exista un registro con el mismo id.

  // Future<int> insert(Modelo model) async {
  //   int id = await db!.insert(model.tableName, model.toMap(),
  //       conflictAlgorithm: ConflictAlgorithm.replace); // Si ya existe, lo reemplaza
  //   return id;
  // }

}
