import 'package:flutter/material.dart';
import 'package:taxes/screens/tax_deflong.dart';
import 'package:taxes/widgets/TextWidget.dart';
import 'package:taxes/widgets/clippper.dart';
import 'package:taxes/widgets/sizedBoxWidget.dart';
import 'drawer.dart';

class TaxType extends StatefulWidget {
  final List<String> taxList;

  const TaxType({Key? key, required this.taxList}) : super(key: key);

  State<StatefulWidget> createState() {
    return TaxTypeState();
  }
}

class TaxTypeState extends State<TaxType> {
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
                  Positioned(
                      top: 50,
                      right: 150,
                      child: Row(
                        children: const[
                          MyText(
                            text: "Taxes",
                            fontColor: Colors.white,
                            fontWeight: FontWeight.bold,
                            size: 25.0,
                          ),
                          // Text(
                          //   'Tax Types',
                          //   style: TextStyle(
                          //     fontSize: 55.0,
                          //     fontWeight: FontWeight.bold,
                          //     color: Colors.white,
                          //   ),
                          // ),
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
                    child: GridView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: ScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20.0,
                            mainAxisSpacing: 20.0),
                        itemCount: taxList.length,
                        itemBuilder: (context, int index) {
                          return gridItem(taxList[index], index);
                        }),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget gridItem(String gridItemText, int index) {
    return InkWell(
      child: MySizedBox(
        height: 150.0,
        width: 150.0,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 20,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 3.0, right: 3.0),
            child: Center(
                child: MyText(
              text: gridItemText,
              fontColor: Colors.black,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
              size: 10.0,
              lines: 3,
            )),
          ),
        ),
      ),
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(builder: (context) => TaxDeflong(index)),
        );
      },
    );
  }
}
