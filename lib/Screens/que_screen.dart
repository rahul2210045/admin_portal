import 'package:admin_portal/components/questions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Widgets/Custom_Container.dart';
import '../constants/constants.dart';
import '../Widgets/questions_sidebar.dart'; // Import the updated QuestionsSidebar widget
import '../Screens/questions_download.dart'; // Import the QuestionsDownload screen

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({Key? key}) : super(key: key);

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int selectedIndex = 0; // Track selected tab index
  int selectedQuestionIndex = 0; // Track selected question index
  List<String> questions = [
    'What is the full form of HTML?',
    'What is SQL used for?',
    'What is CSS?',
  ]; // Initialize with default questions

  List<String> savedQuestions = [
  ]; // List to hold saved questions for QuestionsDownload

  void updateQuestionIndex(int index) {
    setState(() {
      selectedQuestionIndex = index;
    });
  }

  void deleteQuestion(int index) {
    setState(() {
      if (index >= 0 && index < questions.length) {
        questions.removeAt(index);
        if (selectedQuestionIndex == index) {
          selectedQuestionIndex =
          0; // Reset to first question if the selected question is deleted
        }
      }
    });
  }

  void saveQuestions(List<String> updatedQuestions) {
    setState(() {
      savedQuestions =
          List.from(updatedQuestions); // Update saved questions list
    });
  }

  void addNewQuestion() {
    setState(() {
      questions.add('New Question');
      selectedQuestionIndex =
          questions.length - 1; // Select the newly added question
    });
  }

  void navigateToDownloadPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuestionsDownload(savedQuestions: savedQuestions),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double heightFactor = MediaQuery
        .of(context)
        .size
        .height / 1024;
    double widthFactor = MediaQuery
        .of(context)
        .size
        .width / 1440;

    List<String> tabs = [
      "HTML",
      "SQL",
      "CSS",
      "Add+"
    ]; // Assuming you have tabs corresponding to questions

    List<List<String>> options = [
      ['Option A', 'Option B', 'Option C', 'Option D'],
      ['Option A', 'Option B', 'Option C', 'Option D'],
      ['Option A', 'Option B', 'Option C', 'Option D'],
      ['Option A', 'Option B', 'Option C', 'Option D'],
    ];

    List<String> correctAnswers = [
      'Option A',
      'Option B',
      'Option C',
      'Option D',
    ];

    List<String> explanations = [
      'HTML stands for HyperText Markup Language.',
      'SQL is used for managing data in a relational database.',
      'CSS stands for Cascading Style Sheets.',
      'Add your explanation here.',
    ];

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
                        padding: EdgeInsets.symmetric(
                            vertical: 10 * heightFactor),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (int index = 0; index < tabs.length; index++)
                              SizedBox(
                                width: widthFactor * 127,
                                // Adjust width as needed
                                height: heightFactor * 51,
                                // Adjust height as needed
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      selectedIndex =
                                          index; // Update selected index
                                      selectedQuestionIndex =
                                      0; // Reset selected question index on tab change
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: index == selectedIndex
                                        ? primaryColor
                                        : Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          5), // Adjust border radius as needed
                                    ),
                                  ),
                                  child: Text(
                                    tabs[index],
                                    style: GoogleFonts.poppins(
                                      fontSize: widthFactor * 18,
                                      fontWeight: FontWeight.w500,
                                      color: index == selectedIndex ? Colors
                                          .white : Colors
                                          .black, // Change text color based on selection
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),

                      // Question Area for the selected tab and question
                      if (selectedIndex < questions.length &&
                          selectedQuestionIndex >= 0)
                        QuestionArea(
                          questionNumber: "Question-${selectedQuestionIndex + 1}",
                          question: questions[selectedQuestionIndex],
                          options: options[selectedQuestionIndex],
                          correctAnswer: correctAnswers[selectedQuestionIndex],
                          explanation: explanations[selectedQuestionIndex],
                          heightFactor: heightFactor,
                          widthFactor: widthFactor,),

                      // Button to add new question
                      SizedBox(height: 20 * heightFactor),

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
                  questions: questions,
                  onQuestionSelected: updateQuestionIndex,
                  onDeleteQuestion: deleteQuestion,
                  onSaveQuestions: saveQuestions,
                ),
                height: heightFactor * 858,
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
