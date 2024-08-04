import 'package:flutter/material.dart';
import 'package:quiz_app_working/widgets/quiz_page.dart';

class PyhtonQuestions extends StatelessWidget {
  const PyhtonQuestions({super.key});

  @override
  Widget build(BuildContext context) {
    return const QuizPage(
      category: 'Python',
      appBarTitle: 'Python Questions',
    );
  }
}
