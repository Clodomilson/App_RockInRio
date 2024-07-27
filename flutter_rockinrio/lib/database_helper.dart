import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'app_database.db');
    print('Database path: $path'); // Adicione esta linha para imprimir o caminho
    return await openDatabase(
      path,
      version: 3, // Atualize a versão do banco de dados
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  void _onCreate(Database db, int version) async {
    print('Creating database and tables');
    await db.execute(
      '''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT UNIQUE,
        phone TEXT,
        password TEXT
      )
      '''
    );
    print('Database and tables created');
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print('Upgrading database from version $oldVersion to $newVersion');
    if (oldVersion < 2) {
      await db.execute("ALTER TABLE users ADD COLUMN name TEXT");
      await db.execute("ALTER TABLE users ADD COLUMN phone TEXT");
      print('Database upgraded to version 2');
    }
  }

  Future<int> insertUser(Map<String, dynamic> user) async {
    try {
      Database db = await database;
      return await db.insert('users', user);
    } catch (e) {
      print('Error inserting user: $e');
      return -1;
    }
  }

  Future<Map<String, dynamic>?> getUser(String email, String password) async {
    try {
      Database db = await database;
      List<Map<String, dynamic>> results = await db.query(
        'users',
        where: 'email = ? AND password = ?',
        whereArgs: [email, password],
      );
      return results.isNotEmpty ? results.first : null;
    } catch (e) {
      print('Error fetching user: $e');
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    try {
      Database db = await database;
      return await db.query('users');
    } catch (e) {
      print('Error fetching users: $e');
      return [];
    }
  }

  Future<int> updateUser(Map<String, dynamic> user) async {
    try {
      Database db = await database;
      return await db.update(
        'users',
        user,
        where: 'id = ?',
        whereArgs: [user['id']],
      );
    } catch (e) {
      print('Error updating user: $e');
      return -1;
    }
  }

  Future<int> deleteUser(int id) async {
    try {
      Database db = await database;
      int userCount = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM users'))!;
      if (userCount > 1) {
        return await db.delete(
          'users',
          where: 'id = ?',
          whereArgs: [id],
        );
      } else {
        throw Exception("Cannot delete the last remaining user.");
      }
    } catch (e) {
      print('Error deleting user: $e');
      return -1;
    }
  }
}
