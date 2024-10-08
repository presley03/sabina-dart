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
    return await openDatabase(path, version: 5, onCreate: _createDB, onUpgrade: _onUpgrade);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE user_identity (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nama TEXT,
      agama TEXT,
      tanggal_lahir TEXT,
      alamat TEXT,
      golongan_darah TEXT
    )
    ''');

    await db.execute('''
    CREATE TABLE pregnancy_history (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      tanggal_haid_terakhir TEXT,
      usia_kehamilan TEXT,
      berat_badan_sebelum_hamil INTEGER,
      tinggi_badan INTEGER,
      kehamilan_ke TEXT,
      jumlah_anak TEXT,
      riwayat_keguguran TEXT,
      anak_ke_terakhir TEXT,
      tahun_lahir_terakhir TEXT,
      berat_badan_lahir_terakhir TEXT,
      cara_persalinan_terakhir TEXT,
      penolong_persalinan_terakhir TEXT,
      komplikasi_kehamilan_terakhir TEXT
    )
    ''');
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 5) {
      // Drop the existing table if it exists
      await db.execute("DROP TABLE IF EXISTS pregnancy_history");
      
      // Recreate the table with the correct structure
      await db.execute('''
      CREATE TABLE pregnancy_history (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        tanggal_haid_terakhir TEXT,
        usia_kehamilan TEXT,
        berat_badan_sebelum_hamil INTEGER,
        tinggi_badan INTEGER,
        kehamilan_ke TEXT,
        jumlah_anak TEXT,
        riwayat_keguguran TEXT,
        anak_ke_terakhir TEXT,
        tahun_lahir_terakhir TEXT,
        berat_badan_lahir_terakhir TEXT,
        cara_persalinan_terakhir TEXT,
        penolong_persalinan_terakhir TEXT,
        komplikasi_kehamilan_terakhir TEXT
      )
      ''');
    }
  }

  // Methods for user_identity
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

  // Methods for pregnancy_history
  Future<int> insertPregnancyHistory(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert('pregnancy_history', row);
  }

  Future<List<Map<String, dynamic>>> getPregnancyHistory() async {
    final db = await instance.database;
    return await db.query('pregnancy_history', orderBy: 'id DESC');
  }

  Future<Map<String, dynamic>?> getLatestPregnancyHistory() async {
    final db = await instance.database;
    final results = await db.query(
      'pregnancy_history',
      orderBy: 'id DESC',
      limit: 1,
    );
    return results.isNotEmpty ? results.first : null;
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

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}