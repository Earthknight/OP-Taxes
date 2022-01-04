class QuesAns {
  Map<String, List<String>> ques_ans = {
    'questionText': ['What do you mean by Income Tax?'],
    'answers': [
      'An income tax is a tax imposed on individuals or entities in respect of the income or profits earned by them. Income tax generally is computed as the product of a tax rate times the taxable income.'
    ]
  };
  var questionIndex = 0;
  var answers;
  var questions;
  List<String>? questions_map;
  List<String>? answers_map;

  QuesAns() {
    questions_map = ques_ans['questionText'];
    answers_map = ques_ans['answers'];
    questions = questions_map![0];
    answers = answers_map![0];
  }
}

class ShortQuesAns {
  static const String tableFaq = 'trail';
  static const String colid = 'id';
  static const String colquestion = 'question';
  static const String colanswer = 'answer';
  int? id;
 final questions = [
    'What do you mean by Income Tax?',
    'What do you mean by Wealth Tax?',
    'What do you mean by Property Tax?',
  ];
  final answers = [
    'Income tax is a direct tax that a government levies on the income of its citizens.',
    'Wealth tax was a charge levied on the total or market value of personal assets',
    'Property tax is the annual amount paid by a land owner to the local government or the municipal corporation of his area.',
  ];

  ShortQuesAns();

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['question'] = questions;
    map['description'] = answers;
    return map;
  }
}
