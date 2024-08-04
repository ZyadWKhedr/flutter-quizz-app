import 'package:flutter/material.dart';
import 'package:quiz_app_working/constants.dart';
import 'package:quiz_app_working/models/db_connect.dart';
import 'package:quiz_app_working/models/questions_model.dart';
import 'package:quiz_app_working/widgets/QuestionWidget.dart';
import 'package:quiz_app_working/widgets/ResultBox.dart';
import 'package:quiz_app_working/widgets/optionsCard.dart';


class QuizPage extends StatefulWidget {
  final String category;
  final String appBarTitle;

  const QuizPage({
    Key? key,
    required this.category,
    required this.appBarTitle,
  }) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  int? _selectedOptionIndex;
  List<Questions> _questions = [];
  bool _isLoading = true;
  int? _correctOptionIndex;

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
  }

  Future<void> _fetchQuestions() async {
    final dbConnect = DbConnect();
    try {
      final questions = await dbConnect.fetchQuestions(widget.category);
      setState(() {
        _questions = questions;
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching questions: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _answerQuestion(int selectedIndex) {
    if (_selectedOptionIndex != null) return;

    final currentQuestion = _questions[_currentQuestionIndex];
    final correctIndex = currentQuestion.options.entries
        .toList()
        .indexWhere((entry) => entry.value);

    setState(() {
      _selectedOptionIndex = selectedIndex;
      _correctOptionIndex = correctIndex;
      if (currentQuestion.options.entries.toList()[selectedIndex].value) {
        _score++;
      }
    });

    Future.delayed(const Duration(milliseconds: 1000), () {
      if (_currentQuestionIndex < _questions.length - 1) {
        setState(() {
          _currentQuestionIndex++;
          _selectedOptionIndex = null;
          _correctOptionIndex = null;
        });
      } else {
        _showResultBox();
      }
    });
  }

  void _showResultBox() {
    showDialog(
      context: context,
      builder: (context) => ResultBox(
        result: _score,
        questionLength: _questions.length,
        onPressed: () {
          Navigator.of(context).pop();
          setState(() {
            _currentQuestionIndex = 0;
            _score = 0;
            _selectedOptionIndex = null;
            _correctOptionIndex = null;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          title: Text(widget.appBarTitle),
          backgroundColor: Colors.blueAccent,
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_questions.isEmpty) {
      return Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          title: Text(widget.appBarTitle),
          backgroundColor: Colors.blueAccent,
        ),
        body: const Center(child: Text('No questions available')),
      );
    }

    final currentQuestion = _questions[_currentQuestionIndex];

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text(widget.appBarTitle),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            QuestionWidget(
              question: currentQuestion.title,
              indexAction: _currentQuestionIndex,
              totalQuestions: _questions.length,
            ),
            const SizedBox(height: 20),
            ...currentQuestion.options.entries
                .toList()
                .asMap()
                .entries
                .map((entry) {
              final index = entry.key;
              final optionEntry = entry.value;
              final optionText = optionEntry.key;
              final isOptionSelected = _selectedOptionIndex == index;
              final isOptionCorrect = optionEntry.value;
              final isCorrectAnswer = _correctOptionIndex == index;

              return OptionsCard(
                option: optionText,
                isClicked: isOptionSelected,
                color: isOptionSelected
                    ? (isOptionCorrect
                        ? Colors.green
                        : Colors.red)
                    : (isCorrectAnswer && _selectedOptionIndex != null
                        ? Colors.green
                        : neutral),
                onTap: () {
                  if (_selectedOptionIndex == null) {
                    _answerQuestion(index);
                  }
                },
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
