import 'package:flutter/material.dart';
import 'package:taxes/helpers/faq_database.dart';
import 'package:taxes/models/que_ans.dart';
import 'package:taxes/widgets/TextWidget.dart';
import 'package:taxes/widgets/clippper.dart';
import 'package:taxes/widgets/fl_widget.dart';
import 'drawer.dart';

// ignore: must_be_immutable
class TaxDeflong extends StatefulWidget {
  int index;
  TaxDeflong(this.index);

  @override
  State<TaxDeflong> createState() => _TaxDeflongState();
}

class _TaxDeflongState extends State<TaxDeflong> {

  List traillong = [];

  String showquery ='longtrails';
  var  value1 =  LongQuesAns().questionText;
  var value2 = LongQuesAns().answersText;
  int list =1;
  @override
  Future<void> fetchBigTaxes() async {
    final dataList = await DBProvider.db.getLongData();
    setState(() {
      traillong = dataList
          .map((traillong) => {
        'id': traillong['id'],
        'questions': traillong['questions'],
        'answers': traillong['answers'],
      }).toList();
    });
  }
  @override
  void initState(){
    // DBProvider.db.insert(showquery,value1,value2);
    super.initState();
    fetchBigTaxes();
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
                Stack(
                  children: [
                    const Clipper(),
                    Padding(
                        padding: const EdgeInsets.only(top: 40,left: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: MyText(
                            text: taxList[widget.index],
                            fontColor: Colors.white,
                            fontWeight: FontWeight.bold,
                            size: 18.0,
                            lines: 20,
                          ),
                        ),
                      ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, int index){
                        return Align(
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                LongTerm_W().LongQuestion(traillong[widget.index]['questions']),
                                LongTerm_W().LongAnswer(traillong[widget.index]['answers']),
                              ],
                            ));
                      }),
                ),
              ],
            )),
      ),
    );
  }
}
