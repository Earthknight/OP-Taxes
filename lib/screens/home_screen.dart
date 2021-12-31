import 'package:flutter/material.dart';
import '../helpers/common_code.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Widget getSizedBox(double height) {
    return SizedBox(
      height: height,
    );
  }

  Widget getTaxTypeIcons(String text, Color bgColor) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: bgColor,
          child: Image.asset(
            'assets/images/text.png',
            fit: BoxFit.cover,
            height: 40,
          ),
          radius: 40,
        ),
        FittedBox(
          child: Text(
            text,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = CommonCode.getDeviceSize(context);

    final searchWidget = Card(
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
        child: TextFormField(
          decoration: const InputDecoration(
            suffixIcon: Icon(
              Icons.search_sharp,
              color: Colors.black,
            ),
            hintText: 'Search',
            border: InputBorder.none,
          ),
          keyboardType: TextInputType.text,
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Taxes OP',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        height: deviceSize.height,
        width: deviceSize.width,
        child: Column(
          children: [
            searchWidget,
            getSizedBox(
              deviceSize.height * 0.025,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                getTaxTypeIcons(
                  'Income Tax',
                  Colors.green.shade300,
                ),
                getTaxTypeIcons(
                  'GST',
                  Colors.red.shade200,
                ),
                getTaxTypeIcons(
                  'Services',
                  Colors.blue.shade200,
                ),
              ],
            ),
            getSizedBox(
              deviceSize.height * 0.025,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                getTaxTypeIcons(
                  'Wealth Tax',
                  Colors.purple.shade400,
                ),
                getTaxTypeIcons(
                  'Corporate Tax',
                  Colors.lightGreen.shade200,
                ),
                getTaxTypeIcons(
                  'VAT',
                  Colors.yellow.shade200,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
