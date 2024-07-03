import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Screens/questions_download.dart';
import '../constants/constants.dart';

class QuestionsSidebar extends StatefulWidget {
  final List<String> questions;
  final Function(int) onQuestionSelected;
  final Function(int) onDeleteQuestion;
  final Function(List<String>) onSaveQuestions;
  final Function() onAddNewQuestion; // Callback to add a new question

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

  void deleteQuestion(int index) {
    widget.onDeleteQuestion(index);
    setState(() {
      selectedIndex = -1;
    });
  }

  void showAddQuestionDialog() {
    _questionController.clear();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Question'),
          content: TextField(
            controller: _questionController,
            decoration: InputDecoration(hintText: "Enter your question"),
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
                if (_questionController.text.isNotEmpty) {
                  // Add the question only if it's not empty
                  widget.questions.add(_questionController.text);
                  widget.onAddNewQuestion(); // Notify the parent widget
                  widget.onQuestionSelected(widget.questions.length - 1); // Select the newly added question
                }
                Navigator.of(context).pop();
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
