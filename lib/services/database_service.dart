import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static Database? _database;

  static Future<Database> getDatabase() async {
    if (_database != null) return _database!;

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'bloody.db');

    _database = await openDatabase(
      path,
      version: 2, // Збільшено версію
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            age INTEGER,
            gender TEXT,
            bloodType TEXT,
            createdAt TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE donations(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            date TEXT,
            type TEXT,
            feeling TEXT,
            notes TEXT
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          // Додаємо поле createdAt до існуючої таблиці
          await db.execute('ALTER TABLE users ADD COLUMN createdAt TEXT');
        }
      },
    );

    return _database!;
  }
}