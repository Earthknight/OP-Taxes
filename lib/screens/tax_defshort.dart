import 'package:flutter/material.dart';
import 'package:taxes/widgets/TextWidget.dart';
import 'package:taxes/widgets/clippper.dart';
import 'package:taxes/helpers/faq_database.dart';
import 'package:taxes/widgets/st_widget.dart';
import 'drawer.dart';

class TaxDef extends StatefulWidget {
  const TaxDef({Key? key}) : super(key: key);

  @override
  State<TaxDef> createState() => _TaxDefState();
}

class _TaxDefState extends State<TaxDef> {
  // var _isLoading = false;
  List _trail = [];

  @override
  Future<void> fetchTaxes() async {
    final dataList = await DatabaseHelper.getData();
    setState(() {
      _trail = dataList
          .map((trail) => {
                'id': trail['id'],
                'questions': trail['questions'],
                'answers': trail['answers'],
              })
          .toList();
    });
  }

  @override
  void initState() {
    DatabaseHelper.insert();
    super.initState();
    // _isLoading = true;
    fetchTaxes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      drawer: DrawerWidget(context),
      body: SafeArea(
        child: Container(
            color: Colors.white,
            child: Column(
              children: [
                const SizedBox(
                  height: 00,
                ),
                Stack(children: const [
                  Clipper(),
                  Padding(
                    padding: EdgeInsets.only(top: 40, left: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: MyText(
                        text: "FAQ",
                        fontColor: Colors.white,
                        fontWeight: FontWeight.bold,
                        size: 60.0,
                      ),
                    ),
                  ),
                ]),
                Expanded(
                  child: ListView.builder(
                      itemCount: _trail.length,
                      itemBuilder: (context, int index) {
                        return Align(
                            alignment: Alignment.center,
                            child: ShortTerm_W(_trail[index]['questions'],
                                _trail[index]['answers']));
                      }),
                ),
              ],
            )),
      ),
    );
  }
}
