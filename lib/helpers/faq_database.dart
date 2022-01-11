import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null)
      return _database;
    _database = await initDB();
    return _database;
  }
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "faqtrail.db");
    return await openDatabase(path, version: 1, onOpen: (db)  async{
    }, onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE longqtrails(id TEXT PRIMARY KEY, questions TEXT, answers TEXT)');
      await db.execute('CREATE TABLE faqstrails(id TEXT PRIMARY KEY, questions TEXT, answers TEXT)');
    });
  }


  insert(String showquery,var  value1,var  value2) async {
    final db = await database;
    var res;
    for (int i = 0; i < value1.length; i++){
      res = await db!.insert(
        showquery,
        {
          'id': i,
          'questions': value1[i],
          'answers': value2[i],
        },
      );
    }
    return res;
  }
  Future<List<Map<String, dynamic>>> getLongData() async {
    final db = await database;
    return  db!.query('longqtrails');
  }
  Future<List<Map<String, dynamic>>> getSmallData() async {
    final db = await database;
    return  db!.query('faqstrails');
  }
}




























//
// import 'package:flutter_test/flutter_test.dart';
// import 'package:sqflite/sqflite.dart' as sql;
// import 'package:path/path.dart'as path;
// import 'package:taxes/helpers/que_ans.dart';
//
//
// class DatabaseHelper {
//   static Future<sql.Database> database() async {
//     final dbPath = await sql.getDatabasesPath();
//     return sql.openDatabase(
//       path.join(dbPath,'faqtrail.db'),
//       onCreate: (db, version) => db.execute(
//           'CREATE TABLE faqtrails(id TEXT PRIMARY KEY, questions TEXT, answers TEXT)'),
//       version: 1,
//     );
//   }
//
//   static Future<void> insert() async {
//     final sqlDB = await DatabaseHelper.database();
//     List<Map<String, Object?>> records = await sqlDB.query('faqtrails');
//     if (records.isEmpty){
//       print('IS EMPTY');
//       for (int i = 0; i < ShortQuesAns().questions.length; i++){
//         await sqlDB.insert(
//           'faqtrails',
//           {
//             'id': i,
//             'questions': ShortQuesAns().questions[i],
//             'answers': ShortQuesAns().answers[i],
//           },
//           conflictAlgorithm: sql.ConflictAlgorithm.replace,
//         );
//
//       }
//     } else {
//       print('NOT EMPTY');
//     }
//   }
//   static Future<List<Map<String, dynamic>>> getData() async {
//     final sqlDB = await DatabaseHelper.database();
//     return sqlDB.query('faqtrails');
//   }
//  }
//
//
