import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For using jsonEncode
import '../Screens/questions_download.dart';
import '../constants/constants.dart';

class QuestionsSidebar extends StatefulWidget {
  final List<String> questions;
  final Function(int) onQuestionSelected;
  final Function(int) onDeleteQuestion;
  final Function(List<String>) onSaveQuestions; // Callback to save questions

  const QuestionsSidebar({
    Key? key,
    required this.questions,
    required this.onQuestionSelected,
    required this.onDeleteQuestion,
    required this.onSaveQuestions,
  }) : super(key: key);

  @override
  _QuestionsSidebarState createState() => _QuestionsSidebarState();
}

class _QuestionsSidebarState extends State<QuestionsSidebar> {
  int selectedIndex = -1; // Track selected index, -1 means none selected

  void deleteQuestion(int index) {
    widget.onDeleteQuestion(index);
    setState(() {
      selectedIndex = -1; // Reset selection
    });
  }

  void addQuestion() async {
    final newQuestion = {
      "quesId": "51",
      "question": "Full form of HTML",
      "options": [
        {"desc": "option 1", "id": "1"},
        {"desc": "option 2", "id": "2"},
        {"desc": "option 3", "id": "3"},
        {"desc": "option 4", "id": "4"},
      ],
      "subject": "HTML",
      "answer": "3"
    };

    final String authToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE3MTk3NTk3NzUsImV4cCI6MTcxOTc2Njk3NSwiYXVkIjoiNjY3NmExNzIyOGQzOTQwZWQwMTgxNDdhIiwiaXNzIjoiY2luZV9jc2kifQ.KM5CaRAGdjtmDnufZ4CAcEIdGlH68cf5-35Ls2AvNe4';

    try {
      final response = await http.post(
        Uri.parse('https://cine-admin-xar9.onrender.com/admin/addQuestion'),
        headers: {
          'Content-Type': 'application/json',
          // No Authorization header needed here since token is in cookies
        },
        body: jsonEncode(newQuestion),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        setState(() {
          widget.questions.add(newQuestion['question'] as String); // Add the new question
        });
      } else {
        // Handle error
        print('Failed to add question: ${response.reasonPhrase}');
        print('Error message: ${jsonDecode(response.body)['message']}'); // Print detailed error message if available
      }
    } catch (e) {
      print('Error adding question: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double heightFactor = MediaQuery.of(context).size.height / 1024;
    double widthFactor = MediaQuery.of(context).size.width / 1440;

    return SingleChildScrollView(
      child: Column(
        children: [
          // Top "Question" label
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

          // Grid of question numbers and Add Question button
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
              itemCount: widget.questions.length + 1, // +1 for Add Question button
              itemBuilder: (context, index) {
                if (index == widget.questions.length) {
                  // Add Question button
                  return GestureDetector(
                    onTap: addQuestion,
                    child: Container(
                      width: 60 * widthFactor,
                      height: 60 * heightFactor,
                      margin: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white, // White background for the button
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.add,
                        color: primaryColor, // Blue color for the "+" icon
                        size: 30 * widthFactor,
                      ),
                    ),
                  );
                } else {
                  // Existing question tiles
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

          // Delete and Save buttons
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
                  // Save questions and navigate to QuestionsDownload page
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
