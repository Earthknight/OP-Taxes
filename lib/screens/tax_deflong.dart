import 'package:flutter/material.dart';
import 'package:taxes/widgets/TextWidget.dart';
import 'package:taxes/widgets/clippper.dart';
import 'package:taxes/widgets/fl_widget.dart';
import 'drawer.dart';

// ignore: must_be_immutable
class TaxDeflong extends StatelessWidget {
  String questions;
  String answers;
  int index;
  TaxDeflong(this.questions,this.answers,this.index);
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
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 40,left: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: MyText(
                            text: taxList[index],
                            fontColor: Colors.white,
                            fontWeight: FontWeight.bold,
                            size: 18.0,
                            lines: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, int index) {
                        return Align(
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                LongTerm_W().LongQuestion(questions.toString()),
                                LongTerm_W().LongAnswer(answers.toString()),
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
