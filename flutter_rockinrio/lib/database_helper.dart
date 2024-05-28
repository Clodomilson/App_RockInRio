import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'app_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, cpf TEXT, email TEXT, phone TEXT, password TEXT)',
    );
  }

  Future<int> registerUser(String name, String cpf, String email, String phone, String password) async {
    final db = await database;
    var res = await db.insert('users', {'name': name, 'cpf': cpf, 'email': email, 'phone': phone, 'password': password});
    return res;
  }

  Future<Map<String, dynamic>?> authenticateUser(String email, String password) async {
    final db = await database;
    var res = await db.query('users', where: 'email = ? AND password = ?', whereArgs: [email, password]);
    if (res.isNotEmpty) {
      return res.first;
    }
    return null;
  }
}
