import 'package:sqflite/sqflite.dart';
import 'sqlflite_services.dart';
// import 'database.dart';
class StoryFunctions {

  static Future<int> insert(Map<String, dynamic> row) async {

    Database db = await SQLService.instance.database;
    return await db.insert('story', row);
  }

  static Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await SQLService.instance.database;
    return await db.query('story');
  }

  static Future<int>   queryRowCount() async {
    Database db = await SQLService.instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM story'));
  }
  static Future<List<Map<String, dynamic>>> queryRow(String id) async {
    Database db = await SQLService.instance.database;
    return await db.query('story',columns: ['id','time','name','city','country'],
        where: 'id = ?', whereArgs: [id]
    );
  }

  static Future<int> update( int id,String name) async {
    Database db = await SQLService.instance.database;
    return await db.update('story',{'name':name}, where: 'id = ?', whereArgs: [id]);
  }
  static Future<int> updateSync( int id,String name) async {
    Database db = await SQLService.instance.database;
    return await db.update('story',{'synced':name}, where: 'id = ?', whereArgs: [id]);
  }


  static Future<int> delete(int id) async {
    Database db = await SQLService.instance.database;
    return await db.delete('story', where: 'id = ?', whereArgs: [id]);
  }


}
