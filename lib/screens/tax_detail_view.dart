import 'package:flutter/material.dart';
import '../helpers/common_code.dart';

class TaxDetailView extends StatelessWidget {
  const TaxDetailView({
    Key? key,
    this.taxData,
  }) : super(key: key);
  static const routeName = '/tax-detail-view';
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 15,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        taxData['name'],
                        style: const TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                        ),
                        // textAlign: TextAlign.left,
                      ),
                      Text(
                        taxData['country'],
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
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
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 15,
                ),
                child: Text(
                  'Example',
                  style: TextStyle(
                    fontSize: 29,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 15,
                ),
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
