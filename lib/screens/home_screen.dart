import 'package:flutter/material.dart';
import 'package:taxes/widgets/custom_widgets.dart';
import '../screens/tax_detail_view.dart';
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
  var _isLoading = false;
  var _isSearchMode = false;
  List _searchedTaxes = [];

  final _searchTextController = TextEditingController();

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
            CustomWidgets.getSizedBox(
              0.0,
              deviceHeight * 0.005,
            ),
            CustomWidgets.getFittedBox(
              Text(
                taxName,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            CustomWidgets.getSizedBox(
              0.0,
              deviceHeight * 0.005,
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomWidgets.getFittedBox(
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
      ),
    );
  }

  // Widget getTaxTypeIcons(String text, Color bgColor) {
  //   return Column(
  //     children: [
  //       CircleAvatar(
  //         backgroundColor: bgColor,
  //         child: Image.asset(
  //           'assets/images/text.png',
  //           fit: BoxFit.cover,
  //           height: 40,
  //         ),
  //         radius: 40,
  //       ),
  //       CustomWidgets.getFittedBox(
  //         Text(
  //           text,
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Future<void> fetchAndSetTaxes() async {
    final dataList = await DBHelper.getData();
    setState(() {
      _taxes = dataList
          .map((tax) => {
                'tax_name': tax['name'],
                'country': tax['country'],
                'color':
                    Colors.primaries[Random().nextInt(Colors.primaries.length)],
                'tax_data': tax,
              })
          .toList();
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    // DBHelper.insert();
    _isLoading = true;
    fetchAndSetTaxes();
  }

  void searchTaxText() async {
    final searchResults =
        await DBHelper.getSearchedTax(_searchTextController.text);
    setState(() {
      _isSearchMode = true;
      _searchedTaxes = searchResults;
    });
  }

  void removeSearch() {
    setState(() {
      _isSearchMode = false;
      _searchedTaxes = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = CommonCode.getDeviceSize(context);

    final searchWidget = CustomWidgets.getSearchBar(
      _searchTextController,
      searchTaxText,
      removeSearch,
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
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: _isSearchMode
                  ? Container(
                      height: deviceSize.height,
                      width: deviceSize.width,
                      child: Column(
                        children: [
                          searchWidget,
                          _searchedTaxes.isEmpty
                              ? const Center(
                                  child: Text('NO SEARCH RESULTS'),
                                )
                              : Expanded(
                                  child: ListView.builder(
                                    itemCount: _searchedTaxes.length,
                                    itemBuilder: (ctx, index) {
                                      return Card(
                                        elevation: 5,
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 8,
                                          horizontal: 5,
                                        ),
                                        child: ListTile(
                                          leading: Image.asset(
                                            'assets/images/tax.png',
                                            fit: BoxFit.contain,
                                            height: 40,
                                          ),
                                          title: Text(
                                            _searchedTaxes[index]['name']
                                                .toString(),
                                            style: const TextStyle(
                                              fontSize: 24,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                        ],
                      ),
                    )
                  : Container(
                      height: deviceSize.height,
                      width: deviceSize.width,
                      child: Column(
                        children: [
                          searchWidget,
                          CustomWidgets.getSizedBox(
                            0.0,
                            deviceSize.height * 0.025,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomWidgets.getCircularIcons(
                                40,
                                text: 'Income Tax',
                                bgColor: Colors.green.shade300,
                                image: 'assets/images/text.png',
                              ),
                              CustomWidgets.getCircularIcons(
                                40,
                                text: 'GST',
                                bgColor: Colors.red.shade200,
                                image: 'assets/images/text.png',
                              ),
                              CustomWidgets.getCircularIcons(
                                40,
                                text: 'Services',
                                bgColor: Colors.blue.shade200,
                                image: 'assets/images/text.png',
                              ),
                            ],
                          ),
                          CustomWidgets.getSizedBox(
                            0.0,
                            deviceSize.height * 0.025,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomWidgets.getCircularIcons(
                                40,
                                text: 'Wealth Tax',
                                bgColor: Colors.purple.shade400,
                                image: 'assets/images/text.png',
                              ),
                              CustomWidgets.getCircularIcons(
                                40,
                                text: 'Co-orperate Tax',
                                bgColor: Colors.lightGreen.shade200,
                                image: 'assets/images/text.png',
                              ),
                              CustomWidgets.getCircularIcons(
                                40,
                                text: 'Business Tax',
                                bgColor: Colors.yellow.shade200,
                                image: 'assets/images/text.png',
                              ),
                            ],
                          ),
                          CustomWidgets.getSizedBox(
                            0.0,
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
                          CustomWidgets.getSizedBox(
                            0.0,
                            deviceSize.height * 0.025,
                          ),
                          SizedBox(
                            height: deviceSize.height * 0.3,
                            width: deviceSize.width,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _taxes.length,
                              itemBuilder: (ctx, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (ctx) => TaxDetailView(
                                          taxData: _taxes[index]['tax_data'],
                                        ),
                                      ),
                                    );
                                  },
                                  child: getTaxCard(
                                    deviceSize.width,
                                    deviceSize.height,
                                    _taxes[index]['country'].toString(),
                                    _taxes[index]['tax_name'].toString(),
                                    _taxes[index]['color'] as Color,
                                  ),
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
