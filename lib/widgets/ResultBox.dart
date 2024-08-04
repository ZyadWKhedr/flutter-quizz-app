import 'package:flutter/material.dart';
import 'package:quiz_app_working/constants.dart';

class ResultBox extends StatelessWidget {
  const ResultBox({
    super.key,
    required this.result,
    required this.questionLength,
    required this.onPressed,
  });

  final int result;
  final int questionLength;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: background,
      content: Padding(
        padding: const EdgeInsets.all(70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Score',
              style: TextStyle(color: neutral, fontSize: 22),
            ),
            const SizedBox(
              height: 20,
            ),
            CircleAvatar(
              radius: 70,
              child: Text(
                '$result/$questionLength',
                style: TextStyle(fontSize: 30),
              ),
              backgroundColor: result == questionLength / 2
                  ? Colors.yellow
                  : result < questionLength / 2
                      ? inCorrect
                      : correct,
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              result == questionLength / 2
                  ? 'Almost there'
                  : result < questionLength / 2
                      ? 'Try Again'
                      : "Excellent!",
              style: TextStyle(color: neutral, fontSize: 18),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: onPressed,
              child: const Text(
                'Start Over',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
