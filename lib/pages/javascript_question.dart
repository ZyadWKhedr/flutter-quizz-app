import 'package:flutter/material.dart';
import 'package:quiz_app_working/widgets/quiz_page.dart';

class JavascriptQuestion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return QuizPage(
      category: 'JavaScript',
      appBarTitle: 'JavaScript Questions',
    );
  }
}
