import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'point_functions.dart';
import 'story_functions.dart';
import 'image_functions.dart';
class SQLService {

  static final _databaseName = "stories.db";
  static final _databaseVersion = 1;

  static final storyTable = 'story';
  static final imageTable = 'image';
  static final pointTable = 'point';


  //singlton class to manage them all
  SQLService._privateConstructor();

  static final SQLService instance = SQLService._privateConstructor();

  // single wide-app reference
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onConfigure: _onConfigure,
        onCreate: _onCreate);
  }

  Future _onConfigure(Database db) async {
    // Add support for cascade delete
    await db.execute("PRAGMA foreign_keys = ON");
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $storyTable (
            id INTEGER PRIMARY KEY,
            synced TEXT NOT NULL,
            time Text NOT NULL, 
            name TEXT NOT NULL,
            city TEXT NOT NULL,
            country TEXT NOT NULL
          )
          ''');

    await db.execute('''
          CREATE TABLE $imageTable (
            id INTEGER PRIMARY KEY,
            time Text NOT NULL, 
            description TEXT,
            path TEXT NOT NULL,
            lat DOUBLE NOT NULL,
            lng DOUBLE NOT NULL,
            story_id INTEGER NOT NULL,
            FOREIGN KEY (story_id) REFERENCES story(id) ON DELETE CASCADE ON UPDATE CASCADE)
          ''');

    await db.execute('''
          CREATE TABLE $pointTable (
            id INTEGER PRIMARY KEY,
            lat DOUBLE NOT NULL,
            lng DOUBLE NOT NULL,
            seq INTEGER NOT NULL,
            story_id INTEGER NOT NULL,
            FOREIGN KEY (story_id) REFERENCES story(id) ON DELETE CASCADE ON UPDATE CASCADE)
          ''');

  }

// Helper methods

// Inserts a row in the database where each key in the Map is a column name
// and the value is the column value. The return value is the id of the
// inserted row.
// Future<int> insert(Map<String, dynamic> row) async {
//    return await ImageFunctions.insert( row);
// }
//
// // All of the rows are returned as a list of maps, where each map is
// // a key-value list of columns.
// Future<List<Map<String, dynamic>>> queryAllRows() async {
//   // Database db = await instance.database;
//    return await ImageFunctions.queryAllRows();
// }

// All of the methods (insert, query, update, delete) can also be done using
// raw SQL commands. This method uses a raw query to give the row count.
// Future<int> queryRowCount() async {
// Database db = await instance.database;
// return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
// }

// We are assuming here that the id column in the map is set. The other
// column values will be used to update the row.
// Future<int> update(Map<String, dynamic> row) async {
// Database db = await instance.database;
// int id = row[columnId];
// return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
// }

// Deletes the row specified by the id. The number of affected rows is
// returned. This should be 1 as long as the row exists.
// Future<int> delete(int id) async {
// Database db = await instance.database;
// return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
// }
//
}
