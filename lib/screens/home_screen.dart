import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  @override
  Widget build(BuildContext context) {
    final deviceSize = CommonCode.getDeviceSize(context);

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
                                ? const Center(
                                    child: Text('NO SEARCH RESULTS'),
                                  )
                                : Expanded(
                                    // CUSTOM LIST VIEW BUILDER TO SHOW THE SEARCHED TAX RESULTS
                                    child: CustomListViewBuilder
                                        .getListViewBuilder(
                                      value.searchedTaxes.length,
                                      (ctx, index) {
                                        return Card(
                                          elevation: 5,
                                          margin:
                                              CommonCode.setEgdeInsetsSymmteric(
                                                  8, 5),
                                          child: ListTile(
                                            leading: Image.asset(
                                              'assets/images/tax.png',
                                              fit: BoxFit.contain,
                                              height: deviceSize.width * 0.1,
                                            ),
                                            title: Text(
                                              value.searchedTaxes[index]['name']
                                                  .toString(),
                                              style: const TextStyle(
                                                fontSize: 24,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
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
                            // ROW CIRCLE ICONS TAX
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CustomCircularIcon.getCircularIcon(
                                  deviceSize.width * 0.1,
                                  text: 'Income Tax',
                                  bgColor: Colors.green.shade300,
                                  image: 'assets/images/text.png',
                                ),
                                CustomCircularIcon.getCircularIcon(
                                  deviceSize.width * 0.1,
                                  text: 'GST',
                                  bgColor: Colors.red.shade200,
                                  image: 'assets/images/text.png',
                                ),
                                CustomCircularIcon.getCircularIcon(
                                  deviceSize.width * 0.1,
                                  text: 'Services',
                                  bgColor: Colors.blue.shade200,
                                  image: 'assets/images/text.png',
                                ),
                              ],
                            ),
                            CustomBoxes.getSizedBox(
                              height: deviceSize.height * 0.025,
                            ),
                            // ROW CIRCLE ICONS TAX
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CustomCircularIcon.getCircularIcon(
                                  deviceSize.width * 0.1,
                                  text: 'Wealth Tax',
                                  bgColor: Colors.purple.shade400,
                                  image: 'assets/images/text.png',
                                ),
                                CustomCircularIcon.getCircularIcon(
                                  deviceSize.width * 0.1,
                                  text: 'Co-orperate Tax',
                                  bgColor: Colors.lightGreen.shade200,
                                  image: 'assets/images/text.png',
                                ),
                                CustomCircularIcon.getCircularIcon(
                                  deviceSize.width * 0.1,
                                  text: 'Business Tax',
                                  bgColor: Colors.yellow.shade200,
                                  image: 'assets/images/text.png',
                                ),
                              ],
                            ),
                            CustomBoxes.getSizedBox(
                              height: deviceSize.height * 0.025,
                            ),
                            const Text(
                              'Mostly Search',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                              ),
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
