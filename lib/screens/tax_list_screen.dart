import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:taxes/helpers/db_helper.dart';
import 'package:taxes/screens/tax_deflong.dart';
import 'package:taxes/screens/tax_detail_view.dart';
import 'package:taxes/widgets/TextWidget.dart';
import 'package:taxes/widgets/clippper.dart';
import 'package:taxes/widgets/error_alert_box.dart';
import 'package:taxes/widgets/get_device_size.dart';
import 'package:taxes/widgets/sizedBoxWidget.dart';
import 'drawer.dart';


class TaxType extends StatefulWidget {
  /// VARIABLES
  final List<String>? taxList;
  bool showNothing;
  bool showDetailWithCountry;
  String? country;

  //IF showNothing IS TRUE THEN IT WILL SHOW "NOTHING TO SHOW" IN CENTER
  //IF showDetailWithCountry IS TRUE AND country IS NOT NULL THEN IT WILL NAVIGATE TO TAX DETAIL SCREEN
  //OTHERWISE IT WILL NAVIGATE TO LONG DEFINITION SCREEN

  TaxType(
      {Key? key,
        this.taxList,
        this.showNothing = false,
        this.showDetailWithCountry = false,
        this.country})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TaxTypeState();
  }
}

class TaxTypeState extends State<TaxType> {
  @override
  Widget build(BuildContext context) {
    final screenSize = GetDeviceSize.getDeviceSize(context);
    double fontSize =
    screenSize.width <= 600 ? screenSize.width / 26 : screenSize.width / 38;
    return Scaffold(
      appBar: AppBarWidget(),
      drawer: DrawerWidget(context),
      body: SafeArea(
        child: widget.showNothing == true
            ? const Center(
          child: MyText(
            text: "Nothing to show",
            fontColor: Colors.black,
          ),
        )
            : Container(
            color: Colors.white,
            child: Column(
              children: [
                const SizedBox(
                  height: 00,
                ),
                Stack(children: [
                  const Clipper(),
                  Positioned(
                      top: 50,
                      right: screenSize.width * 0.5,
                      child: Row(
                        children: const [
                          MyText(
                            text: "Taxes",
                            fontColor: Colors.white,
                            fontWeight: FontWeight.bold,
                            size: 25.0,
                          ),
                          Icon(
                            Icons.calculate,
                            size: 55.0,
                            color: Colors.white,
                          ),
                        ],
                      )),
                ]),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: GridView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const ScrollPhysics(),
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20.0,
                            mainAxisSpacing: 20.0),
                        itemCount: widget.taxList?.length,
                        itemBuilder: (context, int index) {
                          return gridItem(widget.taxList![index], index);
                        }),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget gridItem(String gridItemText, int index) {
    return InkWell(
        child: MySizedBox(
          height: 150.0,
          width: 150.0,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 20,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(left: 3.0, right: 3.0),
              child: Center(
                  child: MyText(
                    text: gridItemText,
                    fontColor: Colors.black,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                    size: 10.0,
                    lines: 3,
                  )),
            ),
          ),
        ),
        onTap: () async {
          /// IF showDetailWithCountry IS TRUE THEN IT WILL NAVIGATE TO TAX DETAIL SCREEN
          /// OTHERWISE IT WILL SHOW TAX LONG DEFINITION SCREEN
          if (widget.showDetailWithCountry == true) {
            moveToTaxDetailScreen(gridItemText, widget.country!);
          }
          else {
            Get.to(() => TaxDeflong(index));
          }
        });
  }
}

/// TO GET THE MAP OF THE TAX
Map<String, dynamic> getTaxMap(Map<String, dynamic> map) {
  return {
    'tax_name': map['name'],
    'country': map['country'],
    'color': Colors.primaries[Random().nextInt(Colors.primaries.length)],
    'tax_data': map,
  };
}

/// FUNCTION TO NAVIGATE TO THE TA DETAIL SCREEN
void goToTaxDetailScreen(Map<String, dynamic> tax) {
  try {
    Get.to(() => TaxDetailView(
      taxData: tax['tax_data'],
    ));
  } catch (error) {
    ErrorAlertBox.getErrorAlertBox(
      error.toString(),
    );
  }
}

/// FUNCTION TO DO REQUIRED OPERATIONS FOR THE NAVIGATION TO TAX DETAIL SCREEN
void moveToTaxDetailScreen(String TaxName, String countryName)async {
  var data = await DBHelper.getTaxDetails(TaxName, countryName);
  // print("calling data : $data");
  List taxes = [];
  taxes = data.map((tax) => getTaxMap(tax)).toList();
  // print("taxes : $taxes");
  goToTaxDetailScreen(taxes[0]);
}
