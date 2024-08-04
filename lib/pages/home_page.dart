import 'package:flutter/material.dart';
import 'package:quiz_app_working/constants.dart';
import 'package:quiz_app_working/pages/cpp_questions.dart';
import 'package:quiz_app_working/pages/java_oop_quiz.dart';
import 'package:quiz_app_working/pages/java_quiz_page.dart';
import 'package:quiz_app_working/pages/javascript_question.dart';
import 'package:quiz_app_working/pages/pyhton_questions.dart';
import 'package:quiz_app_working/widgets/animated_question_icon.dart';
import 'package:quiz_app_working/widgets/category_tile.dart';
import 'package:quiz_app_working/widgets/drawer_tile.dart';

class HomePage extends StatefulWidget {
  final String userEmail;

  const HomePage({super.key, required this.userEmail});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> _categories = [];
  List<String> _filteredCategories = [];
  String _selectedCategoryType = 'Programming';

  @override
  void initState() {
    super.initState();
    _categories = _getInitialCategories();
    _filteredCategories = _categories;
  }

  void _filterCategories(String query) {
    setState(() {
      _filteredCategories = _categories
          .where((category) =>
              category.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  List<String> _getInitialCategories() {
    return [
      'Java simple questions',
      'Java OOP questions',
      'C++ Questions',
      'Python Questions',
      'JavaScript Questions'
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8.0,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  onChanged: _filterCategories,
                  decoration: InputDecoration(
                    hintText: 'Search categories...',
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    prefixIcon: Icon(Icons.search, color: Colors.grey[700]),
                  ),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  'Welcome to CodeQuiz',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const AnimatedQuestionIcon(),
              const SizedBox(height: 20),
              // Add "Explore Categories" text
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  'Explore Categories',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (_filteredCategories.isEmpty)
                const Center(
                  child: Text(
                    'No categories found.',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                )
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle('Programming'),
                    ..._filteredCategories.map((category) {
                      return _buildCategoryTile(
                        category,
                        _getImagePath(category),
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => _getQuizPage(category),
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryTile(
      String title, String imagePath, VoidCallback onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            title,
            style: const TextStyle(
              color: Color.fromARGB(255, 209, 209, 209),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        CategoryTile(
          onTap: onTap,
          imagePath: imagePath,
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String _getImagePath(String category) {
    switch (category) {
      case 'Java simple questions':
        return 'lib/assets/java.jpg';
      case 'Java OOP questions':
        return 'lib/assets/java.jpg';
      case 'C++ Questions':
        return 'lib/assets/cpp.jpg';
      case 'Python Questions':
        return 'lib/assets/python.png';
      case 'JavaScript Questions':
        return 'lib/assets/javascript2.jpg';
      default:
        return '';
    }
  }

  Widget _getQuizPage(String category) {
    switch (category) {
      case 'Java simple questions':
        return JavaQuizPage();
      case 'Java OOP questions':
        return JavaQuizOOPPage();
      case 'C++ Questions':
        return CppQuestions();
      case 'Python Questions':
        return const PyhtonQuestions();
      case 'JavaScript Questions':
        return JavascriptQuestion();
      default:
        return const SizedBox.shrink();
    }
  }
}
