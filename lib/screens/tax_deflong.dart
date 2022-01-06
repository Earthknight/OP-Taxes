import 'package:flutter/material.dart';
import 'package:taxes/widgets/TextWidget.dart';
import 'package:taxes/widgets/clippper.dart';
import 'package:taxes/widgets/fl_widget.dart';

import 'drawer.dart';

class TaxDeflong extends StatelessWidget {
  const TaxDeflong({Key? key}) : super(key: key);

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
                  children: const [
                    Clipper(),
                    Padding(
                      padding: EdgeInsets.only(top: 40,left: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        // ignore: prefer_const_constructors
                        child: MyText(
                          text: "Income Tax",
                          fontColor: Colors.white,
                          fontWeight: FontWeight.bold,
                          size: 20.0,
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
                                LongTerm_W().LongQuestion(),
                                LongTerm_W().LongAnswer(),
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
