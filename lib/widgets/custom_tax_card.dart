import 'package:flutter/material.dart';
import '../helpers/common_code.dart';

import 'custom_boxes.dart';
import 'custom_card.dart';

class CustomTaxCard {
  static bool isSaved = false;

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
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(devicewidth * 0.05),
                topRight: Radius.circular(devicewidth * 0.05),
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
              margin: CommonCode.setEgdeInsetsSymmteric(
                devicewidth * 0.0125,
                0,
              ),
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
                  IconButton(
                    onPressed: () {
                      // SAVE / UNSAVE FOR THE PARTICULAR USER
                    },
                    icon: Icon(
                      isSaved ? Icons.book : Icons.book_outlined,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        margin: CommonCode.setEgdeInsetsSymmteric(
          devicewidth * 0.025,
          deviceHeight * 0.0067,
        ),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(devicewidth * 0.05),
        ),
      ),
    );
  }
}
