import 'package:flutter/material.dart';
import '../helpers/common_code.dart';
import 'custom_card.dart';

class CustomSearchBar {
  static Card getSearchBar(
    TextEditingController searchTextController,
    Function searchFunction,
    Function remove,
    Size deviceSize,
  ) {
    return CustomCard.getCard(
      Container(
        height: deviceSize.height * 0.065, // 0.065
        margin: CommonCode.setEgdeInsetsSymmteric(
          deviceSize.width * 0.065, // 0.065
          deviceSize.height * 0.0025, // 0.0025
        ),
        padding: const EdgeInsets.all(3),
        child: TextField(
          controller: searchTextController,
          decoration: const InputDecoration(
            suffixIcon: Icon(
              Icons.search_sharp,
              color: Colors.black,
            ),
            hintText: 'Search',
            border: InputBorder.none,
          ),
          keyboardType: TextInputType.text,
          onSubmitted: (value) {
            if (value.isEmpty) {
              remove();
            }

            if (value.isNotEmpty && searchTextController.text.isNotEmpty) {
              searchFunction();
            }
          },
          // textInputAction: TextInputAction.search,
        ),
      ),
      margin: CommonCode.setEgdeInsetsSymmteric(
        deviceSize.width * 0.0255, // 0.0255
        deviceSize.height * 0.0065, // 0.0065
      ),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(deviceSize.width * 0.05),
      ),
    );
  }
}
