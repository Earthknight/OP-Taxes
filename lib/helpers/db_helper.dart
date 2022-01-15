import 'dart:io';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:taxes/helpers/common_code.dart';

import '../widgets/error_alert_box.dart';

class DBHelper {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'taxes.db'),
      onCreate: (db, version) {
        db.execute(
            'CREATE TABLE taxes(id TEXT PRIMARY KEY, name TEXT, country TEXT, defination TEXT, example TEXT)');
        print('HEHE');
        db.execute(
          CommonCode.CREATE_TABLE +
              ' ' +
              CommonCode.MOSTLY_SEARCHED_TABLE +
              CommonCode.CATEGORY_TABLE,
        );
        db.execute(
          CommonCode.CREATE_TABLE +
              ' ' +
              CommonCode.MOSTLY_APPEARED_TABLE +
              CommonCode.CATEGORY_TABLE,
        );
        db.execute(
          CommonCode.CREATE_TABLE +
              ' ' +
              CommonCode.MOSTLY_KNOWN_TABLE +
              CommonCode.CATEGORY_TABLE,
        );
      },
      version: 1,
    );
  }

  static Future<void> sqlQuery(
    String sqlQueryString,
  ) async {
    final sqlDB = await DBHelper.database();
    sqlDB.rawQuery(sqlQueryString);
  }

  static Future<void> insert() async {
    try {
      final sqlDB = await DBHelper.database();
      List<Map<String, Object?>> records = await sqlDB.query('taxes');

      if (records.isEmpty) {
        print('IS EMPTY');

        final taxNamesList = [
          'GST',
          'Income Tax',
          'Co-orperate Tax',
          'Business Tax',
          'Wealth Tax',
          'VAT',
        ];

        final taxCountryList = [
          'India',
          'India',
          'USA',
          'Japan',
          'India',
          'UAE',
        ];

        final taxDefinationList = [
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
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

        sqlQuery(
          CommonCode.INSERT_INTO +
              ' ' +
              CommonCode.MOSTLY_SEARCHED_TABLE +
              '(id) SELECT id FROM taxes WHERE id=4;',
        );
        sqlQuery(
          CommonCode.INSERT_INTO +
              ' ' +
              CommonCode.MOSTLY_APPEARED_TABLE +
              '(id) SELECT id FROM taxes WHERE id=1;',
        );
        sqlQuery(
          CommonCode.INSERT_INTO +
              ' ' +
              CommonCode.MOSTLY_KNOWN_TABLE +
              '(id) SELECT id FROM taxes WHERE id=5;',
        );
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
    } on sql.DatabaseException catch (error) {
      ErrorAlertBox.getErrorAlertBox(error.toString());
    } catch (error) {
      ErrorAlertBox.getErrorAlertBox(error.toString());
    }
  }

  static Future<List<Map<String, dynamic>>> getData(
    String tableName,
  ) async {
    try {
      final sqlDB = await DBHelper.database();
      return sqlDB.query(tableName);
    } on sql.DatabaseException catch (error) {
      ErrorAlertBox.getErrorAlertBox(error.toString());
    } catch (error) {
      ErrorAlertBox.getErrorAlertBox(error.toString());
    }
    return [];
  }

  static Future<Map<String, dynamic>> getTaxFromID(
    String taxID,
  ) async {
    final sqlDB = await DBHelper.database();
    return sqlDB
        .query('taxes', where: 'id = ?', whereArgs: [taxID], limit: 1)
        .then((value) => value[0]);
  }

  static Future<List<Map<String, dynamic>>> getSearchedTax(
    String searchText,
  ) async {
    try {
      final sqlDB = await DBHelper.database();
      return sqlDB.query(
        'taxes',
        where: 'name = ?',
        whereArgs: [searchText],
        // limit: 1,
      );
    } on sql.DatabaseException catch (error) {
      ErrorAlertBox.getErrorAlertBox(error.toString());
    } catch (error) {
      ErrorAlertBox.getErrorAlertBox(error.toString());
    }
    return [];
  }

  Future<List<String>> getCountriesList(String selectedTax) async {
    var results = await getData('taxes');
    print("results: $results");
    List<String> countries = [];
    for (int i = 0; i < results.length; i++) {
      if (selectedTax == results[i]["name"].toString()) {
        countries.add(results[i]["country"].toString());
      }
    }
    print(countries);
    return countries;
  }

  Future<List<String>> getTaxesList(String selectedCountry) async {
    var results = await getData('taxes');
    print("results: $results");
    List<String> taxes = [];
    for (int i = 0; i < results.length; i++) {
      if (selectedCountry == results[i]["country"].toString()) {
        taxes.add(results[i]["name"].toString());
      }
    }
    print(taxes);
    return taxes;
  }

  static Future<List> getCountriesFromTax(String taxName) async {
    try {
      final sqlDB = await DBHelper.database();
      return sqlDB.query(
        'taxes',
        columns: ['country'],
        where: 'name = ?',
        whereArgs: [taxName],
      );
    } on sql.DatabaseException catch (error) {
      ErrorAlertBox.getErrorAlertBox(error.toString());
    } catch (error) {
      ErrorAlertBox.getErrorAlertBox(error.toString());
    }
    return [];
  }
}
