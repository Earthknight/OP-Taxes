import 'package:flutter/material.dart';
import '../helpers/common_code.dart';

import 'custom_boxes.dart';
import 'custom_card.dart';

class CustomTaxCard {
  static Widget getTaxCard(
    double devicewidth,
    double deviceHeight,
    String country,
    String taxName,
    Color bgColor,
  ) {
    return Container(
      width: devicewidth * 0.4,
      child: CustomCard.getCard(
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: Container(
                color: bgColor,
                width: double.infinity,
                child: Image.asset(
                  'assets/images/text.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            CustomBoxes.getSizedBox(
              height: deviceHeight * 0.005,
            ),
            CustomBoxes.getFittedBox(
              Text(
                taxName,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            CustomBoxes.getSizedBox(
              height: deviceHeight * 0.005,
            ),
            Container(
              margin: CommonCode.setMarginSymmteric(5, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomBoxes.getFittedBox(
                    Text(
                      country,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.book_outlined,
                  ),
                ],
              ),
            ),
          ],
        ),
        margin: CommonCode.setMarginSymmteric(10, 5),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }
}
