import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_sample/model.dart';

class SqflitDB {
  static Database? _database;
  static const db = 'my_database.db';
  static const tablename = 'nametable';
  static const colID = 'id';
  static const colNAME = 'name';
  // static List<ModelClass> list = [];

  static Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDb(db);
    return _database!;
  }

  static Future<Database> initDb(String s) async {
    final dbpath = await getDatabasesPath();
    final path = join(dbpath, s);
    return await openDatabase(
      path,
      version: 1,
      onCreate: onCreate,
    );
  }

  static Future<void> onCreate(Database db, int version) async {
    await db.execute(
        '''CREATE TABLE $tablename ($colID INTEGER PRIMARY KEY, $colNAME TEXT NOT NULL)''');
  }

  static Future<List<ModelClass>> getData(List<ModelClass> list) async {
    final db = await database;
    final values = await db.rawQuery('SELECT * FROM $tablename');
    print(values);
    list.clear();
    values.forEach(
      (element) {
        final name = ModelClass.fromMap(element);
        list.add(name);
      },
    );
    print('get all data $list ${list.length}');

    return list;
  }

  static Future<void> insertData(ModelClass model) async {
    final db = await database;
    await db.rawInsert('INSERT INTO $tablename (name) values(?)', [model.name]);
    print('added ${model.name}');
  }

  static Future<void> delete(int? id) async {
    final db = await database;
    await db.rawDelete('DELETE FROM $tablename WHERE $colID=?', [id]);
    print('deleted');
  }

  static Future<void> update(ModelClass model) async {
    final db = await database;
    await db.update(
      '$tablename',
      model.toMap(),
      where: '$colID=?',
      whereArgs: [model.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('updated');
  }
}
