import 'package:flutter/material.dart';
import '../helpers/common_code.dart';
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
                      Text(
                        taxData['name'],
                        style: const TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        taxData['country'],
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      CustomBoxes.getSizedBox(
                        height: 10,
                      ),
                      Text(
                        taxData['defination'],
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: CommonCode.setEgdeInsetsSymmteric(10, 15),
                child: const Text(
                  'Example',
                  style: TextStyle(
                    fontSize: 29,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: CommonCode.setEgdeInsetsSymmteric(10, 15),
                child: Text(
                  taxData['example'],
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
