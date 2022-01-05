import 'package:flutter/material.dart';
import 'package:taxes/widgets/clippper.dart';
import 'package:taxes/widgets/mytext.dart';
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
      appBar: AppBar(
        backgroundColor: const Color(0xff036D21),
        title: const Padding(
          padding:EdgeInsets.only(left: 60),
          child: Text('0P:Taxes'),
        ),
      ),
      drawer: DrawerWidget(context),
      body: SafeArea(
        child: Container(
            color: Colors.white,
            child: Column(
              children: [
                const SizedBox(
                  height: 00,
                ),
                Stack(children: [
                  const Clipper(),
                  Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: MyText_lalu("FAQ", 60, Colors.white, "Georgia",
                              FontWeight.bold))),
                ]),
                Expanded(
                  child: ListView.builder(
                      itemCount: _trail.length,
                      itemBuilder: (context, int index) {
                        return Align(
                            alignment: Alignment.center,
                            child: ShortTerm_W(_trail[index]['questions'],_trail[index]['answers']));
                      }),
                ),
              ],
            )),
      ),
    );
  }
}
