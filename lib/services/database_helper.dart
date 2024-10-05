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
    return await openDatabase(path, version: 3, onCreate: _createDB, onUpgrade: _onUpgrade);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const integerType = 'INTEGER NOT NULL';

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

    await db.execute('''
    CREATE TABLE pregnancy_history (
      id $idType,
      tanggal_pemeriksaan $textType,
      berat_badan $integerType,
      tinggi_badan $integerType,
      kehamilan_ke $textType,
      jumlah_anak $textType,
      riwayat_keguguran $textType,
      riwayat_kelahiran $textType,
      anak_ke $textType,
      tahun_lahir $textType,
      berat_badan_lahir $integerType,
      cara_persalinan $textType,
      penolong_persalinan $textType,
      komplikasi $textType
    )
    ''');
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('ALTER TABLE user_identity ADD COLUMN agama TEXT');
    }
    if (oldVersion < 3) {
      await db.execute('''
      CREATE TABLE pregnancy_history (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        tanggal_pemeriksaan TEXT NOT NULL,
        berat_badan INTEGER NOT NULL,
        tinggi_badan INTEGER NOT NULL,
        kehamilan_ke TEXT NOT NULL,
        jumlah_anak TEXT NOT NULL,
        riwayat_keguguran TEXT NOT NULL,
        riwayat_kelahiran TEXT NOT NULL,
        anak_ke TEXT NOT NULL,
        tahun_lahir TEXT NOT NULL,
        berat_badan_lahir INTEGER NOT NULL,
        cara_persalinan TEXT NOT NULL,
        penolong_persalinan TEXT NOT NULL,
        komplikasi TEXT NOT NULL
      )
      ''');
    }
  }

  // Metode untuk user_identity
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

  // Metode untuk pregnancy_history
  Future<int> insertPregnancyHistory(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert('pregnancy_history', row);
  }

  Future<List<Map<String, dynamic>>> getPregnancyHistories() async {
    final db = await instance.database;
    return await db.query('pregnancy_history');
  }

  Future<int> updatePregnancyHistory(Map<String, dynamic> row) async {
    final db = await instance.database;
    int id = row['id'];
    return await db.update('pregnancy_history', row, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deletePregnancyHistory(int id) async {
    final db = await instance.database;
    return await db.delete('pregnancy_history', where: 'id = ?', whereArgs: [id]);
  }

  // Metode umum
  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}