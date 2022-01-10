import 'dart:io';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'taxes.db'),
      onCreate: (db, version) => db.execute(
          'CREATE TABLE taxes(id TEXT PRIMARY KEY, name TEXT, country TEXT, defination TEXT, example TEXT)'),
      version: 1,
    );
  }

  static Future<void> insert() async {
    final sqlDB = await DBHelper.database();
    List<Map<String, Object?>> records = await sqlDB.query('taxes');
    print(records);
    if (records.isEmpty) {
      print('IS EMPTY');

      final taxNamesList = [
        'GST',
        'Income Tax',
        'Co-orperate Tax',
        'Business Tax',
        'Wealth Tax',
      ];

      final taxCountryList = [
        'India',
        'India',
        'USA',
        'Japan',
        'India',
      ];

      final taxDefinationList = [
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      ];

      final taxExampleList = [
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      ];

      for (int i = 0; i < taxNamesList.length; i++) {
        await sqlDB.insert(
          'taxes',
          {
            'id': i,
            'name': taxNamesList[i],
            'country': taxCountryList[i],
            'defination': taxDefinationList[i],
            'example': taxExampleList[i],
          },
          conflictAlgorithm: sql.ConflictAlgorithm.replace,
        );
      }
    } else {
      print('NOT EMPTY');
      // await sqlDB.insert(
      //   'taxes',
      //   {
      //     'id': 5,
      //     'name': 'VAT',
      //     'country': 'UAE',
      //     'defination':
      //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      //     'example':
      //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      //   },
      //   conflictAlgorithm: sql.ConflictAlgorithm.replace,
      // );
    }
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final sqlDB = await DBHelper.database();
    return sqlDB.query('taxes');
  }

  static Future<List<Map<String, dynamic>>> getSearchedTax(
      String searchText) async {
    final sqlDB = await DBHelper.database();
    return sqlDB.query(
      'taxes',
      where: 'name = ?',
      whereArgs: [searchText],
    );
  }

  static Future<List> getCountriesFromTax(String taxName) async {
    final sqlDB = await DBHelper.database();
    return sqlDB.query(
      'taxes',
      columns: ['country'],
      where: 'name = ?',
      whereArgs: [taxName],
    );
  }
}
