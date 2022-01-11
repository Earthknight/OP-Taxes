import 'package:get/get.dart';
import 'package:taxes/helpers/faq_database.dart';
import 'package:taxes/models/que_ans.dart';
class TaxdefController extends GetxController{
  List traillong = <dynamic>[].obs;
  List trailshort = <dynamic>[].obs;
  String showlongquery ='longqtrails';
  String showshortquery ='faqstrails';
  var valuelong1 =  LongQuesAns().questionText;
  var valuelong2 = LongQuesAns().answersText;
  var valueshort1 =  ShortQuesAns().questions;
  var valueshort2 = ShortQuesAns().answers;
  @override
  Future<dynamic> fetchFAQTaxes() async {
    await Future.delayed(Duration(seconds: 1));
    final dataList = await DBProvider.db.getSmallData();
    trailshort = dataList
        .map((trailshort) => {
      'id': trailshort['id'],
      'questions':trailshort['questions'],
      'answers': trailshort['answers'],
    }).toList();
    return trailshort;
  }
  Future<dynamic> fetchLongTaxes() async {
    await Future.delayed(Duration(seconds: 1));
    final dataList = await DBProvider.db.getLongData();
    traillong = dataList
        .map((traillong) => {
      'id': traillong['id'],
      'questions': traillong['questions'],
      'answers': traillong['answers'],
    }).toList();
    return traillong;
  }
  void onInit() {
    fetchLongTaxes();
    // DBProvider.db.insert(showlongquery,valuelong1,valuelong2);
    // DBProvider.db.insert(showshortquery,valueshort1,valueshort2);
    fetchFAQTaxes();
    // fetchLongTaxes();
    super.onInit();
    update();
  }
}
