import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxes/screens/tax_detail_view.dart';
import 'package:taxes/widgets/custom_search_bar.dart';
import '../screens/drawer.dart';
import '../widgets/TextWidget.dart';
import '../helpers/common_code.dart';

class SearchResultTaxType extends StatelessWidget {
  const SearchResultTaxType({
    Key? key,
    this.searchResult,
    this.countriesList,
    this.taxValue,
  }) : super(key: key);

  final searchResult;
  final countriesList;
  final taxValue;

  Widget countryDropDown(List<String> countriesList) {
    String? _currentItemSelected = countriesList[0];
    return DropdownButton<String>(
      items: countriesList.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: MyText(
            text: value,
            fontColor: Colors.black,
          ),
        );
      }).toList(),
      value: _currentItemSelected,
      onChanged: (newValueSelected) {
        print(" new value : $newValueSelected");
        _currentItemSelected = newValueSelected;
        final tax = taxValue.taxes.where((element) =>
            element['country'].toString() == newValueSelected.toString());
        print(tax.first['tax_data']);
        Get.to(() => TaxDetailView(
              taxData: tax.first['tax_data'],
            ));
      },
      itemHeight: null,
      isExpanded: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = CommonCode.getDeviceSize(context);
    return Scaffold(
      appBar: AppBarWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: deviceSize.height * 0.35,
                  width: deviceSize.width,
                  decoration: BoxDecoration(
                    color: Colors.green.shade400,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(35),
                      bottomRight: Radius.circular(35),
                    ),
                  ),
                  child: Center(
                    child: MyText(
                      text:
                          'Explore tax search result $searchResult in various countries',
                      lines: 4,
                      size: 20,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                CustomSearchBar.getSearchBar(
                  TextEditingController(),
                  () {},
                  () {},
                  deviceSize,
                ),
              ],
            ),
            countryDropDown(countriesList),
          ],
        ),
      ),
    );
  }
}
