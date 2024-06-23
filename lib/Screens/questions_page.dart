import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Import custom widgets and screens
import '../Widgets/Custom_Container.dart'; // Adjust path as per your project structure
import '../Widgets/questions_sidebar.dart'; // Import the updated QuestionsSidebar widget
import '../components/questions_area.dart'; // Adjust path as per your project structure
import '../constants/constants.dart'; // Adjust path as per your project structure
import '../Screens/questions_download.dart'; // Import the QuestionsDownload screen

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({Key? key}) : super(key: key);

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int selectedIndex = 0; // Track selected tab index
  int selectedQuestionIndex = 0; // Track selected question index

  // Data for HTML questions
  List<String> htmlQuestions = [
    'What is the full form of HTML?',
    'What is the purpose of HTML?',
    'What are HTML elements?',
  ];
  List<List<String>> htmlOptions = [
    ['Option A', 'Option B', 'Option C', 'Option D'],
    ['Option A', 'Option B', 'Option C', 'Option D'],
    ['Option A', 'Option B', 'Option C', 'Option D'],
  ];
  List<String> htmlCorrectAnswers = ['Option A', 'Option B', 'Option C'];
  List<String> htmlExplanations = [
    'HTML stands for HyperText Markup Language.',
    'HTML is used for creating structured documents.',
    'HTML elements are building blocks of HTML pages.',
  ];

  // Data for SQL questions
  List<String> sqlQuestions = [
    'What is SQL used for?',
    'What are the types of SQL statements?',
    'Explain SQL SELECT statement.',
    'What is a SQL JOIN?',
    'Explain SQL indexing.',
    'What is the difference between SQL and NoSQL?',
    'Explain ACID properties in SQL databases.',
  ];
  List<List<String>> sqlOptions = [
    ['Option A', 'Option B', 'Option C', 'Option D'],
    ['Option A', 'Option B', 'Option C', 'Option D'],
    ['Option A', 'Option B', 'Option C', 'Option D'],
    ['Option A', 'Option B', 'Option C', 'Option D'],
    ['Option A', 'Option B', 'Option C', 'Option D'],
    ['Option A', 'Option B', 'Option C', 'Option D'],
    ['Option A', 'Option B', 'Option C', 'Option D'],
  ];
  List<String> sqlCorrectAnswers = [
    'Option A',
    'Option B',
    'Option C',
    'Option D',
    'Option A',
    'Option B',
    'Option C',
  ];
  List<String> sqlExplanations = [
    'SQL is used for managing data in a relational database.',
    'Types include DDL, DML, DCL, TCL.',
    'SELECT statement retrieves data from a database.',
    'JOIN combines rows from two or more tables.',
    'Indexing improves data retrieval speed.',
    'SQL is relational, NoSQL is non-relational.',
    'ACID stands for Atomicity, Consistency, Isolation, Durability.',
  ];

  // Data for CSS questions
  List<String> cssQuestions = [
    'What is CSS?',
    'What are CSS selectors?',
    'Explain CSS box model.',
  ];
  List<List<String>> cssOptions = [
    ['Option A', 'Option B', 'Option C', 'Option D'],
    ['Option A', 'Option B', 'Option C', 'Option D'],
    ['Option A', 'Option B', 'Option C', 'Option D'],
  ];
  List<String> cssCorrectAnswers = ['Option A', 'Option B', 'Option C'];
  List<String> cssExplanations = [
    'CSS stands for Cascading Style Sheets.',
    'Selectors target specific HTML elements.',
    'Box model describes layout of elements.',
  ];

  List<String> get currentQuestions {
    switch (selectedIndex) {
      case 0:
        return htmlQuestions;
      case 1:
        return sqlQuestions;
      case 2:
        return cssQuestions;
      default:
        return []; // Handle any other cases
    }
  }

  List<List<String>> get currentOptions {
    switch (selectedIndex) {
      case 0:
        return htmlOptions;
      case 1:
        return sqlOptions;
      case 2:
        return cssOptions;
      default:
        return [[]]; // Handle any other cases
    }
  }

  List<String> get currentCorrectAnswers {
    switch (selectedIndex) {
      case 0:
        return htmlCorrectAnswers;
      case 1:
        return sqlCorrectAnswers;
      case 2:
        return cssCorrectAnswers;
      default:
        return []; // Handle any other cases
    }
  }

  List<String> get currentExplanations {
    switch (selectedIndex) {
      case 0:
        return htmlExplanations;
      case 1:
        return sqlExplanations;
      case 2:
        return cssExplanations;
      default:
        return []; // Handle any other cases
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
        if (selectedQuestionIndex == index) {
          selectedQuestionIndex = 0; // Reset to first question if the selected question is deleted
        } else if (selectedQuestionIndex > index) {
          selectedQuestionIndex--; // Adjust index if the selected question was after the deleted question
        }
      }
    });
  }

  void saveQuestions(List<String> updatedQuestions) {
    // Not implemented in this example
  }

  void addNewQuestion() {
    setState(() {
      currentQuestions.add('New Question');
      selectedQuestionIndex = currentQuestions.length - 1; // Select the newly added question
    });
  }

  void navigateToDownloadPage() {
    // Not implemented in this example
  }

  @override
  Widget build(BuildContext context) {
    double heightFactor = MediaQuery.of(context).size.height / 1024;
    double widthFactor = MediaQuery.of(context).size.width / 1440;

    List<String> tabs = ["HTML", "SQL", "CSS", "Add+"]; // Assuming you have tabs corresponding to questions

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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (int index = 0; index < tabs.length; index++)
                              SizedBox(
                                width: widthFactor * 127, // Adjust width as needed
                                height: heightFactor * 51, // Adjust height as needed
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      selectedIndex = index; // Update selected index
                                      selectedQuestionIndex = 0; // Reset selected question index on tab change
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: index == selectedIndex ? primaryColor : Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5), // Adjust border radius as needed
                                    ),
                                  ),
                                  child: Text(
                                    tabs[index],
                                    style: GoogleFonts.poppins(
                                      fontSize: widthFactor * 18,
                                      fontWeight: FontWeight.w500,
                                      color: index == selectedIndex ? Colors.white : Colors.black, // Change text color based on selection
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),

                      // Question Area for the selected tab and question
                      if (selectedIndex < tabs.length - 1 && selectedQuestionIndex >= 0)
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
}