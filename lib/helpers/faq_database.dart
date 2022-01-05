import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart'as path;
import 'package:taxes/helpers/que_ans.dart';

class DatabaseHelper {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath,'faqtrail.db'),
      onCreate: (db, version) => db.execute(
          'CREATE TABLE faqtrails(id TEXT PRIMARY KEY, questions TEXT, answers TEXT)'),
      version: 1,
    );
  }

  static Future<void> insert() async {
    final sqlDB = await DatabaseHelper.database();
    List<Map<String, Object?>> records = await sqlDB.query('faqtrails');
    if (records.isEmpty){
      print('IS EMPTY');
      for (int i = 0; i < ShortQuesAns().questions.length; i++){
        await sqlDB.insert(
          'faqtrails',
          {
            'id': i,
            'questions': ShortQuesAns().questions[i],
            'answers': ShortQuesAns().answers[i],
          },
          conflictAlgorithm: sql.ConflictAlgorithm.replace,
        );

      }
    } else {
      print('NOT EMPTY');
    }
  }
  static Future<List<Map<String, dynamic>>> getData() async {
    final sqlDB = await DatabaseHelper.database();
    return sqlDB.query('faqtrails');
  }
 }


