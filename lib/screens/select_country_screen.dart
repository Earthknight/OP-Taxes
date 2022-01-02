
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'drawer.dart';


class SelectCountry extends StatefulWidget{

  State<StatefulWidget> createState() {
    return SelectCountryState();
  }
}

class SelectCountryState extends State<SelectCountry>{



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBarWidget(),
      drawer: DrawerWidget(context),
      body: Container(
        child: Column(
          children: [
            getImageAsset('assets/images/img.png', 125.0,125.0),

            Center(
              child: Text("Please Select Your\n Country",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.black,
                ),
              ),
            ),

            Center(
              child: Text("You can change the Country\n at any time",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(
              height: 25.0,
            ), 
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Text('CountryPickerDropdown (SOLO)'),
                    _buildCountryPickerDropdownSoloExpanded(),
                    //ListTile(title: _buildCountryPickerDropdown(longerText: true)),
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
      //show'em (the text fields) you're in charge now
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      //if you want your dropdown button's selected item UI to be different
      //than itemBuilder's(dropdown menu item UI), then provide this selectedItemBuilder.
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
      //initialValue: 'TR',
      // icon: Icon(Icons.arrow_downward),
    );
  }

}



Widget getImageAsset(String url, double height, double width) {
  return Container(
      width: width,
      height: height,
    child: Image.asset(
      url,
      fit: BoxFit.cover,
    ),
    margin: EdgeInsets.all(25.0),
  );
}



