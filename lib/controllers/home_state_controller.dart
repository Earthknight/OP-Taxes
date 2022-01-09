import 'package:flutter/material.dart';
import 'dart:math';
import 'package:get/get.dart';
import '../helpers/db_helper.dart';

class HomeStateController extends GetxController {
  List taxes = [];
  var isLoading = false;
  var _isSearchMode = false;
  List _searchedTaxes = [];

  Future<void> fetchAndSetTaxes() async {
    print('CONTROLLER');
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

  @override
  void onInit() {
    super.onInit();
    isLoading = true;
    fetchAndSetTaxes();
  }
}
