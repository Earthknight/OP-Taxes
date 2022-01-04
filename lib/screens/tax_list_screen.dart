import 'package:flutter/material.dart';
import 'package:taxes/widgets/TextWidget.dart';
import 'package:taxes/widgets/clippper.dart';
import 'package:taxes/widgets/sizedBoxWidget.dart';

import 'drawer.dart';


class TaxType extends StatefulWidget{
  State<StatefulWidget> createState() {
    return TaxTypeState();
  }
}

class TaxTypeState extends State<TaxType> {

  List<String> TaxTypes = ["Income Tax", "Capital Gains" ,"Security \nTransaction \nTax", "Prerequisite Tax",
  "Cooperate Tax", "GST", "Property Tax", "Professional Tax", "Entertainment Tax",
  "Registration Tax", "Education Cess", "Entry Tax", "Road Tax", "Toll Tax",
    "Custom Duty", "Excise Duty"];

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
                Stack(children: [
                  Clipper(),
                  Positioned(top: 50, right: 90,
                      child: Row(
                        children: [
                          Text(
                            'Tax Types',
                            style: TextStyle(
                              fontSize: 55.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Icon(
                           Icons.calculate,
                            size: 55.0,
                            color: Colors.white,
                          ),
                        ],
                      )),
                ]),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    child:GridView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: ScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20.0,
                            mainAxisSpacing: 20.0
                        ),
                        itemCount: TaxTypes.length,
                        itemBuilder: (context, int index) {
                          return gridItem(TaxTypes[index]);
                        }),
                  ),
                ),
              ],
            )),
      ),
    );
  }
  Widget gridItem(String gridItemText){
    return MySizedBox(
      height: 150.0,
      width: 150.0,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 20,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left:3.0, right: 3.0),
          child: Center(
            child: MyText(
              text: gridItemText,
              fontColor: Colors.black,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
              size: 20.0,
            )
          ),
        ),
      ),
    );
  }
}
