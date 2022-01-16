import 'dart:math';

import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/tax_model.dart';

// CONTROLLERS
import '../controllers/home_state_controller.dart';

// HELPERS
import '../helpers/common_code.dart';
import '../helpers/db_helper.dart';

// SCREENS
import '../screens/tax_detail_view.dart';
import '../screens/select_country_screen.dart';
import '../screens/search_result_tax_type_screen.dart';

// WIDGETS
import '../widgets/custom_boxes.dart';
import '../widgets/custom_circular_icons.dart';
import '../widgets/custom_list_view_builder.dart';
import '../widgets/custom_tax_card.dart';
import '../widgets/custom_search_bar.dart';
import '../widgets/error_alert_box.dart';
import '../widgets/TextWidget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  // FUNCTION WHICH RETURNS WILL POP SCOPE FOR
  // CHECKING IF THE USER PRESSES THE BACK BUTTON
  WillPopScope getWillPopScope(
    HomeStateController value,
    Widget child,
  ) {
    return WillPopScope(
      child: child,
      onWillPop: () {
        // IN CASE OF SEARCH MODE ONLY
        // CHANGE THE SEARCH MODE TO FALSE
        // ON USER BACK PRESS
        if (value.isSearchMode) {
          value.updateIsSearchMode();
        }
        return Future.value(false);
      },
    );
  }

  // FUNCTION TO ROUTE TO TAX DETAIL SCREEN ON USER TAP
  void goToTaxDetailScreen(Tax tax) {
    try {
      // PASSING THE TAX OBJECT
      Get.to(() => TaxDetailView(
            taxData: tax,
          ));
    } catch (error) {
      ErrorAlertBox.getErrorAlertBox(
        error.toString(),
      );
    }
  }

  // FUNCTION WHICH RETURNS COLUMN CONTAINING HORIZONTAL LIST VIEW
  // FOR VARIOUS TYPES AND CATEGORIES OF TAXES
  Widget getTaxHorizontalListView(
    Size deviceSize,
    String title,
    List differentTaxes,
  ) {
    return Column(
      children: [
        // SHOW THE TITLE
        MyText(
          text: title,
          fontColor: Colors.black,
          size: 22,
          textAlign: TextAlign.left,
        ),
        // SIZED BOX
        CustomBoxes.getSizedBox(
          height: deviceSize.height * 0.025,
        ),
        CustomBoxes.getSizedBox(
          height: deviceSize.height * 0.3,
          width: deviceSize.width,
          // CUSTOM HORIZONTAL LIST VIEW TO SHOW KIND OF TAXES
          child: CustomListViewBuilder.getListViewBuilder(
            differentTaxes.length,
            (ctx, index) {
              return GestureDetector(
                onTap: () {
                  // GETX METHOD TO ROUTE TO NEW PAGE
                  // I.E. TAX DETAIL VIEW ON TAP
                  goToTaxDetailScreen(differentTaxes[index]);
                },
                // CUSTOM TAX CARD
                child: CustomTaxCard.getTaxCard(
                  deviceSize.width,
                  deviceSize.height,
                  differentTaxes[index], // TAX OBJECT
                  Colors.primaries[Random().nextInt(
                      Colors.primaries.length)], // GENERATE RANDOM COLORS
                ),
              );
            },
            scrollAxis: Axis.horizontal,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = CommonCode.getDeviceSize(context);
    // HOME SCREEN TAX DATA
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
                                                // SQL QUERY TO GET COUNTRIES FROM TAX NAME
                                                DBHelper.getCountriesFromTax(
                                                        value.searchedTaxes[
                                                            index]['name'])
                                                    .then((taxValue) {
                                                  // CREATING THE LIST OF COUNTRIES FROM THE MAP
                                                  List myList = taxValue
                                                      .asMap()
                                                      .entries
                                                      .map((element) => element
                                                          .value['country'])
                                                      .toList();

                                                  try {
                                                    // ROUTING TO SEARCH RESULTS SCREEN
                                                    Get.to(
                                                      () => SearchResultTaxType(
                                                        // TAX NAME
                                                        searchResult: value
                                                            .searchedTaxes[
                                                                index]['name']
                                                            .toString(),
                                                        // LIST OF COUNTRIES
                                                        countriesList: myList
                                                            .cast<String>(),
                                                        // HOME STATE CONTROLLER FOR MANAING THE DATA ON NEXT SCREEN
                                                        taxValue: value,
                                                      ),
                                                    );
                                                  } catch (error) {
                                                    ErrorAlertBox
                                                        .getErrorAlertBox(
                                                      error.toString(),
                                                    );
                                                  }
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
                    : SingleChildScrollView(
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
                            // SHOW THE 6 SIX TYPES OF CIRCULAR ICONS FOR TAXES IN GRID FORMAT
                            Container(
                              height: deviceSize.height * 0.35,
                              padding: const EdgeInsets.all(12.0),
                              child: GridView.builder(
                                itemCount: homeTaxData.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 4.0,
                                  mainAxisSpacing: 4.0,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      try {
                                        final tax = value.taxes.where(
                                            (element) =>
                                                element.taxName.toString() ==
                                                homeTaxData[index]['tax_name']
                                                    .toString());

                                        if (tax.isEmpty) {
                                          throw Exception('An error occured!');
                                        }
                                        // ON USER TAP ROUTE TO TAX DETAIL VIEW SCREEN
                                        goToTaxDetailScreen(tax.first);
                                      } catch (error) {
                                        ErrorAlertBox.getErrorAlertBox(
                                          error.toString(),
                                        );
                                      }
                                    },
                                    // CIRCULAR ICONS
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
                            // LIST VIEW FOR ALL TAXES TYPES
                            getTaxHorizontalListView(
                              deviceSize,
                              'All Taxes',
                              value.taxes,
                            ),
                            // LIST VIEW FOR MOST SEARCHED TAXES TYPES
                            getTaxHorizontalListView(
                              deviceSize,
                              'Most Searched',
                              value.mostlySearchedTaxes,
                            ),
                            // LIST VIEW FOR MOST APPEARED TAXES TYPES
                            getTaxHorizontalListView(
                              deviceSize,
                              "Most Appeared",
                              value.mostlyAppearedTaxes,
                            ),
                            // LIST VIEW FOR MOST KNOWN TAXES TYPES
                            getTaxHorizontalListView(
                              deviceSize,
                              'Most Known',
                              value.mostlyKnownTaxes,
                            ),
                          ],
                        ),
                      ),
              ),
      ),
    );
  }
}
