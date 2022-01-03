import 'package:flutter/material.dart';
import 'package:taxes/widget/clippper.dart';
import 'drawer.dart';

class TaxType extends StatefulWidget{
  State<StatefulWidget> createState() {
    return TaxTypeState();
  }
}

class TaxTypeState extends State<TaxType> {

  List<String> TaxTypes = ["Income Tax", "Capital Gains" ,"Security Transaction Tax", "Prerequisite Tax",
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
                        physics: NeverScrollableScrollPhysics(),
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
    return SizedBox(
      height: 150.0,
      width: 150.0,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 20,
        color: Colors.white,
        child: Center(
          child: Text(
            gridItemText,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
            ),
          ),
        ),
      ),
    );
  }
}
