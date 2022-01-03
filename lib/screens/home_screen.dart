import 'package:flutter/material.dart';
import '../helpers/common_code.dart';
import '../helpers/db_helper.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List _taxes = [];

  Widget getTaxCard(
    double devicewidth,
    double deviceHeight,
    String country,
    String taxName,
    Color bgColor,
  ) {
    return Container(
      width: devicewidth * 0.4,
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
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
            getSizedBox(
              deviceHeight * 0.005,
            ),
            FittedBox(
              child: Text(
                taxName,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            getSizedBox(
              deviceHeight * 0.005,
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FittedBox(
                    child: Text(
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
      ),
    );
  }

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

  Future<void> fetchAndSetTaxes() async {
    final dataList = await DBHelper.getData();
    setState(() {
      _taxes = dataList
          .map((tax) => {
                'tax_name': tax['name'],
                'country': tax['country'],
                'color':
                    Colors.primaries[Random().nextInt(Colors.primaries.length)],
              })
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    // DBHelper.insert();
    fetchAndSetTaxes();
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
      body: SingleChildScrollView(
        child: Container(
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
                    'Co-orperate Tax',
                    Colors.lightGreen.shade200,
                  ),
                  getTaxTypeIcons(
                    'Business Tax',
                    Colors.yellow.shade200,
                  ),
                ],
              ),
              getSizedBox(
                deviceSize.height * 0.025,
              ),
              const Text(
                'Mostly Search',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                ),
                textAlign: TextAlign.left,
              ),
              getSizedBox(
                deviceSize.height * 0.025,
              ),
              SizedBox(
                height: deviceSize.height * 0.3,
                width: deviceSize.width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _taxes.length,
                  itemBuilder: (ctx, index) {
                    return getTaxCard(
                      deviceSize.width,
                      deviceSize.height,
                      _taxes[index]['country'].toString(),
                      _taxes[index]['tax_name'].toString(),
                      _taxes[index]['color'] as Color,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
