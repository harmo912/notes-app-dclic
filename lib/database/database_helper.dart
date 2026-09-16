import 'package:sqflite/sqflite.dart';
import '../models/user.dart';
import '../models/note.dart';

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
    return await openDatabase(
      'notes_app.db',
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL,
        password TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE notes(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        date TEXT NOT NULL
      )
    ''');

    await db.insert('users', {
      'username': 'admin',
      'password': 'admin123',
    });
  }

  // ---- USERS ----

  Future<User?> getUser(String username, String password) async {
    try {
      final db = await database;
      final result = await db.query(
        'users',
        where: 'username = ? AND password = ?',
        whereArgs: [username, password],
      );
      if (result.isNotEmpty) {
        return User.fromMap(result.first);
      }
      return null;
    } catch (e) {
      throw Exception("Impossible de vérifier les identifiants.");
    }
  }

  // ---- NOTES ----

  Future<int> insertNote(Note note) async {
    try {
      final db = await database;
      return await db.insert('notes', note.toMap());
    } catch (e) {
      throw Exception("Impossible d'enregistrer la note.");
    }
  }

  Future<List<Note>> getNotes() async {
    try {
      final db = await database;
      final result = await db.query('notes', orderBy: 'id DESC');
      return result.map((map) => Note.fromMap(map)).toList();
    } catch (e) {
      throw Exception("Impossible de charger les notes.");
    }
  }

  Future<int> updateNote(Note note) async {
    try {
      final db = await database;
      return await db.update(
        'notes',
        note.toMap(),
        where: 'id = ?',
        whereArgs: [note.id],
      );
    } catch (e) {
      throw Exception("Impossible de modifier la note.");
    }
  }

  Future<int> deleteNote(int id) async {
    try {
      final db = await database;
      return await db.delete(
        'notes',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw Exception("Impossible de supprimer la note.");
    }
  }
}