import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/Plant.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('plants.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const intType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE plants (
  id $idType,
  name $textType,
  species $textType,
  imagePath $textType,
  frequencyDays $intType,
  lastWateredDate $textType
)
''');
  }

  Future<Plant> create(Plant plant) async {
    final db = await instance.database;
    final id = await db.insert('plants', plant.toMap());
    return Plant(
      id: id,
      name: plant.name,
      species: plant.species,
      imagePath: plant.imagePath,
      frequencyDays: plant.frequencyDays,
      lastWateredDate: plant.lastWateredDate,
    );
  }

  Future<Plant> readPlant(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      'plants',
      columns: ['id', 'name', 'species', 'imagePath', 'frequencyDays', 'lastWateredDate'],
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Plant.fromMap(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Plant>> readAllPlants() async {
    final db = await instance.database;
    final orderBy = 'lastWateredDate ASC';
    final result = await db.query('plants', orderBy: orderBy);

    return result.map((json) => Plant.fromMap(json)).toList();
  }

  Future<int> update(Plant plant) async {
    final db = await instance.database;

    return db.update(
      'plants',
      plant.toMap(),
      where: 'id = ?',
      whereArgs: [plant.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      'plants',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
