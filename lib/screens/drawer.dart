import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxes/screens/select_country_screen.dart';
import 'package:taxes/screens/tax_list_screen.dart';
import 'package:taxes/widgets/AppBarWidget.dart';
import 'package:taxes/widgets/IconWidget.dart';
import 'package:taxes/widgets/ListTileWidget.dart';
import 'package:taxes/widgets/TextWidget.dart';
import 'package:taxes/widgets/sizedBoxWidget.dart';
import 'home_screen.dart';



List<String> taxList = ["Income Tax", "Capital Gains" ,"Security Transaction Tax", "Prerequisite Tax",
  "Cooperate Tax", "GST", "Property Tax", "Professional Tax", "Entertainment Tax",
  "Registration Tax", "Education Cess", "Entry Tax", "Road Tax", "Toll Tax",
  "Custom Duty", "Excise Duty"];

class DrawerScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      drawer: DrawerWidget(context),
      body: Container(
        child: HomeScreen(),
      ),
    );
  }
}

PreferredSizeWidget AppBarWidget() {
  return PreferredSize(
    preferredSize: Size.fromHeight(60),
    child: MyAppBar(
      text: "OP Taxes",
      actions: [
        MySizedBox(
          width: 5.0,
        ),
        MyIcon(
          icon: Icons.account_circle_rounded,
        ),
        MySizedBox(
          width: 5.0,
        ),
      ],
      bgColor: Color(0xff03541A),
    ),
  );
}

Widget DrawerWidget(BuildContext context) {

  return Drawer(
      child: SingleChildScrollView(
        child: ListView(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xff028A28),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MyIcon(
                    icon: Icons.account_circle_rounded,
                    size: 60.0,
                  ),
                  MySizedBox(
                    height: 20.0,
                  ),
                  MyText(
                    text: "Hi, User",
                    textScaleFactor: 1.5,
                    size: 17.0,
                    fontColor: Colors.white,
                    fontWeight: FontWeight.w800,
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
            MyListTile(
                title: const MyText(
                  text: "About Taxes",
                  fontColor: Color(0xff028A28),
                  fontWeight: FontWeight.bold,
                ),
                ontap: () {
                  Navigator.of(context, rootNavigator: true).push(
                    MaterialPageRoute(builder: (context) => TaxType(taxList: taxList,)),
                  );
                }),
            MyListTile(
                title: const MyText(
                  text: "Taxes Acc To Country",
                  fontColor: Color(0xff028A28),
                  fontWeight: FontWeight.bold,
                ),
                ontap: () {
                  Navigator.of(context, rootNavigator: true).push(
                    MaterialPageRoute(builder: (context) => SelectCountry()),
                  );
                }),
            const MyListTile(
              title: MyText(
                text: "FAQ",
                fontColor: Color(0xff028A28),
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(color: Colors.black),
            ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: ScrollPhysics(),
                itemCount: taxList.length,
                itemBuilder: (BuildContext context, int index) {
                  return MyListTile(
                    title: MyText(
                      text: taxList[index],
                      fontColor: Colors.grey,
                      lines: 0,
                    ),
                  );
                })
          ],
        ),
      ));
}
