import 'package:flutter/material.dart';
import 'dart:math';
import 'package:get/get.dart';
import '../helpers/db_helper.dart';

class HomeStateController extends GetxController {
  List taxes = [];
  var isLoading = false;
  var isSearchMode = false;
  List searchedTaxes = [];
  final searchTextController = TextEditingController();

  Future<void> fetchAndSetTaxes() async {
    final dataList = await DBHelper.getData();

    taxes = dataList
        .map((tax) => {
              'tax_name': tax['name'],
              'country': tax['country'],
              'color':
                  Colors.primaries[Random().nextInt(Colors.primaries.length)],
              'tax_data': tax,
            })
        .toList();
    isLoading = false;
    update();
  }

  void searchTaxText() async {
    final searchResults =
        await DBHelper.getSearchedTax(searchTextController.text);

    isSearchMode = true;
    searchedTaxes = searchResults;

    update();
  }

  void removeSearch() {
    isSearchMode = false;
    searchedTaxes = [];
    update();
  }

  @override
  void onInit() {
    super.onInit();
    isLoading = true;
    fetchAndSetTaxes();
  }
}
