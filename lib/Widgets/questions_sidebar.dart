import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constants.dart';

class QuestionsSidebar extends StatefulWidget {
  final List<String> questions;
  final Function(int) onQuestionSelected;
  final Function(int) onDeleteQuestion;
  final Function(List<String>) onSaveQuestions;
  final Function(String, List<String>, String, String, String) onAddNewQuestion;
  final String subject;

  const QuestionsSidebar({
    Key? key,
    required this.questions,
    required this.onQuestionSelected,
    required this.onDeleteQuestion,
    required this.onSaveQuestions,
    required this.onAddNewQuestion,
    required this.subject,
  }) : super(key: key);

  @override
  _QuestionsSidebarState createState() => _QuestionsSidebarState();
}

class _QuestionsSidebarState extends State<QuestionsSidebar> {
  int selectedIndex = 0;
  String? selectedPredefinedQuestion;
  TextEditingController _questionController = TextEditingController();
  TextEditingController _option1Controller = TextEditingController();
  TextEditingController _option2Controller = TextEditingController();
  TextEditingController _option3Controller = TextEditingController();
  TextEditingController _option4Controller = TextEditingController();
  TextEditingController _correctAnswerController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _questionIdController = TextEditingController();
  TextEditingController _questionUpdateController = TextEditingController();
  TextEditingController _option1UpdateController = TextEditingController();
  TextEditingController _option2UpdateController = TextEditingController();
  TextEditingController _option3UpdateController = TextEditingController();
  TextEditingController _option4UpdateController = TextEditingController();
  TextEditingController _correctAnswerUpdateController = TextEditingController();
  TextEditingController _descriptionUpdateController = TextEditingController();
  TextEditingController _questionIdUpdateController = TextEditingController();
  Future<void> saveQuestionId(String questionId) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> questionIds = prefs.getStringList('questionIds') ?? [];
    questionIds.add(questionId);
    await prefs.setStringList('questionIds', questionIds);
  }

  Future<List<String>> getQuestionIds() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('questionIds') ?? [];
  }

  Future<void> deleteQuestion(String quesId, Function refreshQuestions) async {
    var apiUrl = 'https://cine-admin-xar9.onrender.com/admin/deleteQuestion';

    var request = http.Request('DELETE', Uri.parse(apiUrl));
    request.headers['Content-Type'] = 'application/json';
    request.body = jsonEncode({
      'quesId': quesId,
    });

    try {
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Question deleted successfully',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.grey,
            duration: Duration(seconds: 3), // Show snackbar for 2 seconds
          ),
        );
        Future.delayed(Duration(seconds: 2), () {
          refreshQuestions();
        });

        print(await response.stream.bytesToString());
      } else {
        print('Failed with status: ${response.statusCode}');
        print('Reason: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Exception during DELETE request: $e');
    }
  }

  final List<Map<String, dynamic>> predefinedQuestions = [
    // HTML Questions
    {
      'quesId': '1',
      'question': 'What does HTML stand for?',
      'options': [
        {'desc': 'Hyper Text Markup Language', 'id': '1'},
        {'desc': 'Hypertext Transfer Protocol', 'id': '2'},
        {'desc': 'Hyperlinks and Text Markup Language', 'id': '3'},
        {'desc': 'Hypertext Markup Level', 'id': '4'},
      ],
      'correctAnswer': '1',
      'description': 'Basics of HTML.',
    },
    {
      'quesId': '2',
      'question': 'Which of the following tags is used to define a hyperlink in HTML?',
      'options': [
        {'desc': '<a>', 'id': '1'},
        {'desc': '<link>', 'id': '2'},
        {'desc': '<href>', 'id': '3'},
        {'desc': '<hyperlink>', 'id': '4'},
      ],
      'correctAnswer': '1',
      'description': 'Hyperlinks in HTML.',
    },

    // CSS Questions
    {
      'quesId': '3',
      'question': 'Which property is used to change the background color in CSS?',
      'options': [
        {'desc': 'background-color', 'id': '1'},
        {'desc': 'bgcolor', 'id': '2'},
        {'desc': 'color', 'id': '3'},
        {'desc': 'background', 'id': '4'},
      ],
      'correctAnswer': '1',
      'description': 'CSS properties for backgrounds.',
    },
    {
      'quesId': '4',
      'question': 'How do you select an element with the class name \'header\' in CSS?',
      'options': [
        {'desc': '.header', 'id': '1'},
        {'desc': 'header', 'id': '2'},
        {'desc': '#header', 'id': '3'},
        {'desc': '*header', 'id': '4'},
      ],
      'correctAnswer': '1',
      'description': 'CSS selectors.',
    },

    // Java Questions
    {
      'quesId': '5',
      'question': 'Which keyword is used to create a new instance of a class in Java?',
      'options': [
        {'desc': 'new', 'id': '1'},
        {'desc': 'create', 'id': '2'},
        {'desc': 'make', 'id': '3'},
        {'desc': 'instance', 'id': '4'},
      ],
      'correctAnswer': '1',
      'description': 'Java object creation.',
    },
    {
      'quesId': '6',
      'question': 'What is the default value of a boolean variable in Java?',
      'options': [
        {'desc': 'false', 'id': '1'},
        {'desc': 'true', 'id': '2'},
        {'desc': 'null', 'id': '3'},
        {'desc': '0', 'id': '4'},
      ],
      'correctAnswer': '1',
      'description': 'Default values in Java.',
    },

    // Python Questions
    {
      'quesId': '7',
      'question': 'Which of the following is a correct syntax for defining a function in Python?',
      'options': [
        {'desc': 'def function_name():', 'id': '1'},
        {'desc': 'function function_name():', 'id': '2'},
        {'desc': 'define function_name():', 'id': '3'},
        {'desc': 'func function_name():', 'id': '4'},
      ],
      'correctAnswer': '1',
      'description': 'Function definition in Python.',
    },
    {
      'quesId': '8',
      'question': 'How do you comment a single line in Python?',
      'options': [
        {'desc': '# comment', 'id': '1'},
        {'desc': '// comment', 'id': '2'},
        {'desc': '/* comment */', 'id': '3'},
        {'desc': '-- comment', 'id': '4'},
      ],
      'correctAnswer': '1',
      'description': 'Commenting in Python.',
    },

    // Aptitude Questions
    {
      'quesId': '9',
      'question': 'If a train travels 60 km in 1 hour, what is its speed?',
      'options': [
        {'desc': '60 km/h', 'id': '1'},
        {'desc': '120 km/h', 'id': '2'},
        {'desc': '30 km/h', 'id': '3'},
        {'desc': '45 km/h', 'id': '4'},
      ],
      'correctAnswer': '1',
      'description': 'Basic speed calculation.',
    },
    {
      'quesId': '10',
      'question': 'What is the value of 5 factorial (5!)?',
      'options': [
        {'desc': '120', 'id': '1'},
        {'desc': '60', 'id': '2'},
        {'desc': '24', 'id': '3'},
        {'desc': '100', 'id': '4'},
      ],
      'correctAnswer': '1',
      'description': 'Factorial calculation.',
    },
  ];



  void showAddQuestionDialog() {
    _questionController.clear();
    _option1Controller.clear();
    _option2Controller.clear();
    _option3Controller.clear();
    _option4Controller.clear();
    _correctAnswerController.clear();
    _descriptionController.clear();
    _questionIdController.clear();

    final _formKey = GlobalKey<FormState>();


    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: const Offset(0.0, 10.0),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Add New Question',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16.0),

                    // Dropdown to select predefined question
                    DropdownButton<String>(
                      value: selectedPredefinedQuestion,
                      hint: Text('Select Predefined Question'),
                      items: predefinedQuestions.map((question) {
                        return DropdownMenuItem<String>(
                          value: question['question'],
                          child: Text(question['question']),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedPredefinedQuestion = value;
                          final selectedData = predefinedQuestions.firstWhere(
                                (q) => q['question'] == value,
                          );
                          _questionController.text = selectedData['question'];
                          _option1Controller.text = selectedData['options'][0]['desc'];
                          _option2Controller.text = selectedData['options'][1]['desc'];
                          _option3Controller.text = selectedData['options'][2]['desc'];
                          _option4Controller.text = selectedData['options'][3]['desc'];
                          _correctAnswerController.text = selectedData['correctAnswer'];
                          _descriptionController.text = selectedData['description'];
                          _questionIdController.text = selectedData['quesId'];
                        });
                      },
                    ),

                    // TextFormFields with validations
                    TextFormField(
                      controller: _questionController,
                      decoration: InputDecoration(
                        labelText: 'Enter your question',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a valid question.';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),

                    Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: SyntaxView(
                        code: _questionController.text,
                        syntax: Syntax.CPP,
                        syntaxTheme: SyntaxTheme.dracula(), // You can choose different themes
                        withLinesCount: true,
                        fontSize: 14.0,
                      ),
                    ),
                    SizedBox(height: 12.0),
                    _buildValidatedTextFormField(
                      controller: _option1Controller,
                      hintText: 'Option 1',
                      validationMessage: 'Please enter a valid option.',
                    ),
                    SizedBox(height: 12.0),
                    _buildValidatedTextFormField(
                      controller: _option2Controller,
                      hintText: 'Option 2',
                      validationMessage: 'Please enter a valid option.',
                    ),
                    SizedBox(height: 12.0),
                    _buildValidatedTextFormField(
                      controller: _option3Controller,
                      hintText: 'Option 3',
                      validationMessage: 'Please enter a valid option.',
                    ),
                    SizedBox(height: 12.0),
                    _buildValidatedTextFormField(
                      controller: _option4Controller,
                      hintText: 'Option 4',
                      validationMessage: 'Please enter a valid option.',
                    ),
                    SizedBox(height: 12.0),
                    TextFormField(
                      controller: _correctAnswerController,
                      decoration: InputDecoration(
                        labelText: 'Correct Answer',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the correct answer';
                        } else if (!RegExp(r'^[1-4]$').hasMatch(value)) {
                          return 'Please enter correct option id';
                        }
                        return null;
                      },
                    ),

                    // SizedBox(height: 12.0),
                    // TextFormField(
                    //   controller: _descriptionController,
                    //   decoration: InputDecoration(
                    //     hintText: 'Description',
                    //     border: OutlineInputBorder(),
                    //   ),
                    // ),
                    // SizedBox(height: 12.0),
                    // TextFormField(
                    //   controller: _questionIdController,
                    //   decoration: InputDecoration(
                    //     hintText: 'Question ID',
                    //     border: OutlineInputBorder(),
                    //   ),
                    // ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                          ),
                          child: Text('Cancel'),
                        ),
                        SizedBox(width: 12.0),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
    String question = _questionController.text;
    List<Map<String, String>> options = [
    {"desc": _option1Controller.text, "id": "1"},
    {"desc": _option2Controller.text, "id": "2"},
    {"desc": _option3Controller.text, "id": "3"},
    {"desc": _option4Controller.text, "id": "4"},
    ];
    String correctAnswer =
    _correctAnswerController.text;
    String description = _descriptionController.text;
    String questionId = _questionIdController.text;

    var response = await http.post(
    Uri.parse(
    'https://cine-admin-xar9.onrender.com/admin/addQuestion'),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
    "question": question,
    "options": options
        .map((option) => {
    "desc": option["desc"],
    "id": option["id"]
    })
        .toList(),
    "subject": widget.subject,
    "quesId": questionId,
    "answer": correctAnswer,
    "description": description,
    }),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 201) {
    widget.onAddNewQuestion(
    question,
    options
        .map((option) => option['desc'] ?? "")
        .toList(),
    correctAnswer,
    description,
    questionId,
    );

    // Save the new question ID to SharedPreferences
    await saveQuestionId(questionId);
    List<String> savedIds = await getQuestionIds();
    // print('Question IDs saved: $savedIds');

    Navigator.of(context).pop();
    } else {
    if (response.statusCode == 500) {
    print('Internal server error occurred');
    } else {
    print('Failed to add question');
    }
    }
    }
    },


                          child: Text('Add'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildValidatedTextFormField({
    required TextEditingController controller,
    required String hintText,
    required String validationMessage,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return validationMessage;
        }
        return null;
      },
    );
  }


  Widget _buildOptionTextField(
      TextEditingController controller, String hintText, String id) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(hintText: hintText),
      onChanged: (_) => setState(() {}),
    );
  }

  void _loadQuestions() {
    // Implement your logic to fetch updated questions here
    // For example:
    // List<String> updatedQuestions = fetchQuestionsFromServer();
    // setState(() {
    //   widget.questions = updatedQuestions;
    // });
  }

  @override
  Widget build(BuildContext context) {
    double heightFactor = MediaQuery.of(context).size.height / 1024;
    double widthFactor = MediaQuery.of(context).size.width / 1440;

    return Scaffold(
      backgroundColor: Color(0xf9f9f9),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: heightFactor * 80,
              padding: EdgeInsets.all(10 * heightFactor),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "Question",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 24 * widthFactor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 20 * heightFactor),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10 * heightFactor),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 10 * heightFactor,
                  crossAxisSpacing: 10 * widthFactor,
                ),
                itemCount: widget.questions.length + 1,
                itemBuilder: (context, index) {
                  if (index == widget.questions.length) {
                    return GestureDetector(
                      onTap: showAddQuestionDialog,
                      child: Container(
                        width: 60 * widthFactor,
                        height: 60 * heightFactor,
                        margin: EdgeInsets.all(10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.add,
                          color: primaryColor,
                          size: 30 * widthFactor,
                        ),
                      ),
                    );
                  } else {
                    return GestureDetector(
                      onTap: () async {
                        setState(() {
                          selectedIndex = index;
                          widget.onQuestionSelected(index);
                        });
                        List<String> savedIds = await getQuestionIds();
                        if (index < savedIds.length) {
                          String questionId = savedIds[index];
                          // print('Clicked question ID: $questionId');
                        } else {
                          print('No question ID found for index $index');
                        }
                      },
                      child: Container(
                        width: 60 * widthFactor,
                        height: 60 * heightFactor,
                        margin: EdgeInsets.all(10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: selectedIndex == index
                              ? primaryColor
                              : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        child: Text(
                          (index + 1).toString(),
                          style: TextStyle(
                            color: selectedIndex == index
                                ? Colors.white
                                : primaryColor,
                            fontSize: 18 * widthFactor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
            SizedBox(height: 20 * heightFactor),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    if (selectedIndex != -1) {
                      // Get question ID based on selectedIndex
                      List<String> savedIds = await getQuestionIds();
                      if (selectedIndex < savedIds.length) {
                        String questionId = savedIds[selectedIndex];
                        deleteQuestion(questionId,
                            _loadQuestions); // Call deleteQuestion with question ID and refresh function
                        widget.onDeleteQuestion(selectedIndex);
                      } else {
                        print('No question ID found for index $selectedIndex');
                      }
                    } else {
                      print('No question selected to delete');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20 * widthFactor,
                      vertical: 10 * heightFactor,
                    ),
                  ),
                  child: Text(
                    "Delete",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: widthFactor * 18,
                    ),
                  ),
                ),
               
              ],
            ),
          ],
        ),
      ),
    );
  }
}
