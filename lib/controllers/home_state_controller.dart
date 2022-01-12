import 'package:flutter/material.dart';
import 'dart:math';
import 'package:get/get.dart';
import '../widgets/error_alert_box.dart';
import '../helpers/db_helper.dart';

class HomeStateController extends GetxController {
  // VARS FOR MANAGING THE STATE OF HOME SCREEN
  List taxes = [];
  var isLoading = false;
  var isSearchMode = false;
  List searchedTaxes = [];

  // TEXT EDIT CONTROLLER FOR USER SEARCH
  final searchTextController = TextEditingController();

  // METHOD TO FETCH THE KINDS OF TAXES
  // FROM DB AND SET IT ON HOME SCREEN
  Future<void> fetchAndSetTaxes() async {
    final dataList = await DBHelper.getData();

    if (dataList.isNotEmpty) {
      // MAPPING OVER THE RECORDS AND SETTING IT TO LIST OF TAXES
      taxes = dataList
          .map((tax) => {
                'tax_name': tax['name'],
                'country': tax['country'],
                'color':
                    Colors.primaries[Random().nextInt(Colors.primaries.length)],
                'tax_data': tax,
              })
          .toList();
    } else {
      ErrorAlertBox.getErrorAlertBox('Error occred while fetching taxes');
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
