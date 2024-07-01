import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Widgets/Custom_Container.dart'; // Adjust path as per your project structure
import '../Widgets/questions_sidebar.dart'; // Import the updated QuestionsSidebar widget
import '../components/custom_button.dart';
import '../components/questions_area.dart'; // Adjust path as per your project structure
import '../constants/constants.dart'; // Adjust path as per your project structure

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({Key? key}) : super(key: key);

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  bool isEditing = false;
  int selectedIndex = 0; // Track selected tab index
  int selectedQuestionIndex = 0; // Track selected question index
  final List<String> savedQuestions = []; // Initialize savedQuestions here

  List<String> currentQuestions = [];
  List<List<String>> currentOptions = [];
  List<String> currentCorrectAnswers = [];
  List<String> currentExplanations = [];

  bool isLoading = true;
  bool isError = false;

  late http.Client client;

  List<String> tabs = ["HTML", "CSS", "Java", "ADD+"]; // Added ADD+ for adding new tabs
  Map<String, List<String>> allQuestions = {};
  Map<String, List<List<String>>> allOptions = {};
  Map<String, List<String>> allCorrectAnswers = {};
  Map<String, List<String>> allExplanations = {};

  @override
  void initState() {
    super.initState();
    client = http.Client();
    fetchData(tab: tabs[selectedIndex]); // Call your API fetch function here for the initial tab
  }

  @override
  void dispose() {
    client.close(); // Close the HTTP client when no longer needed
    super.dispose();
  }

  Future<void> fetchData({required String tab}) async {
    final apiUrl = 'https://cine-admin-xar9.onrender.com/admin/questions';

    try {
      final response = await client.get(Uri.parse(apiUrl));

      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        // Parsing questions for the specified tab
        if (jsonData[tab] != null) {
          List<String> questions = [];
          List<List<String>> options = [];
          List<String> correctAnswers = [];
          List<String> explanations = [];

          for (var item in jsonData[tab]) {
            questions.add(item['question'].toString());
            options.add(List<String>.from(
                item['options'].map((option) => option['desc'].toString())));
            correctAnswers.add(item['answer'].toString());
            explanations.add('');
          }

          setState(() {
            allQuestions[tab] = questions;
            allOptions[tab] = options;
            allCorrectAnswers[tab] = correctAnswers;
            allExplanations[tab] = explanations;

            if (tab == tabs[selectedIndex]) {
              // Update state for the currently selected tab
              currentQuestions = allQuestions[tab] ?? [];
              currentOptions = allOptions[tab] ?? [];
              currentCorrectAnswers = allCorrectAnswers[tab] ?? [];
              currentExplanations = allExplanations[tab] ?? [];
              isLoading = false;
              isError = false;
            }
          });
        } else {
          setState(() {
            isError = true;
            isLoading = false;
          });
        }
      } else {
        setState(() {
          isError = true;
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Exception while fetching questions: $e');
      setState(() {
        isError = true;
        isLoading = false;
      });
    }
  }

  void updateQuestionIndex(int index) {
    setState(() {
      selectedQuestionIndex = index;
    });
  }

  void deleteQuestion(int index) {
    setState(() {
      if (index >= 0 && index < currentQuestions.length) {
        currentQuestions.removeAt(index);
        currentOptions.removeAt(index);
        currentCorrectAnswers.removeAt(index);
        currentExplanations.removeAt(index);
        if (selectedQuestionIndex == index) {
          selectedQuestionIndex = 0; // Reset to first question if the selected question is deleted
        } else if (selectedQuestionIndex > index) {
          selectedQuestionIndex--; // Adjust index if the selected question was after the deleted question
        }
      }
    });
  }

  void saveQuestions(List<String> updatedQuestions) {
    setState(() {
      savedQuestions.clear();
      savedQuestions.addAll(updatedQuestions);
    });
  }

  void addNewQuestion() {
    setState(() {
      currentQuestions.add('New Question');
      currentOptions.add(['Option A', 'Option B', 'Option C', 'Option D']);
      currentCorrectAnswers.add('Option A');
      currentExplanations.add('Explanation for the new question');
      selectedQuestionIndex = currentQuestions.length - 1; // Select the newly added question
    });
  }

  void navigateToDownloadPage() {}

  void showAddTabDialog() {
    TextEditingController tabNameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add New Tab"),
          content: TextField(
            controller: tabNameController,
            decoration: InputDecoration(hintText: "Enter tab name"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                String newTab = tabNameController.text.trim();
                if (newTab.isNotEmpty && !tabs.contains(newTab)) {
                  setState(() {
                    tabs.insert(tabs.length - 1, newTab); // Add new tab before "ADD+"
                    // Initialize the new tab data structures
                    allQuestions[newTab] = [];
                    allOptions[newTab] = [];
                    allCorrectAnswers[newTab] = [];
                    allExplanations[newTab] = [];
                  });
                  Navigator.of(context).pop();
                  // Fetch data for the new tab
                  fetchData(tab: newTab);
                }
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (isError) {
      return Center(child: Text('Failed to load questions.'));
    } else {
      if (isEditing) {
        return _buildQuestionEditingPage();
      }
      return _buildQuestionPage();
    }
  }

  Widget _buildQuestionPage() {
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
              // Main Content Area
              Expanded(
                child: CustomRoundedContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Tab Bar
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10 * heightFactor),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              for (int index = 0; index < tabs.length; index++)
                                SizedBox(
                                  width: widthFactor * 127,
                                  height: heightFactor * 51,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (index >= 0 && index < tabs.length) {
                                        if (tabs[index] == "ADD+") {
                                          showAddTabDialog();
                                        } else {
                                          setState(() {
                                            selectedIndex = index;
                                            selectedQuestionIndex = 0; // Reset selected question index on tab change
                                            isLoading = true; // Set loading state to true
                                          });

                                          // Fetch data for the selected tab
                                          fetchData(tab: tabs[index]);
                                        }
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: index == selectedIndex ? primaryColor : Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    child: Text(
                                      tabs[index],
                                      style: GoogleFonts.poppins(
                                        fontSize: widthFactor * 17,
                                        fontWeight: FontWeight.w500,
                                        color: index == selectedIndex ? Colors.white : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),

                      // Question Area for the selected tab and question
                      if (selectedIndex >= 0 && selectedIndex < tabs.length && tabs[selectedIndex] != "ADD+")
                        if (selectedQuestionIndex >= 0 && selectedQuestionIndex < currentQuestions.length)
                          QuestionArea(
                            questionNumber: "Question-${selectedQuestionIndex + 1}",
                            question: currentQuestions[selectedQuestionIndex],
                            options: currentOptions[selectedQuestionIndex],
                            correctAnswer: currentCorrectAnswers[selectedQuestionIndex],
                            explanation: currentExplanations[selectedQuestionIndex],
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

              // Right Sidebar
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

  Widget _buildQuestionEditingPage() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Questions'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isEditing = false;
              });
            },
            icon: Icon(Icons.done),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Editing Mode'),
            ElevatedButton(
              onPressed: () {
                addNewQuestion();
              },
              child: Text('Add New Question'),
            ),
            ElevatedButton(
              onPressed: () {
                navigateToDownloadPage();
              },
              child: Text('Download Questions'),
            ),
          ],
        ),
      ),
    );
  }
}
