import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxes/screens/select_country_screen.dart';


class DrawerScreen extends StatelessWidget {

   @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBarWidget(),
      drawer: DrawerWidget(context),
      body: Container(

      ),

    );
  }

}
Widget AppBarWidget(){
  return AppBar(
    title: Text("OP : Taxes"),
    actions: <Widget>[
      IconButton(
          icon: const Icon(Icons.account_circle_rounded,
              color: Colors.white, size: 35),
          onPressed: (){}
      )
    ],
  );
}

Widget DrawerWidget(BuildContext context){
  List<String> TaxesList = ["Income Tax", "Service Tax", "Cooperate Tax", "Inheritance Tax", "Wealth Tax", "Custom of Duty", "GST", "VAT"];
  return Drawer(
      child:Container
        (
          child: Expanded(
            child: ListView(
              shrinkWrap :  true,
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
                    children: const <Widget>[
                      Icon(Icons.account_circle_rounded,
                          color: Colors.white, size: 60),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text("Hi, User",
                        textScaleFactor: 1.5,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.w800,
                        ),
                        textAlign: TextAlign.center,)
                    ],
                  ),
                ),

                ListTile(
                  title: Text("About Taxes",
                    style: TextStyle(
                      color: Color(0xff028A28),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                    title: Text("Taxes Acc To Country",
                      style: TextStyle(
                        color: Color(0xff028A28),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(builder: (context) => SelectCountry()),
                      );
                    }

                ),
                ListTile(
                  title: Text("FAQ",
                    style: TextStyle(
                      color: Color(0xff028A28),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Divider(
                    color: Colors.black
                ),

                Expanded(
                  child: Column(
                    children: [
                      ListView.builder(
                            shrinkWrap: true,
                            scrollDirection : Axis.vertical,
                            physics: ScrollPhysics(),
                            itemCount: TaxesList.length,
                            itemBuilder: (BuildContext context, int index){
                              return  ListTile(
                                title: Text(TaxesList[index],
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              );
                            }
                        ),
                      
                    ],),
                )

              ],
            ),))
  );
}
