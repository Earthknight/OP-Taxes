import 'package:flutter/material.dart';
import 'dart:math';
import 'package:get/get.dart';
import 'package:taxes/helpers/common_code.dart';
import '../widgets/error_alert_box.dart';
import '../helpers/db_helper.dart';
import '../models/tax_model.dart';

class HomeStateController extends GetxController {
  // VARIABLES FOR MANAGING THE STATE OF HOME SCREEN
  List taxes = [];
  List mostlySearchedTaxes = [];
  List mostlyAppearedTaxes = [];
  List mostlyKnownTaxes = [];
  var isLoading = false;
  var isSearchMode = false;
  List searchedTaxes = [];

  // TEXT EDIT CONTROLLER FOR USER SEARCH
  final searchTextController = TextEditingController();

  // FUNCTION TO GET TAX OBJECT FROM MAP
  Tax getTaxObject(Map<String, dynamic> map) {
    return Tax(
      map['name'],
      map['country'],
      map['id'],
      map['defination'],
      map['example'],
    );
  }

  // FUNCTION TO RETURN TAX DATA IN THE FORM OF MAP
  // Map<String, dynamic> getTaxMap(Map<String, dynamic> map) {
  //   return {
  //     'tax_name': map['name'],
  //     'country': map['country'],
  //     'color': Colors.primaries[Random().nextInt(Colors.primaries.length)],
  //     'tax_data': map,
  //   };
  // }

  // FUNCTION TO GENERATE LIST OF
  // IDS OF TAXES AND RETURN THAT
  List getIDsList(
    List<Map<String, dynamic>> dataList,
    List ids,
  ) {
    for (int i = 0; i < dataList.length; i++) {
      ids.add(dataList[i]['id']);
    }
    return ids;
  }

  // FUNCTION TO SET DIFFERENT KIND OF
  // TAX TYPES IN THEIR RESPECTIVE LISTS
  Future<void> setTaxes(
    List ids,
    List differentTaxes,
  ) async {
    for (int j = 0; j < ids.length; j++) {
      await DBHelper.getTaxFromID(ids[j])
          // .then((value) => differentTaxes.add(getTaxMap(value)));
          .then((value) => differentTaxes.add(getTaxObject(value)));
    }

    update();
  }

  // METHOD TO FETCH THE KINDS OF TAXES
  // FROM DB AND SET IT ON HOME SCREEN
  Future<void> fetchAndSetTaxes() async {
    // GATHERING DIFFERENT KINDS OF TAXES FROM THE TABLES
    final taxesDataList = await DBHelper.getData('taxes');
    final mostSearchedTaxesDataList =
        await DBHelper.getData(CommonCode.MOSTLY_SEARCHED_TABLE);
    final mostAppearedTaxesDataList =
        await DBHelper.getData(CommonCode.MOSTLY_APPEARED_TABLE);
    final mostKnownTaxesDataList =
        await DBHelper.getData(CommonCode.MOSTLY_KNOWN_TABLE);

    if (taxesDataList.isNotEmpty) {
      // MAPPING OVER THE RECORDS AND SETTING IT TO LIST OF TAXES
      // taxes = taxesDataList.map((tax) => getTaxMap(tax)).toList();
      taxes = taxesDataList.map((tax) => getTaxObject(tax)).toList();
    } else {
      ErrorAlertBox.getErrorAlertBox('Error occred while fetching taxes');
    }

    var ids = [];
    // FETCHING FOR MOST SEARCHED TAXES TYPE
    if (mostSearchedTaxesDataList.isNotEmpty) {
      ids = getIDsList(
        mostSearchedTaxesDataList,
        ids,
      );

      // SET TAXES IN THE RESPECTIVE LIST I.E. MOSTLY SEARCHED TAXES
      setTaxes(
        ids,
        mostlySearchedTaxes,
      );
    }

    // FETCHING FOR MOST APPEARED TAXES TYPE
    if (mostAppearedTaxesDataList.isNotEmpty) {
      ids = [];
      ids = getIDsList(
        mostAppearedTaxesDataList,
        ids,
      );

      // SET TAXES IN THE RESPECTIVE LIST I.E. MOSTLY APPEARED TAXES
      setTaxes(
        ids,
        mostlyAppearedTaxes,
      );
    }

    // FETCHING FOR MOST KNOWN TAXES TYPE
    if (mostKnownTaxesDataList.isNotEmpty) {
      ids = [];
      ids = getIDsList(
        mostKnownTaxesDataList,
        ids,
      );

      // SET TAXES IN THE RESPECTIVE LIST I.E. MOSTLY KNOWN TAXES
      setTaxes(
        ids,
        mostlyKnownTaxes,
      );
    }

    // SET LOADING TO FALSE AND UPDATE
    isLoading = false;
    update();
  }

  // METHOD FOR USER SEARCH
  void searchTaxText() async {
    // FETCH TAXES FROM DB WHERE THE USER SEARCH MATCHES
    // AND SHOW THE RESULTS
    final searchResults =
        await DBHelper.getSearchedTax(searchTextController.text);

    isSearchMode = true;
    searchedTaxes = searchResults;

    update();
  }

  // METHOD TO REMOVE THE SEARCH SCREEN
  void removeSearch() {
    isSearchMode = false;
    searchedTaxes = [];
    update();
  }

  // METHOD TO UPDATE THE SEARCH MODE
  // WHEN USER TAPS BACK BUTTON
  void updateIsSearchMode() {
    isSearchMode = !isSearchMode;
    searchTextController.clear();
    update();
  }

  // INIT METHOD
  @override
  void onInit() {
    super.onInit();
    isLoading = true;
    DBHelper.insert();
    fetchAndSetTaxes();
  }
}
