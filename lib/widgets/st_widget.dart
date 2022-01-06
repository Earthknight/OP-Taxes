import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'TextWidget.dart';



class ShortTerm_W extends StatelessWidget {
  final String TextH;
  final String TextE;
  ShortTerm_W(this.TextH,this.TextE);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10,right:10,top: 15),
      margin: const EdgeInsets.only(left: 10,right: 10,top: 15),
      decoration:  BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.black38,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpandablePanel(
        header: MyText(
          text: TextH,
          fontColor:Color(0xff036D21),
          fontWeight: FontWeight.bold,
          size: 6,
          lines: 2,
        ),
        expanded: MyText(
          text: TextE,
          fontColor:Colors.black,
          fontWeight: FontWeight.w500,
          size: 3,
          lines: 5,
        ), collapsed: Text(''),
      ),
    );
  }
}

// Container(
// padding: const EdgeInsets.only(
// left: 10, right: 10, top: 15),
// margin: const EdgeInsets.all(10),
// decoration: BoxDecoration(
// color: Colors.white,
// border: Border.all(
// color: Colors.black38,
// width: 1,
// ),
// borderRadius: BorderRadius.circular(12),
// ),
// child: ExpandablePanel(
// header: MyText(_trail[index]['questions'], 17,
// Color(0xff036D21), '', FontWeight.bold),
// expanded: MyText(_trail[index]['answers'], 15,
// Colors.black, '', FontWeight.w600),
// collapsed: Text(''),
// ),
// )