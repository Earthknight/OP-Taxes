import 'package:flutter/material.dart';
import '../screens/drawer.dart';
import '../helpers/common_code.dart';
import '../widgets/TextWidget.dart';
import '../widgets/custom_boxes.dart';
import '../models/tax_model.dart';

class TaxDetailView extends StatelessWidget {
  const TaxDetailView({
    Key? key,
    required this.taxData,
  }) : super(key: key);
  final Tax taxData;

  @override
  Widget build(BuildContext context) {
    final deviceSize = CommonCode.getDeviceSize(context);

    return Scaffold(
      appBar: AppBarWidget(),
      body: SingleChildScrollView(
        child: Container(
          height: deviceSize.height,
          width: deviceSize.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                child: Container(
                  height: deviceSize.height * 0.4,
                  width: deviceSize.width,
                  color: Colors.green.shade400,
                  padding: CommonCode.setEgdeInsetsSymmteric(8, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomBoxes.getFittedBox(
                        MyText(
                          text: taxData.taxName,
                          size: 26,
                          fontColor: Colors.white,
                        ),
                      ),
                      CustomBoxes.getFittedBox(
                        MyText(
                          text: taxData.taxCountry,
                          size: 12,
                          fontColor: Colors.white,
                        ),
                      ),
                      CustomBoxes.getSizedBox(
                        height: 10,
                      ),
                      MyText(
                        text: taxData.taxDefinition,
                        size: 10,
                        fontColor: Colors.white,
                        lines: 5,
                      ),
                    ],
                  ),
                ),
              ),
              // SHOW EXAMPLE TITLE
              Padding(
                padding: CommonCode.setEgdeInsetsSymmteric(10, 15),
                child: const MyText(
                  text: 'Example',
                  size: 25,
                  fontColor: Colors.black,
                ),
              ),
              // SHOW EXAMPLE DATA
              Padding(
                padding: CommonCode.setEgdeInsetsSymmteric(10, 15),
                child: MyText(
                  text: taxData.taxExample,
                  size: 10,
                  fontColor: Colors.black,
                  lines: 5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
