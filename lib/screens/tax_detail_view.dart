import 'package:flutter/material.dart';
import '../helpers/common_code.dart';
import '../widgets/TextWidget.dart';
import '../widgets/custom_boxes.dart';

class TaxDetailView extends StatelessWidget {
  const TaxDetailView({
    Key? key,
    this.taxData,
  }) : super(key: key);
  final taxData;

  @override
  Widget build(BuildContext context) {
    final deviceSize = CommonCode.getDeviceSize(context);

    return Scaffold(
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
                  padding: CommonCode.setEgdeInsetsSymmteric(10, 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                        text: taxData['name'],
                        size: 30,
                        fontColor: Colors.white,
                      ),
                      MyText(
                        text: taxData['country'],
                        size: 15,
                        fontColor: Colors.white,
                      ),
                      CustomBoxes.getSizedBox(
                        height: 10,
                      ),
                      MyText(
                        text: taxData['defination'],
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
                  text: taxData['example'],
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
