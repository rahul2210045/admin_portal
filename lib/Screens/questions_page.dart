// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Widgets/Custom_Container.dart'; // Adjust path as per your project structure
import '../Widgets/questions_sidebar.dart'; // Import the updated QuestionsSidebar widget
import '../components/questions_area.dart'; // Adjust path as per your project structure
import '../constants/constants.dart'; // Adjust path as per your project structure
import 'package:http/http.dart' as http;

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({Key? key}) : super(key: key);

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int selectedIndex = 0; // Track selected tab index
  int selectedQuestionIndex = 0; // Track selected question index
  bool _editMode = false; // Track edit mode
  final TextEditingController _categoryController = TextEditingController();

  // Data for questions and answers
  Map<String, List<String>> questions = {
    'HTML': [
      'What is the full form of HTML?',
      'What is the purpose of HTML?',
      'What are HTML elements?',
    ],
    'SQL': [
      'What is SQL used for?',
      'What are the types of SQL statements?',
      'Explain SQL SELECT statement.',
      'What is a SQL JOIN?',
      'Explain SQL indexing.',
      'What is the difference between SQL and NoSQL?',
      'Explain ACID properties in SQL databases.',
    ],
    'CSS': [
      'What is CSS?',
      'What are CSS selectors?',
      'Explain CSS box model.',
    ],
  };

  Map<String, List<List<String>>> options = {
    'HTML': [
      ['Option A', 'Option B', 'Option C', 'Option D'],
      ['Option A', 'Option B', 'Option C', 'Option D'],
      ['Option A', 'Option B', 'Option C', 'Option D'],
    ],
    'SQL': [
      ['Option A', 'Option B', 'Option C', 'Option D'],
      ['Option A', 'Option B', 'Option C', 'Option D'],
      ['Option A', 'Option B', 'Option C', 'Option D'],
      ['Option A', 'Option B', 'Option C', 'Option D'],
      ['Option A', 'Option B', 'Option C', 'Option D'],
      ['Option A', 'Option B', 'Option C', 'Option D'],
      ['Option A', 'Option B', 'Option C', 'Option D'],
    ],
    'CSS': [
      ['Option A', 'Option B', 'Option C', 'Option D'],
      ['Option A', 'Option B', 'Option C', 'Option D'],
      ['Option A', 'Option B', 'Option C', 'Option D'],
    ],
  };

  Map<String, List<String>> correctAnswers = {
    'HTML': ['Option A', 'Option B', 'Option C'],
    'SQL': [
      'Option A',
      'Option B',
      'Option C',
      'Option D',
      'Option A',
      'Option B',
      'Option C',
    ],
    'CSS': ['Option A', 'Option B', 'Option C'],
  };

  Map<String, List<String>> explanations = {
    'HTML': [
      'HTML stands for HyperText Markup Language.',
      'HTML is used for creating structured documents.',
      'HTML elements are building blocks of HTML pages.',
    ],
    'SQL': [
      'SQL is used for managing data in a relational database.',
      'Types include DDL, DML, DCL, TCL.',
      'SELECT statement retrieves data from a database.',
      'JOIN combines rows from two or more tables.',
      'Indexing improves data retrieval speed.',
      'SQL is relational, NoSQL is non-relational.',
      'ACID stands for Atomicity, Consistency, Isolation, Durability.',
    ],
    'CSS': [
      'CSS stands for Cascading Style Sheets.',
      'Selectors target specific HTML elements.',
      'Box model describes layout of elements.',
    ],
  };

  List<String> get currentQuestions {
    String category = tabs[selectedIndex];
    return questions[category] ?? [];
  }

  List<List<String>> get currentOptions {
    String category = tabs[selectedIndex];
    return options[category] ?? [[]];
  }

  List<String> get currentCorrectAnswers {
    String category = tabs[selectedIndex];
    return correctAnswers[category] ?? [];
  }

  List<String> get currentExplanations {
    String category = tabs[selectedIndex];
    return explanations[category] ?? [];
  }

  void updateQuestionIndex(int index) {
    setState(() {
      selectedQuestionIndex = index;
    });
  }

  Future<void> deleteQuestionApi(String quesId) async {
    var url = Uri.parse('http://localhost:3000/admin/deleteQuestion');
    var request = http.Request('POST', url);

    request.body = jsonEncode({
      'quesId': quesId,
    });

    request.headers.addAll({
      'Content-Type': 'application/json',
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      print(responseBody);
    } else {
      print(response.reasonPhrase);
    }
  }

  void deleteQuestion(int index) {
    setState(() {
      String category = tabs[selectedIndex];
      if (index >= 0 && index < currentQuestions.length) {
        questions[category]?.removeAt(index);
        options[category]?.removeAt(index);
        correctAnswers[category]?.removeAt(index);
        explanations[category]?.removeAt(index);
        if (selectedQuestionIndex == index) {
          selectedQuestionIndex = 0;
        } else if (selectedQuestionIndex > index) {
          selectedQuestionIndex--;
        }
      }
      ;
      deleteQuestionApi('201');
    });
  }

  void saveQuestions(List<String> updatedQuestions) {
    // Not implemented in this example
  }

  void addNewQuestion() {
    setState(() {
      String category = tabs[selectedIndex];
      questions[category]?.add('New Question');
      options[category]?.add(['Option A', 'Option B', 'Option C', 'Option D']);
      correctAnswers[category]?.add('Option A');
      explanations[category]?.add('New Explanation');
      selectedQuestionIndex = currentQuestions.length - 1;
    });
  }

  void addNewCategory(String category) {
    setState(() {
      tabs.insert(tabs.length - 1, category);
      questions[category] = [];
      options[category] = [];
      correctAnswers[category] = [];
      explanations[category] = [];
    });
  }

  void navigateToDownloadPage() {
    // Not implemented in this example
  }

  List<String> tabs = [
    "HTML",
    "SQL",
    "CSS",
    "Add+"
  ]; // Assuming you have tabs corresponding to questions

  @override
  Widget build(BuildContext context) {
    double heightFactor = MediaQuery.of(context).size.height / 1024;
    double widthFactor = MediaQuery.of(context).size.width / 1440;

    return Scaffold(
      backgroundColor: backgroundColor1,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10 * widthFactor),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: CustomRoundedContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10 * heightFactor),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (int index = 0; index < tabs.length; index++)
                              SizedBox(
                                width: widthFactor * 127,
                                height: heightFactor * 51,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (tabs[index] == 'Add+') {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Add New Category'),
                                            content: TextField(
                                              controller: _categoryController,
                                              decoration: InputDecoration(
                                                  hintText: "Category Name"),
                                            ),
                                            actions: [
                                              TextButton(
                                                child: Text('Cancel'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              TextButton(
                                                child: Text('Add'),
                                                onPressed: () {
                                                  String newCategory =
                                                      _categoryController.text
                                                          .trim();
                                                  if (newCategory.isNotEmpty) {
                                                    addNewCategory(newCategory);
                                                    _categoryController.clear();
                                                    Navigator.of(context).pop();
                                                  }
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    } else {
                                      setState(() {
                                        selectedIndex = index;
                                        selectedQuestionIndex = 0;
                                      });
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: index == selectedIndex
                                        ? primaryColor
                                        : Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  child: Text(
                                    tabs[index],
                                    style: GoogleFonts.poppins(
                                      fontSize: widthFactor * 18,
                                      fontWeight: FontWeight.w500,
                                      color: index == selectedIndex
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      if (selectedIndex < tabs.length - 1 &&
                          selectedQuestionIndex >= 0)
                        QuestionArea(
                          questionNumber:
                              "Question-${selectedQuestionIndex + 1}",
                          question: currentQuestions.isNotEmpty
                              ? currentQuestions[selectedQuestionIndex]
                              : '',
                          options: currentOptions.isNotEmpty
                              ? currentOptions[selectedQuestionIndex]
                              : [],
                          correctAnswer: currentCorrectAnswers.isNotEmpty
                              ? currentCorrectAnswers[selectedQuestionIndex]
                              : '',
                          explanation: currentExplanations.isNotEmpty
                              ? currentExplanations[selectedQuestionIndex]
                              : '',
                          heightFactor: heightFactor,
                          widthFactor: widthFactor,
                        ),
                    ],
                  ),
                  height: heightFactor * 1200,
                  width: widthFactor * 735,
                  padding: EdgeInsets.fromLTRB(
                    20 * widthFactor,
                    30 * heightFactor,
                    20 * widthFactor,
                    40 * heightFactor,
                  ),
                  margin: EdgeInsets.only(top: 20 * heightFactor),
                  color: backgroundColor,
                ),
              ),
              SizedBox(width: 20 * widthFactor),
              CustomRoundedContainer(
                child: QuestionsSidebar(
                  questions: currentQuestions,
                  onQuestionSelected: updateQuestionIndex,
                  onDeleteQuestion: deleteQuestion,
                  onSaveQuestions: saveQuestions,
                ),
                height: heightFactor * 1200,
                width: widthFactor * 450,
                padding: EdgeInsets.fromLTRB(
                  20 * widthFactor,
                  30 * heightFactor,
                  20 * widthFactor,
                  40 * heightFactor,
                ),
                margin: EdgeInsets.only(top: 20 * heightFactor),
                color: backgroundColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
