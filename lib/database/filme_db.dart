import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:app_mobile_project/models/filme.dart';

class FilmeDB {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  static Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'filmes.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE filmes (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            titulo TEXT,
            genero TEXT,
            urlImagem TEXT,
            faixaEtaria TEXT,
            descricao TEXT,
            duracao INTEGER,
            pontuacao REAL,
            ano INTEGER
          )
        ''');
      },
    );
  }

  static Future<int> insertFilme(Filme filme) async {
    final db = await database;
    return await db.insert('filmes', filme.toMap());
  }

  static Future<List<Filme>> getFilmes() async {
    final db = await database;
    final maps = await db.query('filmes');
    return maps.map((map) => Filme.fromMap(map)).toList();
  }

  static Future<int> updateFilme(Filme filme) async {
    final db = await database;
    return await db.update(
      'filmes',
      filme.toMap(),
      where: 'id = ?',
      whereArgs: [filme.id],
    );
  }

  static Future<int> deleteFilme(int id) async {
    final db = await database;
    return await db.delete('filmes', where: 'id = ?', whereArgs: [id]);
  }
}
