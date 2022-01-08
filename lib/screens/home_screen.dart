import 'package:flutter/material.dart';
import '../widgets/custom_boxes.dart';
import '../widgets/custom_circular_icons.dart';
import '../widgets/custom_widgets.dart';
import '../widgets/custom_list_view_builder.dart';
import '../widgets/custom_tax_card.dart';
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
                                  child:
                                      CustomListViewBuilder.getListViewBuilder(
                                    _searchedTaxes.length,
                                    (ctx, index) {
                                      return Card(
                                        elevation: 5,
                                        margin:
                                            CommonCode.setMarginSymmteric(8, 5),
                                        child: ListTile(
                                          leading: Image.asset(
                                            'assets/images/tax.png',
                                            fit: BoxFit.contain,
                                            height: deviceSize.width * 0.1,
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
                          CustomBoxes.getSizedBox(
                            height: deviceSize.height * 0.025,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomCircularIcon.getCircularIcon(
                                deviceSize.width * 0.1,
                                text: 'Income Tax',
                                bgColor: Colors.green.shade300,
                                image: 'assets/images/text.png',
                              ),
                              CustomCircularIcon.getCircularIcon(
                                deviceSize.width * 0.1,
                                text: 'GST',
                                bgColor: Colors.red.shade200,
                                image: 'assets/images/text.png',
                              ),
                              CustomCircularIcon.getCircularIcon(
                                deviceSize.width * 0.1,
                                text: 'Services',
                                bgColor: Colors.blue.shade200,
                                image: 'assets/images/text.png',
                              ),
                            ],
                          ),
                          CustomBoxes.getSizedBox(
                            height: deviceSize.height * 0.025,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomCircularIcon.getCircularIcon(
                                deviceSize.width * 0.1,
                                text: 'Wealth Tax',
                                bgColor: Colors.purple.shade400,
                                image: 'assets/images/text.png',
                              ),
                              CustomCircularIcon.getCircularIcon(
                                deviceSize.width * 0.1,
                                text: 'Co-orperate Tax',
                                bgColor: Colors.lightGreen.shade200,
                                image: 'assets/images/text.png',
                              ),
                              CustomCircularIcon.getCircularIcon(
                                deviceSize.width * 0.1,
                                text: 'Business Tax',
                                bgColor: Colors.yellow.shade200,
                                image: 'assets/images/text.png',
                              ),
                            ],
                          ),
                          CustomBoxes.getSizedBox(
                            height: deviceSize.height * 0.025,
                          ),
                          const Text(
                            'Mostly Search',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          CustomBoxes.getSizedBox(
                            height: deviceSize.height * 0.025,
                          ),
                          CustomBoxes.getSizedBox(
                            height: deviceSize.height * 0.3,
                            width: deviceSize.width,
                            child: CustomListViewBuilder.getListViewBuilder(
                              _taxes.length,
                              (ctx, index) {
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
                                  child: CustomTaxCard.getTaxCard(
                                    deviceSize.width,
                                    deviceSize.height,
                                    _taxes[index]['country'].toString(),
                                    _taxes[index]['tax_name'].toString(),
                                    _taxes[index]['color'] as Color,
                                  ),
                                );
                              },
                              scrollAxis: Axis.horizontal,
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
    );
  }
}
