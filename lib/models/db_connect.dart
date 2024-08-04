import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quiz_app_working/models/questions_model.dart';

class DbConnect {
  final String baseUrl = 'https://coderx-quizapp-default-rtdb.firebaseio.com';

  // Add a new question
  Future<void> addQuestion(Questions question) async {
    final Uri questionUrl =
        Uri.parse('$baseUrl/categories/${question.category}/questions.json');

    try {
      final response = await http.post(
        questionUrl,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'title': question.title,
          'options': question.options,
          'category': question.category,
        }),
      );

      if (response.statusCode == 200) {
        print('Question added successfully');
      } else {
        print('Failed to add question: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error adding question: $e');
    }
  }

  // Fetch questions for a specific category
  Future<List<Questions>> fetchQuestions(String category) async {
    final Uri questionUrl =
        Uri.parse('$baseUrl/categories/$category/questions.json');

    try {
      final response = await http.get(
        questionUrl,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        List<Questions> questions = [];

        data.forEach((key, value) {
          questions.add(
            Questions(
              id: key,
              title: value['title'],
              options: Map<String, bool>.from(value['options']),
              category: category,
            ),
          );
        });

        return questions;
      } else {
        print('Failed to fetch questions: ${response.statusCode}');
        print('Response body: ${response.body}');
        return [];
      }
    } catch (e) {
      print('Error fetching questions: $e');
      return [];
    }
  }
}
