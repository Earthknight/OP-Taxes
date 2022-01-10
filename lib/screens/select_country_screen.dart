import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxes/widgets/ImageWidget.dart';
import 'package:taxes/widgets/TextWidget.dart';
import 'package:taxes/widgets/sizedBoxWidget.dart';
import 'drawer.dart';

class SelectCountry extends StatefulWidget {
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
        child: Column(
          children: [
            MySizedBox(
              height: 10.0,
            ),
            getImageAsset('assets/images/img.png', 125.0, 125.0),
            MySizedBox(
              height: 8.0,
            ),
            Center(
                child: MyText(
              text: "Please Select Your\n Country",
              size: 22,
              fontColor: Colors.black,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
            )),
            MySizedBox(
              height: 8.0,
            ),
            Center(
                child: MyText(
              text: "You can change the Country\n at any time",
              size: 9,
              fontColor: Colors.grey,
              textAlign: TextAlign.center,
            )),
            MySizedBox(
              height: 50.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildCountryPickerDropdownSoloExpanded(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildCountryPickerDropdownSoloExpanded() {
    return CountryPickerDropdown(
      underline: Container(
        height: 2,
        color: Color(0xff028A28),
      ),
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      onValuePicked: (Country country) {
        print("${country.name}");
      },
      itemBuilder: (Country country) {
        return Row(
          children: <Widget>[
            SizedBox(width: 8.0),
            CountryPickerUtils.getDefaultFlagImage(country),
            SizedBox(width: 8.0),
            Expanded(child: Text(country.name)),
          ],
        );
      },
      itemHeight: null,
      isExpanded: true,
    );
  }
}
