import 'package:flutter/material.dart';
import 'package:taxes/widgets/mytext.dart';
import 'package:taxes/widgets/clipper.dart';
import 'package:taxes/widgets/fl_widget.dart';
class TaxDeflong extends StatelessWidget {
  const TaxDeflong({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Stack(children:[
                  Clipper(),
                  Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: MyText("Income Tax", 40, Colors.white, "Georgia",
                              FontWeight.bold))),
                ]),
                Expanded(
                  child: ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, int index) {
                        return  Align(
                          alignment: Alignment.center,
                          child: Column(children: [
                            LongTerm_W().LongQuestion(),
                            LongTerm_W().LongAnswer(),
                          ],)
                        );
                      }),
                ),
              ],
            )),
      ),
    );
  }
}
