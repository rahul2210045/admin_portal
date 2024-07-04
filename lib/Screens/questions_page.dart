import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Widgets/Custom_Container.dart';
import '../Widgets/questions_sidebar.dart';
import '../components/questions_area.dart';
import '../constants/constants.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({Key? key}) : super(key: key);

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  bool isEditing = false;
  int selectedIndex = 0;
  int selectedQuestionIndex = 0;
  int editingQuestionIndex = -1; // Track the index of the question being edited

  List<String> currentQuestions = [];
  List<List<String>> currentOptions = [];
  List<String> currentCorrectAnswers = [];
  List<String> currentExplanations = [];

  bool isLoading = true;
  bool isError = false;

  late http.Client client;

  List<String> tabs = ["HTML", "CSS", "Java", "ADD+"];
  Map<String, List<String>> allQuestions = {};
  Map<String, List<List<String>>> allOptions = {};
  Map<String, List<String>> allCorrectAnswers = {};
  Map<String, List<String>> allExplanations = {};

  @override
  void initState() {
    super.initState();
    client = http.Client();
    fetchData(tab: tabs[selectedIndex]);
  }

  @override
  void dispose() {
    client.close();
    super.dispose();
  }

  Future<void> fetchData({required String tab}) async {
    final apiUrl = 'https://cine-admin-xar9.onrender.com/admin/questions';

    try {
      final response = await client.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        parseData(jsonData, tab);
      } else {
        setErrorState();
      }
    } catch (e) {
      debugPrint('Exception while fetching questions: $e');
      setErrorState();
    }
  }

  void parseData(Map<String, dynamic> jsonData, String tab) {
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
          updateCurrentState(tab);
        }
      });
    } else {
      setErrorState();
    }
  }

  void updateCurrentState(String tab) {
    setState(() {
      currentQuestions = allQuestions[tab] ?? [];
      currentOptions = allOptions[tab] ?? [];
      currentCorrectAnswers = allCorrectAnswers[tab] ?? [];
      currentExplanations = allExplanations[tab] ?? [];
      isLoading = false;
      isError = false;
    });
  }

  void setErrorState() {
    setState(() {
      isError = true;
      isLoading = false;
    });
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
        adjustSelectedQuestionIndex(index);
      }
    });
  }

  void adjustSelectedQuestionIndex(int index) {
    if (selectedQuestionIndex == index) {
      selectedQuestionIndex = 0;
    } else if (selectedQuestionIndex > index) {
      selectedQuestionIndex--;
    }
  }

  void saveQuestions(List<String> updatedQuestions) {
    setState(() {
      currentQuestions = List.from(updatedQuestions);
    });
  }

  void addNewQuestion(String question, List<String> options, String correctAnswer, String description, String questionId) {
    setState(() {
      currentQuestions.add(question);
      currentOptions.add(options);
      currentCorrectAnswers.add(correctAnswer);
      currentExplanations.add(description);
      // Optionally, add logic to save to backend or perform any other actions
      // saveNewQuestion(question, options, correctAnswer, description, questionId);
      selectedQuestionIndex = currentQuestions.length - 1;
    });
  }


  void navigateToDownloadPage() {
    // Implement navigation logic
  }

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
                addNewTab(tabNameController.text.trim());
                Navigator.of(context).pop();
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

  void addNewTab(String newTab) {
    if (newTab.isNotEmpty && !tabs.contains(newTab)) {
      setState(() {
        tabs.insert(tabs.length - 1, newTab);
        allQuestions[newTab] = [];
        allOptions[newTab] = [];
        allCorrectAnswers[newTab] = [];
        allExplanations[newTab] = [];
      });
      fetchData(tab: newTab);
    }
  }

  void toggleEditingMode(int index) {
    setState(() {
      editingQuestionIndex = editingQuestionIndex == index ? -1 : index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (isError) {
      return Center(child: Text('Failed to load questions.'));
    } else {
      return isEditing ? _buildQuestionEditingPage() : _buildQuestionPage();
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
              Expanded(
                child: CustomRoundedContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildTabBar(heightFactor, widthFactor),
                      buildQuestionArea(heightFactor, widthFactor),
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
              buildRightSidebar(heightFactor, widthFactor),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTabBar(double heightFactor, double widthFactor) {
    return Container(
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
                    handleTabChange(index);
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
    );
  }

  void handleTabChange(int index) {
    if (index >= 0 && index < tabs.length) {
      if (tabs[index] == "ADD+") {
        showAddTabDialog();
      } else {
        setState(() {
          selectedIndex = index;
          selectedQuestionIndex = 0;
          isLoading = true;
        });
        fetchData(tab: tabs[index]);
      }
    }
  }

  Widget buildQuestionArea(double heightFactor, double widthFactor) {
    if (selectedIndex >= 0 && selectedIndex < tabs.length && tabs[selectedIndex] != "ADD+") {
      if (selectedQuestionIndex >= 0 && selectedQuestionIndex < currentQuestions.length) {
        return QuestionArea(
          questionNumber: "Question-${selectedQuestionIndex + 1}",
          question: currentQuestions[selectedQuestionIndex],
          options: currentOptions.length > selectedQuestionIndex ? currentOptions[selectedQuestionIndex] : [],
          correctAnswer: currentCorrectAnswers.length > selectedQuestionIndex ? currentCorrectAnswers[selectedQuestionIndex] : '',
          explanation: currentExplanations.length > selectedQuestionIndex ? currentExplanations[selectedQuestionIndex] : '',
          heightFactor: heightFactor,
          widthFactor: widthFactor,
          isEditing: editingQuestionIndex == selectedQuestionIndex,
          toggleEditingMode: () => toggleEditingMode(selectedQuestionIndex),
        );
      } else {
        // Handle case when selectedQuestionIndex is out of bounds
        return Container(
          alignment: Alignment.center,
          child: Text('No question selected or index out of bounds.'),
        );
      }
    } else {
      // Handle case when selectedIndex is out of bounds or tab is "ADD+"
      return Container();
    }
  }

  Widget buildRightSidebar(double heightFactor, double widthFactor) {
    return CustomRoundedContainer(
      child: QuestionsSidebar(
        questions: currentQuestions,
        onQuestionSelected: updateQuestionIndex,
        onDeleteQuestion: deleteQuestion,
        onSaveQuestions: saveQuestions,
        onAddNewQuestion: addNewQuestion,
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
            // ElevatedButton(
            //   onPressed: addNewQuestion,
            //   child: Text('Add New Question'),
            // ),
            ElevatedButton(
              onPressed: navigateToDownloadPage,
              child: Text('Download Questions'),
            ),
          ],
        ),
      ),
    );
  }
}