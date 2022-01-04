import 'package:flutter/material.dart';

class CustomWidgets {
  static Card getSearchBar(
    TextEditingController searchTextController,
    Function searchFunction,
    Function remove,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 2,
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
    );
  }

  static SizedBox getSizedBox(double? width, double? height) {
    return height == 0.0
        ? SizedBox(
            width: width,
          )
        : SizedBox(
            height: height,
          );
  }

  static FittedBox getFittedBox(
    Widget child, {
    BoxFit boxFit = BoxFit.contain,
  }) {
    return FittedBox(
      child: child,
      fit: boxFit,
    );
  }

  static CircleAvatar getCircleAvatar(
    Widget child,
    double radius,
    Color bgColor,
  ) {
    return CircleAvatar(
      backgroundColor: bgColor,
      child: child,
      radius: radius,
    );
  }

  static Widget getCircularIcons(
    double radius, {
    String text = 'default',
    Color bgColor = Colors.white,
    String image = 'default',
  }) {
    return Column(
      children: [
        getCircleAvatar(
          Image.asset(
            image,
            fit: BoxFit.cover,
            height: 40,
          ),
          radius,
          bgColor,
        ),
        getFittedBox(
          Text(
            text,
          ),
        ),
      ],
    );
  }
}
