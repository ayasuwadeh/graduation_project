import 'package:sqflite/sqflite.dart';
import 'sqlflite_services.dart';
class ImageFunctions {

  static Future<int> insert(Map<String, dynamic> row) async {

    Database db = await SQLService.instance.database;
    return await db.insert('image', row);
  }

  static Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await SQLService.instance.database;
    return await db.query('image');
  }

  static Future<List<Map<String, dynamic>>> queryRow(String id) async {
    Database db = await SQLService.instance.database;
    return await db.query('image',columns: ['id','time','description','path','lat','lng','story_id'],
        where: 'story_id = ?', whereArgs: [id]
    );
  }


  static  Future<int> queryRowCount() async {
    Database db = await SQLService.instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM image'));
  }

  static Future<int> update(int id,String name) async {
    Database db = await SQLService.instance.database;
    return await db.update('image', {'description':name}, where: 'id = ?', whereArgs: [id]);
  }

  static Future<int> updatePath(int id,String name) async {
    Database db = await SQLService.instance.database;
    return await db.update('image', {'path':name}, where: 'id = ?', whereArgs: [id]);
  }


  static Future<int> delete(int id) async {
    Database db = await SQLService.instance.database;

    return await db.delete('image', where: 'id = ?', whereArgs: [id]);
  }

}
