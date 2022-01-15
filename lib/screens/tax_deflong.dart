import 'package:flutter/material.dart';
import 'package:taxes/controllers/taxdef_controller.dart';
import 'package:taxes/widgets/TextWidget.dart';
import 'package:taxes/widgets/clippper.dart';
import 'package:taxes/widgets/fl_widget.dart';
import 'drawer.dart';
import 'package:get/get.dart';
// ignore: must_be_immutable
class TaxDeflong extends StatelessWidget {
  int index;
  TaxDeflong(this.index);

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
                          text: taxList[index],
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
                  child: GetBuilder<TaxdefController>(
                      init: TaxdefController(),
                      builder: (controller2) {
                        return ListView.builder(
                            itemCount: 1,
                            itemBuilder: (context, int i){
                              return Align(
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      LongTerm_W().LongQuestion(controller2.traillong[index]['questions']),
                                      LongTerm_W().LongAnswer(controller2.traillong[index]['answers']),
                                    ],
                                  ));
                            });
                      }
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
