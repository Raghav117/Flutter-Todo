import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do/models/tiles.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "ToDo.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE ToDo ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "title TEXT,"
          "description TEXT,"
          "image TEXT,"
          "priority INTEGER,"
          "completed INTEGER"
          ")");
    });
  }

  insert(Tile newTile) async {
    final db = await database;
    var res = await db.insert("ToDo", newTile.toMap());
    return res;
  }

  display() async {
    final db = await database;
    var res = await db.query("ToDo");
    List<Tile> list =
        res.isNotEmpty ? res.map((c) => Tile.fromMap(c)).toList() : [];
    return list;
  }

  update(Tile tile) async {
    final db = await database;
    var res = await db
        .update("ToDo", tile.toMap(), where: "id = ?", whereArgs: [tile.id]);
    return res;
  }

  updateWithId(Tile tile, int id) async {
    final db = await database;
    var res =
        await db.update("ToDo", tile.toMap(), where: "id = ?", whereArgs: [id]);
    return res;
  }

  delete(int id) async {
    final db = await database;
    db.delete("ToDo", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from ToDo");
  }
}
