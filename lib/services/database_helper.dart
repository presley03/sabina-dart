import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('sabina.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 2, onCreate: _createDB, onUpgrade: _onUpgrade);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE user_identity (
      id $idType,
      nama $textType,
      agama $textType,
      tanggal_lahir $textType,
      alamat $textType,
      golongan_darah $textType
    )
    ''');
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('ALTER TABLE user_identity ADD COLUMN agama TEXT');
    }
  }

  Future<int> insertIdentity(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert('user_identity', row);
  }

  Future<List<Map<String, dynamic>>> getIdentity() async {
    final db = await instance.database;
    return await db.query('user_identity');
  }

  Future<int> updateIdentity(Map<String, dynamic> row) async {
    final db = await instance.database;
    int id = row['id'];
    return await db.update('user_identity', row, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteIdentity(int id) async {
    final db = await instance.database;
    return await db.delete('user_identity', where: 'id = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}