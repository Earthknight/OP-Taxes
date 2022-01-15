import 'package:flutter/material.dart';
import 'dart:math';
import 'package:get/get.dart';
import 'package:taxes/helpers/common_code.dart';
import '../widgets/error_alert_box.dart';
import '../helpers/db_helper.dart';

class HomeStateController extends GetxController {
  // VARS FOR MANAGING THE STATE OF HOME SCREEN
  List taxes = [];
  List mostlySearchedTaxes = [];
  List mostlyAppearedTaxes = [];
  List mostlyKnownTaxes = [];
  var isLoading = false;
  var isSearchMode = false;
  List searchedTaxes = [];

  // TEXT EDIT CONTROLLER FOR USER SEARCH
  final searchTextController = TextEditingController();

  Map<String, dynamic> getTaxMap(Map<String, dynamic> map) {
    return {
      'tax_name': map['name'],
      'country': map['country'],
      'color': Colors.primaries[Random().nextInt(Colors.primaries.length)],
      'tax_data': map,
    };
  }

  List getIDsList(
    List<Map<String, dynamic>> dataList,
    List ids,
  ) {
    for (int i = 0; i < dataList.length; i++) {
      ids.add(dataList[i]['id']);
    }
    return ids;
  }

  Future<void> setTaxes(
    List ids,
    List differentTaxes,
  ) async {
    for (int j = 0; j < ids.length; j++) {
      await DBHelper.getTaxFromID(ids[j])
          .then((value) => differentTaxes.add(getTaxMap(value)));
    }

    update();
  }

  // METHOD TO FETCH THE KINDS OF TAXES
  // FROM DB AND SET IT ON HOME SCREEN
  Future<void> fetchAndSetTaxes() async {
    final taxesDataList = await DBHelper.getData('taxes');
    final mostSearchedTaxesDataList =
        await DBHelper.getData(CommonCode.MOSTLY_SEARCHED_TABLE);
    final mostAppearedTaxesDataList =
        await DBHelper.getData(CommonCode.MOSTLY_APPEARED_TABLE);
    final mostKnownTaxesDataList =
        await DBHelper.getData(CommonCode.MOSTLY_KNOWN_TABLE);

    if (taxesDataList.isNotEmpty) {
      // MAPPING OVER THE RECORDS AND SETTING IT TO LIST OF TAXES
      taxes = taxesDataList.map((tax) => getTaxMap(tax)).toList();
    } else {
      ErrorAlertBox.getErrorAlertBox('Error occred while fetching taxes');
    }

    var ids = [];
    if (mostSearchedTaxesDataList.isNotEmpty) {
      ids = getIDsList(
        mostSearchedTaxesDataList,
        ids,
      );

      setTaxes(
        ids,
        mostlySearchedTaxes,
      );
    }

    if (mostAppearedTaxesDataList.isNotEmpty) {
      ids = [];
      ids = getIDsList(
        mostAppearedTaxesDataList,
        ids,
      );

      setTaxes(
        ids,
        mostlyAppearedTaxes,
      );
    }

    if (mostKnownTaxesDataList.isNotEmpty) {
      ids = [];
      ids = getIDsList(
        mostKnownTaxesDataList,
        ids,
      );

      setTaxes(
        ids,
        mostlyKnownTaxes,
      );
    }

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
    fetchAndSetTaxes();
    // DBHelper.insert();
  }
}
