import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:taxes/helpers/db_helper.dart';
import 'package:taxes/screens/tax_list_screen.dart';
import 'package:taxes/widgets/ImageWidget.dart';
import 'package:taxes/widgets/TextWidget.dart';
import 'package:taxes/widgets/sizedBoxWidget.dart';
import 'drawer.dart';

class SelectCountry extends StatefulWidget {
  final List<String>? countriesList;
  final bool showNothing;
  final bool showDetails;
  final String? taxName;

  const SelectCountry(
      {Key? key,
      this.countriesList,
      this.showDetails = false,
      this.showNothing = false,
      this.taxName})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SelectCountryState();
  }
}

class SelectCountryState extends State<SelectCountry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      drawer: DrawerWidget(context),
      body: Container(
        child: widget.showNothing == true
            ? const Center(
                child: MyText(
                  text: "Nothing to show",
                  fontColor: Colors.black,
                ),
              )
            : Column(
                children: [
                  const MySizedBox(
                    height: 10.0,
                  ),
                  getImageAsset('assets/images/img.png', 125.0, 125.0),
                  const MySizedBox(
                    height: 1.0,
                  ),
                  const Center(
                      child: MyText(
                    text: "Please Select Your\n Country",
                    size: 22,
                    fontColor: Colors.black,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                  )),
                  // MySizedBox(height: 8.0,),
                  const Center(
                      child: MyText(
                    text: "To get the more info about the Tax",
                    size: 9,
                    fontColor: Colors.grey,
                    textAlign: TextAlign.center,
                    lines: 2,
                  )),
                  const MySizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          widget.countriesList == null
                              ? _buildCountryPickerDropdownSoloExpanded()
                              : countryDropDown(
                                  (widget.countriesList)!,
                                  widget.taxName!,
                                ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget countryDropDown(List<String> countriesList, String taxName) {
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
        setState(() {
          // print(" new value : $newValueSelected");
          _currentItemSelected = newValueSelected;
          moveToTaxDetailScreen(taxName, newValueSelected!);
        });
      },
      itemHeight: null,
      isExpanded: true,
    );
  }

  _buildCountryPickerDropdownSoloExpanded() {
    return CountryPickerDropdown(
      underline: Container(
        height: 2,
        color: const Color(0xff028A28),
      ),
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      onValuePicked: (Country country) {
        // print(country.name);
        moveToTaxScreen(country.name.toString(), context);
      },
      itemBuilder: (Country country) {
        return Row(
          children: <Widget>[
            const SizedBox(width: 8.0),
            CountryPickerUtils.getDefaultFlagImage(country),
            const SizedBox(width: 8.0),
            Expanded(child: Text(country.name)),
          ],
        );
      },
      itemHeight: null,
      isExpanded: true,
    );
  }

  void moveToTaxScreen(String countryName, BuildContext context) async {
    var myTaxesList = await DBHelper().getTaxesList(countryName);
    if (myTaxesList.isNotEmpty) {
      Get.to(() => TaxType(
            taxList: myTaxesList,
            country: countryName,
            showDetailWithCountry: true,
          ));
      // Navigator.of(context, rootNavigator: true).push(
      //   MaterialPageRoute(builder: (context) =>  TaxType(taxList: myTaxesList,showDetailWithCountry: true, country: countryName,)),
      // );
    } else {
      Get.to(() => TaxType(showNothing: true));
      //   Navigator.of(context, rootNavigator: true).push(
      //     MaterialPageRoute(builder: (context) =>  TaxType(showNothing: true,)),
      //   );
    }
  }
}
