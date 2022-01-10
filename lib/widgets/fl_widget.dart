import 'package:flutter/material.dart';
import 'package:taxes/models/que_ans.dart';
import 'TextWidget.dart';

class LongTerm_W {
  Widget LongQuestion(String questions){
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.only(left: 10,right:10,top: 15),
      margin: const EdgeInsets.only(left: 10,right: 10),
      child:  MyText(
        text: questions,
        fontColor:const Color(0xff036D21),
        fontWeight:FontWeight.bold,
        size: 6,
        lines: 5,
      ),
    );
  }
  Widget LongAnswer(String answers){
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.only(left: 10,right:10,top: 15),
      margin: const EdgeInsets.only(left: 10,right: 10),
      child: MyText(
        text: answers,
        fontColor:Colors.black,
        fontWeight: FontWeight.w500,
        size: 3,
        lines: 20,
      ),
    );
  }
}



