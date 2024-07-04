import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Screens/questions_download.dart';
import '../constants/constants.dart';

class QuestionsSidebar extends StatefulWidget {
  final List<String> questions;
  final Function(int) onQuestionSelected;
  final Function(int) onDeleteQuestion;
  final Function(List<String>) onSaveQuestions;
  final Function(String, List<String>, String, String, String) onAddNewQuestion; // Callback to add a new question

  const QuestionsSidebar({
    Key? key,
    required this.questions,
    required this.onQuestionSelected,
    required this.onDeleteQuestion,
    required this.onSaveQuestions,
    required this.onAddNewQuestion,
  }) : super(key: key);

  @override
  _QuestionsSidebarState createState() => _QuestionsSidebarState();
}

class _QuestionsSidebarState extends State<QuestionsSidebar> {
  int selectedIndex = -1;
  TextEditingController _questionController = TextEditingController();
  TextEditingController _option1Controller = TextEditingController();
  TextEditingController _option2Controller = TextEditingController();
  TextEditingController _option3Controller = TextEditingController();
  TextEditingController _option4Controller = TextEditingController();
  TextEditingController _correctAnswerController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _questionIdController = TextEditingController();

  void deleteQuestion(int index) {
    widget.onDeleteQuestion(index);
    setState(() {
      selectedIndex = -1;
    });
  }

  void showAddQuestionDialog() {
    _questionController.clear();
    _option1Controller.clear();
    _option2Controller.clear();
    _option3Controller.clear();
    _option4Controller.clear();
    _correctAnswerController.clear();
    _descriptionController.clear();
    _questionIdController.clear();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Question'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _questionController,
                  decoration: InputDecoration(hintText: "Enter your question"),
                ),
                SizedBox(height: 8.0),
                TextField(
                  controller: _option1Controller,
                  decoration: InputDecoration(hintText: "Option 1"),
                ),
                SizedBox(height: 8.0),
                TextField(
                  controller: _option2Controller,
                  decoration: InputDecoration(hintText: "Option 2"),
                ),
                SizedBox(height: 8.0),
                TextField(
                  controller: _option3Controller,
                  decoration: InputDecoration(hintText: "Option 3"),
                ),
                SizedBox(height: 8.0),
                TextField(
                  controller: _option4Controller,
                  decoration: InputDecoration(hintText: "Option 4"),
                ),
                SizedBox(height: 8.0),
                TextField(
                  controller: _correctAnswerController,
                  decoration: InputDecoration(hintText: "Correct Answer"),
                ),
                SizedBox(height: 8.0),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(hintText: "Description"),
                ),
                SizedBox(height: 8.0),
                TextField(
                  controller: _questionIdController,
                  decoration: InputDecoration(hintText: "Question ID"),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_questionController.text.isNotEmpty &&
                    _option1Controller.text.isNotEmpty &&
                    _option2Controller.text.isNotEmpty &&
                    _option3Controller.text.isNotEmpty &&
                    _option4Controller.text.isNotEmpty &&
                    _correctAnswerController.text.isNotEmpty &&
                    _descriptionController.text.isNotEmpty &&
                    _questionIdController.text.isNotEmpty) {
                  // Add the question only if all fields are not empty
                  widget.onAddNewQuestion(
                    _questionController.text,
                    [
                      _option1Controller.text,
                      _option2Controller.text,
                      _option3Controller.text,
                      _option4Controller.text,
                    ],
                    _correctAnswerController.text,
                    _descriptionController.text,
                    _questionIdController.text,
                  );
                  Navigator.of(context).pop();
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }





  @override
  Widget build(BuildContext context) {
    double heightFactor = MediaQuery.of(context).size.height / 1024;
    double widthFactor = MediaQuery.of(context).size.width / 1440;

    return SingleChildScrollView(
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
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                        widget.onQuestionSelected(index);
                      });
                    },
                    child: Container(
                      width: 60 * widthFactor,
                      height: 60 * heightFactor,
                      margin: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: selectedIndex == index ? primaryColor : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                      child: Text(
                        (index + 1).toString(),
                        style: TextStyle(
                          color: selectedIndex == index ? Colors.white : primaryColor,
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
                onPressed: selectedIndex != -1 ? () => deleteQuestion(selectedIndex) : null,
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
              ElevatedButton(
                onPressed: () {
                  widget.onSaveQuestions(widget.questions);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QuestionsDownload(savedQuestions: widget.questions)),
                  );
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
                  "Save",
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
    );
  }
}