import 'package:flutter/material.dart';
import 'package:quiz_app_working/widgets/quiz_page.dart';

class CppQuestions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return QuizPage(
      category: 'Cpp',
      appBarTitle: 'C++ Questions',
    );
  }
}
