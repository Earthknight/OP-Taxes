import 'package:flutter/material.dart';
import 'package:taxes/helpers/que_ans.dart';
import 'TextWidget.dart';

class LongTerm_W {
  Widget LongQuestion(){
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.only(left: 10,right:10,top: 15),
      margin: const EdgeInsets.only(left: 10,right: 10),
      child:  MyText(
        text: QuesAns().questions,
        fontColor:const Color(0xff036D21),
        fontWeight:FontWeight.bold,
        size: 6,
        lines: 5,
      ),
    );
  }
  Widget LongAnswer(){
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.only(left: 10,right:10,top: 15),
      margin: const EdgeInsets.only(left: 10,right: 10),
      child: MyText(
        text: QuesAns().answers,
        fontColor:Colors.black,
        fontWeight: FontWeight.w500,
        size: 3,
        lines: 20,
      ),
    );
  }
}



