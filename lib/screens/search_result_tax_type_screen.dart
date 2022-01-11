import 'package:flutter/material.dart';
import 'package:taxes/widgets/custom_boxes.dart';
import 'package:taxes/widgets/custom_search_bar.dart';
import '../screens/drawer.dart';
import '../widgets/TextWidget.dart';
import '../helpers/common_code.dart';

class SearchResultTaxType extends StatelessWidget {
  const SearchResultTaxType({
    Key? key,
    this.searchResult,
  }) : super(key: key);

  final searchResult;

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
          ],
        ),
      ),
    );
  }
}
