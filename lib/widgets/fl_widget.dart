import 'package:flutter/material.dart';
import 'package:taxes/helpers/que_ans.dart';
import 'mytext.dart';

class LongTerm_W {
  Widget LongQuestion(){
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.only(left: 10,right:10,top: 15),
      margin: const EdgeInsets.only(left: 10,right: 10),
      child: MyText_lalu(QuesAns().questions, 17, const Color(0xff036D21), '', FontWeight.bold),
    );
  }
  Widget LongAnswer(){
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.only(left: 10,right:10,top: 15),
      margin: const EdgeInsets.only(left: 10,right: 10),
      child: MyText_lalu(QuesAns().answers, 16,Colors.black, '', FontWeight.w600)
    );
  }
}



