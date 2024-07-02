import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:my_super_cat_app/infraestructure/models/cat_breed.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'cats.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE favorites(
        id TEXT PRIMARY KEY,
        name TEXT,
        temperament TEXT,
        intelligence INTEGER,
        reference_image_id TEXT
      )
    ''');
  }

  Future<void> insertCat(CatBreed cat) async {
    final db = await database;
    await db.insert('favorites', cat.toJsonForDb(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<CatBreed>> getCats() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('favorites');

    return List.generate(maps.length, (i) {
      return CatBreed.fromJsonForDb(maps[i]);
    });
  }

  Future<void> deleteCat(String id) async {
    final db = await database;
    await db.delete('favorites', where: 'id = ?', whereArgs: [id]);
  }
}
