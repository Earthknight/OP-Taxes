import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxes/helpers/db_helper.dart';
import 'package:taxes/screens/search_result_tax_type_screen.dart';
import 'package:taxes/screens/select_country_screen.dart';
import '../widgets/TextWidget.dart';

// CONTROLLERS
import '../controllers/home_state_controller.dart';

// HELPERS
import '../helpers/common_code.dart';

// SCREENS
import '../screens/tax_detail_view.dart';

// WIDGETS
import '../widgets/custom_boxes.dart';
import '../widgets/custom_circular_icons.dart';
import '../widgets/custom_list_view_builder.dart';
import '../widgets/custom_tax_card.dart';
import '../widgets/custom_search_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  WillPopScope getWillPopScope(
    HomeStateController value,
    Widget child,
  ) {
    return WillPopScope(
      child: child,
      onWillPop: () {
        if (value.isSearchMode) {
          value.updateIsSearchMode();
        }
        return Future.value(false);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = CommonCode.getDeviceSize(context);
    final homeTaxData = [
      {
        'tax_name': 'Income Tax',
        'bg_color': Colors.green.shade300,
        'image': 'assets/images/text.png',
      },
      {
        'tax_name': 'GST',
        'bg_color': Colors.red.shade200,
        'image': 'assets/images/text.png',
      },
      {
        'tax_name': 'Services',
        'bg_color': Colors.blue.shade200,
        'image': 'assets/images/text.png',
      },
      {
        'tax_name': 'Wealth Tax',
        'bg_color': Colors.purple.shade400,
        'image': 'assets/images/text.png',
      },
      {
        'tax_name': 'Co-operate Tax',
        'bg_color': Colors.lightGreen.shade200,
        'image': 'assets/images/text.png',
      },
      {
        'tax_name': 'Business Tax',
        'bg_color': Colors.yellow.shade200,
        'image': 'assets/images/text.png',
      },
    ];

    return Scaffold(
      body: GetBuilder<HomeStateController>(
        init: HomeStateController(),
        // IF FETCHING IS IN PROGRESS THEN SHOW PROGRESS INDICATOR
        // ELSE THE TAXES DATA & SCREEN
        builder: (value) => value.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: value.isSearchMode
                    ? Container(
                        height: deviceSize.height,
                        width: deviceSize.width,
                        child: Column(
                          children: [
                            // CUSTOM SEARCH BAR
                            CustomSearchBar.getSearchBar(
                              value.searchTextController,
                              value.searchTaxText,
                              value.removeSearch,
                              deviceSize,
                            ),
                            // IF SEARCHED TAXES IS EMPTY MEANS NO TAXES FOUND
                            // ELSE SHOW THE FOUND TAXES IN RESULTS
                            value.searchedTaxes.isEmpty
                                ? getWillPopScope(
                                    value,
                                    CustomBoxes.getSizedBox(
                                      height: deviceSize.height * 0.75,
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Icon(
                                              Icons.not_interested,
                                              size: 50,
                                            ),
                                            MyText(
                                              text: 'NO SEARCH RESULTS',
                                              textAlign: TextAlign.center,
                                              size: 25,
                                              fontColor: Colors.black,
                                              lines: 2,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                : Expanded(
                                    // CUSTOM LIST VIEW BUILDER TO SHOW THE SEARCHED TAX RESULTS
                                    child: getWillPopScope(
                                      value,
                                      CustomListViewBuilder.getListViewBuilder(
                                        value.searchedTaxes.length,
                                        (ctx, index) {
                                          return Card(
                                            elevation: 5,
                                            margin: CommonCode
                                                .setEgdeInsetsSymmteric(8, 5),
                                            child: GestureDetector(
                                              onTap: () {
                                                DBHelper.getCountriesFromTax(
                                                        value.searchedTaxes[
                                                            index]['name'])
                                                    .then((taxValue) {
                                                  List myList = taxValue
                                                      .asMap()
                                                      .entries
                                                      .map((element) => element
                                                          .value['country'])
                                                      .toList();

                                                  Get.to(
                                                    () => SearchResultTaxType(
                                                      searchResult: value
                                                          .searchedTaxes[index]
                                                              ['name']
                                                          .toString(),
                                                      countriesList:
                                                          myList.cast<String>(),
                                                      taxValue: value,
                                                    ),
                                                  );
                                                });
                                              },
                                              child: ListTile(
                                                leading: Image.asset(
                                                  'assets/images/tax.png',
                                                  fit: BoxFit.contain,
                                                  height:
                                                      deviceSize.width * 0.1,
                                                ),
                                                title: MyText(
                                                  text: value
                                                      .searchedTaxes[index]
                                                          ['name']
                                                      .toString(),
                                                  size: 15,
                                                  fontColor: Colors.black,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      )
                    : Container(
                        height: deviceSize.height,
                        width: deviceSize.width,
                        child: Column(
                          children: [
                            // CUSTOM SEARCH BAR
                            CustomSearchBar.getSearchBar(
                              value.searchTextController,
                              value.searchTaxText,
                              value.removeSearch,
                              deviceSize,
                            ),
                            CustomBoxes.getSizedBox(
                              height: deviceSize.height * 0.025,
                            ),
                            Container(
                              height: deviceSize.height * 0.35,
                              padding: EdgeInsets.all(12.0),
                              child: GridView.builder(
                                itemCount: homeTaxData.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 4.0,
                                        mainAxisSpacing: 4.0),
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      final tax = value.taxes.where((element) =>
                                          element['tax_name'].toString() ==
                                          homeTaxData[index]['tax_name']
                                              .toString());

                                      Get.to(() => TaxDetailView(
                                            taxData: tax.first['tax_data'],
                                          ));
                                    },
                                    child: CustomCircularIcon.getCircularIcon(
                                      deviceSize.width * 0.1,
                                      text: homeTaxData[index]['tax_name']
                                          .toString(),
                                      bgColor: homeTaxData[index]['bg_color']
                                          as Color,
                                      image: homeTaxData[index]['image']
                                          .toString(),
                                    ),
                                  );
                                },
                              ),
                            ),
                            CustomBoxes.getSizedBox(
                              height: deviceSize.height * 0.025,
                            ),
                            const MyText(
                              text: 'Mostly Search',
                              fontColor: Colors.black,
                              size: 22,
                              textAlign: TextAlign.left,
                            ),
                            CustomBoxes.getSizedBox(
                              height: deviceSize.height * 0.025,
                            ),
                            CustomBoxes.getSizedBox(
                              height: deviceSize.height * 0.3,
                              width: deviceSize.width,
                              // CUSTOM HORIZONTAL LIST VIEW TO SHOW KIND OF TAXES
                              child: CustomListViewBuilder.getListViewBuilder(
                                value.taxes.length,
                                (ctx, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      // GETX METHOD TO ROUTE TO NEW PAGE
                                      // I.E. TAX DETAIL VIEW ON TAP
                                      Get.to(() => TaxDetailView(
                                            taxData: value.taxes[index]
                                                ['tax_data'],
                                          ));
                                    },
                                    // CUSTOM TAX CARD
                                    child: CustomTaxCard.getTaxCard(
                                      deviceSize.width,
                                      deviceSize.height,
                                      value.taxes[index]['country'].toString(),
                                      value.taxes[index]['tax_name'].toString(),
                                      value.taxes[index]['color'] as Color,
                                    ),
                                  );
                                },
                                scrollAxis: Axis.horizontal,
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
      ),
    );
  }
}
