import 'dart:io';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:taxes/helpers/common_code.dart';

import '../widgets/error_alert_box.dart';

class DBHelper {
  // FUNCTION TO GET SQL DATABASE
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'taxes.db'),
      onCreate: (db, version) {
        // IF THE TABLES ARE NOT CREATED THEN CREATE THEM
        // TAXES TABLE
        db.execute(
            'CREATE TABLE taxes(id TEXT PRIMARY KEY, name TEXT, country TEXT, defination TEXT, example TEXT)');

        // MOST SEARCHED TAXES TABLE
        db.execute(
          CommonCode.CREATE_TABLE +
              ' ' +
              CommonCode.MOSTLY_SEARCHED_TABLE +
              CommonCode.CATEGORY_TABLE,
        );

        // MOST APPEARED TAXES TABLE
        db.execute(
          CommonCode.CREATE_TABLE +
              ' ' +
              CommonCode.MOSTLY_APPEARED_TABLE +
              CommonCode.CATEGORY_TABLE,
        );

        // MOST KNOWN TAXES TABLE
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

  // FUNCTION TO RUN RAW SQL QUERY BY PASSING
  // THE QUERY AS A STRING IN PARAMETER
  static Future<void> sqlQuery(
    String sqlQueryString,
  ) async {
    try {
      final sqlDB = await DBHelper.database();
      sqlDB.rawQuery(sqlQueryString);
    } on sql.DatabaseException catch (error) {
      ErrorAlertBox.getErrorAlertBox(error.toString());
    } catch (error) {
      ErrorAlertBox.getErrorAlertBox(error.toString());
    }
  }

  // INSERT FUNCTION TO INSERT
  // DUMMY DATA IN TABLES FOR NOW
  static Future<void> insert() async {
    try {
      final sqlDB = await DBHelper.database();

      // FETCHING THE RECORDS OF TAXES TABLE
      List<Map<String, Object?>> taxRecords = await sqlDB.query(
        'taxes',
      );
      List<Map<String, Object?>> mostlySearchedRecords = await sqlDB.query(
        CommonCode.MOSTLY_SEARCHED_TABLE,
      );
      List<Map<String, Object?>> mostlyAppearedRecords = await sqlDB.query(
        CommonCode.MOSTLY_APPEARED_TABLE,
      );
      List<Map<String, Object?>> mostlyKnownRecords = await sqlDB.query(
        CommonCode.MOSTLY_KNOWN_TABLE,
      );

      // IF RECORDS IS EMPTY THEN FILL IN DATA IN THE TABLE
      // ELSE NOTHING
      if (taxRecords.isEmpty) {
        // TAX NAMES
        final taxNamesList = [
          'GST',
          'Income Tax',
          'Co-orperate Tax',
          'Business Tax',
          'Wealth Tax',
          'VAT',
        ];

        // TAX COUNTRIES
        final taxCountryList = [
          'India',
          'India',
          'USA',
          'Japan',
          'India',
          'UAE',
        ];

        // TAX DEF
        final taxDefinationList = [
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        ];

        // TAX EXAMPLES
        final taxExampleList = [
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        ];

        // INSERTING DATA IN THE TABLE
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

        // INSERTION FOR MOST SEARCHED TAXES IN THE TABLE
        if (mostlySearchedRecords.isEmpty) {
          sqlQuery(
            CommonCode.INSERT_INTO +
                ' ' +
                CommonCode.MOSTLY_SEARCHED_TABLE +
                '(id) SELECT id FROM taxes WHERE id=4;',
          );
        }

        // INSERTION FOR MOST APPEARED TAXES IN THE TABLE
        if (mostlyAppearedRecords.isEmpty) {
          sqlQuery(
            CommonCode.INSERT_INTO +
                ' ' +
                CommonCode.MOSTLY_APPEARED_TABLE +
                '(id) SELECT id FROM taxes WHERE id=1;',
          );
        }

        // INSERTION FOR MOST KNOWN TAXES IN THE TABLE
        if (mostlyKnownRecords.isEmpty) {
          sqlQuery(
            CommonCode.INSERT_INTO +
                ' ' +
                CommonCode.MOSTLY_KNOWN_TABLE +
                '(id) SELECT id FROM taxes WHERE id=5;',
          );
        }
      } else {
        // ELSE BLOCK TO ENTER ANY DATA IN EXISTING TABLES

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

  // FUNCTION TO GET THE DATA FROM RESPECTIVE
  // TABLES BY RUNNING SQL QUERY
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

  // FUNCTION TO GET THE TAX DATA FROM TAX ID
  // BY RUNNING SQL QUERY
  static Future<Map<String, dynamic>> getTaxFromID(
    String taxID,
  ) async {
    try {
      final sqlDB = await DBHelper.database();
      // FETCH THE TAX OBJECT FROM TAXES TABLE BASED
      // ON TAX ID AS THE CONDITION IN THE SQL QUERY
      return sqlDB
          .query('taxes', where: 'id = ?', whereArgs: [taxID], limit: 1)
          .then((value) => value[0]);
    } on sql.DatabaseException catch (error) {
      ErrorAlertBox.getErrorAlertBox(error.toString());
    } catch (error) {
      ErrorAlertBox.getErrorAlertBox(error.toString());
    }
    return {'error': 'tax does not exists'} as Future<Map<String, dynamic>>;
  }

  // FUNCTION TO GET THE TAX BASED ON
  // USER INPUT IN SEARCH BAR
  static Future<List<Map<String, dynamic>>> getSearchedTax(
    String searchText,
  ) async {
    try {
      final sqlDB = await DBHelper.database();
      // SQL QUERY TO FETCH THE TAXES FROM TAXES TABLE
      // BASED ON TAX NAME AS THE QUERY
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

  /// FUNCTION TO GET THE LIST OF COUNTRIES FROM TAX
  // BT SELECTING TAX FROM DRAWER
  Future<List<String>> getCountriesList(String selectedTax) async {
    try {
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
    } on sql.DatabaseException catch (error) {
      ErrorAlertBox.getErrorAlertBox(error.toString());
    } catch (error) {
      ErrorAlertBox.getErrorAlertBox(error.toString());
    }
    return [];
  }

  /// FUNCTION TO GET THE LIST OF TAXES FROM COUNTRY
  // BY SELECTING COUNTRY FROM DROPDOWN
  Future<List<String>> getTaxesList(String selectedCountry) async {
    try {
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
    } on sql.DatabaseException catch (error) {
      ErrorAlertBox.getErrorAlertBox(error.toString());
    } catch (error) {
      ErrorAlertBox.getErrorAlertBox(error.toString());
    }
    return [];
  }

  // FUNCTION TO GET THE COUNTRIES FROM TAX NAME
  static Future<List> getCountriesFromTax(String taxName) async {
    try {
      final sqlDB = await DBHelper.database();
      // SQL QUERY TO FETCH TAXES FROM TAXES TABLE
      // BASED ON COUNTRY AS THE CONDITION
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

  /// FUNCTION TO GET THE DETAILS OF THE TAX FROM ITS NAME AND COUNTRY
  static Future<List<Map<String, dynamic>>> getTaxDetails(
      String taxName, String countryName) async {
    try {
      final sqlDB = await DBHelper.database();
      // SQL QUERY TO GET TAX DETAIL FROM DB TABLE
      // TAXES USING TAX NAME AND TAX COUNTRY
      return sqlDB.query(
        'taxes',
        where: 'name = ? and country =?',
        whereArgs: [taxName, countryName],
        // limit: 1,
      );
    } on sql.DatabaseException catch (error) {
      ErrorAlertBox.getErrorAlertBox(error.toString());
    } catch (error) {
      ErrorAlertBox.getErrorAlertBox(error.toString());
    }
    return [];
  }
}
