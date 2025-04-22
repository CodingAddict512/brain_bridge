import 'package:brain_bridge_update/Quizes/c++_quiz.dart';
import 'package:brain_bridge_update/Quizes/flutter_quiz.dart';
import 'package:brain_bridge_update/Quizes/laravel_quiz.dart';
import 'package:brain_bridge_update/Quizes/pyhton_quiz.dart';
import 'package:brain_bridge_update/Quizes/reactnative_quiz.dart';
import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  // Dropdown values for language selection
  final List<String> languages = [
    'Flutter',
    'C++',
    'Python',
    'Laravel',
    'React Native'
  ];

  String selectedLanguage = 'Flutter'; // Default language selection

  int currentQuestionIndex = 0; // Tracks the current question
  List<int?> userAnswers = []; // Stores user's selected answers
  late List<Map<String, dynamic>> currentQuiz; // Stores the current quiz data

  @override
  void initState() {
    super.initState();
    // Set the initial quiz data based on the selected language
    currentQuiz = flutterQuiz; // Default to Flutter quiz
    userAnswers = List.filled(currentQuiz.length, null);
  }

  void loadQuizData() {
    switch (selectedLanguage) {
      case 'C++':
        currentQuiz = cppQuiz;
        break;
      case 'Python':
        currentQuiz = pythonQuiz;
        break;
      case 'Laravel':
        currentQuiz = laravelQuiz;
        break;
      case 'React Native':
        currentQuiz = reactnativeQuiz;
        break;
      case 'Flutter':
      default:
        currentQuiz = flutterQuiz;
        break;
    }
    // Reset quiz state when language changes
    setState(() {
      currentQuestionIndex = 0;
      userAnswers = List.filled(currentQuiz.length, null);
    });
  }

  void goToNextQuestion() {
    if (currentQuestionIndex < currentQuiz.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    }
  }

  void goToPreviousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
      });
    }
  }

  void submitQuiz() {
    int score = 0;

    // Loop through all questions to check if the answer is correct
    for (int i = 0; i < currentQuiz.length; i++) {
      if (userAnswers[i] != null &&
          userAnswers[i] == currentQuiz[i]['correctAnswer']) {
        score++; // Increment score if the answer is correct
      }
    }

    // Show score in the dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Quiz Completed'),
        content: Text(
            'You answered $score/${currentQuiz.length} questions correctly.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var currentQuestion = currentQuiz[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Screen'),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.cyan],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Dropdown for language selection
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 3,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: DropdownButton<String>(
                    value: selectedLanguage,
                    isExpanded: true,
                    items: languages.map((String language) {
                      return DropdownMenuItem<String>(
                        value: language,
                        child: Text(language),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedLanguage = newValue!;
                      });
                      loadQuizData(); // Reload quiz data when language changes
                    },
                  ),
                ),
                const SizedBox(height: 20),

                // Display current question and options
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Question ${currentQuestionIndex + 1} of ${currentQuiz.length}',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        currentQuestion['question'],
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 10),

                      // Display options dynamically
                      Column(
                        children: List.generate(
                          currentQuestion['options'].length,
                          (index) {
                            return RadioListTile<int>(
                              value: index,
                              groupValue: userAnswers[currentQuestionIndex],
                              onChanged: (value) {
                                setState(() {
                                  userAnswers[currentQuestionIndex] = value;
                                });
                              },
                              title: Text(currentQuestion['options'][index]),
                            );
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (currentQuestionIndex > 0)
                            ElevatedButton(
                              onPressed: goToPreviousQuestion,
                              child: const Text('Back'),
                            ),
                          if (currentQuestionIndex < currentQuiz.length - 1)
                            ElevatedButton(
                              onPressed:
                                  userAnswers[currentQuestionIndex] != null
                                      ? goToNextQuestion
                                      : null,
                              child: const Text('Next'),
                            ),
                          if (currentQuestionIndex == currentQuiz.length - 1)
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 100, vertical: 15),
                              ),
                              onPressed:
                                  userAnswers[currentQuestionIndex] != null
                                      ? submitQuiz
                                      : null,
                              child: const Text(
                                'Submit',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
