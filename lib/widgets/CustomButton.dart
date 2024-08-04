import 'package:flutter/material.dart';
import 'package:quiz_app_working/constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.nextQuestion});

  final VoidCallback nextQuestion;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: nextQuestion,
      child: Container(
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
          color: neutral,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            'Next Question',
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
