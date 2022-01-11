import 'dart:async';

import 'package:flutter/material.dart';
import 'package:taxes/models/que_ans.dart';
import 'package:taxes/widgets/TextWidget.dart';
import 'package:taxes/widgets/clippper.dart';
import 'package:taxes/helpers/faq_database.dart';
import 'package:taxes/widgets/st_widget.dart';
import 'drawer.dart';

class TaxDef extends StatefulWidget {
  @override
  State<TaxDef> createState() => _TaxDefState();
}

class _TaxDefState extends State<TaxDef> {
  List _trail = [];
  String showquery = 'faqstrails';
  var value1 = ShortQuesAns().questions;
  var value2 = ShortQuesAns().answers;

  @override
  Future<void> fetchSmallTaxes() async {
    final dataList = await DBProvider.db.getSmallData();
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
    DBProvider.db.insert(showquery,value1,value2);
    super.initState();
    fetchSmallTaxes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff036D21),
        title: const Padding(
          padding: EdgeInsets.only(left: 60),
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
                Stack(
                  children: const [
                    Clipper(),
                    Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: MyText(
                          text: "FAQ",
                          fontColor: Colors.white,
                          fontWeight: FontWeight.bold,
                          size: 60.0,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: _trail.length,
                        itemBuilder: (context, int index) {
                          return Align(
                              alignment: Alignment.center,
                              child: ShortTerm_W(_trail[index]['questions'],
                                  _trail[index]['answers']));
                        })
                    ),
              ],
            )),
      ),
    );
  }
}
