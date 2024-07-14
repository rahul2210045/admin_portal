

import 'package:admin_portal/constants/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class QuestionArea extends StatefulWidget {
  final String quesId;
  final String subject;
  final String questionNumber;
  final String question;
  final List<Map<String, String>> options; // Update to List<Map<String, String>>
  final String correctAnswer;
  final String explanation;
  final double heightFactor;
  final double widthFactor;
  final bool isEditing;
  final VoidCallback toggleEditingMode;
  final Function(String question, List<Map<String, String>> options, String correctAnswer, String explanation) updateQuestionDetails; // Update Function signature

  const QuestionArea({
    Key? key,
    required this.quesId,
    required this.subject,
    required this.questionNumber,
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
    required this.heightFactor,
    required this.widthFactor,
    required this.isEditing,
    required this.toggleEditingMode,
    required this.updateQuestionDetails,
  }) : super(key: key);

  @override
  _QuestionAreaState createState() => _QuestionAreaState();
}

class _QuestionAreaState extends State<QuestionArea> {
  late TextEditingController _questionController;
  late List<TextEditingController> _optionControllers;
  late TextEditingController _correctAnswerController;
  late TextEditingController _explanationController;
  int selectedOptionIndex = -1;

  @override
  void initState() {
    super.initState();
    _questionController = TextEditingController(text: widget.question);
    _optionControllers = List.generate(
      widget.options.length,
      (index) => TextEditingController(text: widget.options[index]["desc"] ?? ""),
    );
    _correctAnswerController = TextEditingController(text: widget.correctAnswer);
    _explanationController = TextEditingController(text: widget.explanation);
  }

  @override
  void didUpdateWidget(covariant QuestionArea oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.question != widget.question) {
      _questionController.text = widget.question;
    }
    if (!listEquals(oldWidget.options, widget.options)) {
      for (int i = 0; i < widget.options.length; i++) {
        if (i < _optionControllers.length) {
          _optionControllers[i].text = widget.options[i]["desc"] ?? "";
        } else {
          _optionControllers.add(TextEditingController(text: widget.options[i]["desc"] ?? ""));
        }
      }
    }
    if (oldWidget.correctAnswer != widget.correctAnswer) {
      _correctAnswerController.text = widget.correctAnswer;
    }
    if (oldWidget.explanation != widget.explanation) {
      _explanationController.text = widget.explanation;
    }
  }

  @override
  void dispose() {
    _questionController.dispose();
    _optionControllers.forEach((controller) => controller.dispose());
    _correctAnswerController.dispose();
    _explanationController.dispose();
    super.dispose();
  }

  Future<void> _handleTickIconPressed() async {
    final updatedQuestion = _questionController.text;
    final updatedOptions = _optionControllers
        .asMap()
        .entries
        .map((entry) => {
          "desc": entry.value.text,
          "id": (entry.key + 1).toString() // Assuming IDs are 1, 2, 3, ...
        })
        .toList();
    final updatedCorrectAnswer = _correctAnswerController.text;
    final updatedExplanation = _explanationController.text;

    final response = await http.patch(
      Uri.parse('https://cine-admin-xar9.onrender.com/admin/updateQuestion'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "quesId": widget.quesId,
        "question": updatedQuestion,
        "options": updatedOptions,
        "subject": widget.subject,
        "answer": updatedCorrectAnswer,
        // "description": updatedExplanation,
      }),
    );

    if (response.statusCode == 200) {
      widget.updateQuestionDetails(
        updatedQuestion,
        updatedOptions,
        updatedCorrectAnswer,
        updatedExplanation,
      );
      widget.toggleEditingMode();
    } else {
      // Handle the error
      print('Failed to update question: ${response.statusCode}');
      print('Response: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(38.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.questionNumber,
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 24 * widget.widthFactor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10 * widget.heightFactor),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.isEditing
                      ? Expanded(
                          child: TextField(
                            controller: _questionController,
                            style: GoogleFonts.poppins(
                              color: primaryText,
                              fontSize: 30 * widget.widthFactor,
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                            maxLines: null,
                          ),
                        )
                      : Flexible(
                          child: Text(
                            widget.question,
                            style: GoogleFonts.poppins(
                              color: primaryText,
                              fontSize: 30 * widget.widthFactor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                  GestureDetector(
                    onTap: widget.isEditing ? _handleTickIconPressed : widget.toggleEditingMode,
                    child: Icon(widget.isEditing ? Icons.check : Icons.edit),
                  ),
                ],
              ),
              SizedBox(height: 20 * widget.heightFactor),
              Divider(
                color: Colors.black,
                thickness: 1,
                height: 20 * widget.heightFactor,
              ),
              SizedBox(height: 20 * widget.heightFactor),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (int index = 0; index < widget.options.length; index++)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12 * widget.heightFactor),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedOptionIndex = index;
                              });
                            },
                            child: Container(
                              width: 28 * widget.widthFactor,
                              height: 28 * widget.heightFactor,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: selectedOptionIndex == index ? Colors.blue : primaryColor,
                                  width: 2,
                                ),
                              ),
                              child: selectedOptionIndex == index
                                  ? Center(
                                      child: Container(
                                        width: 14 * widget.widthFactor,
                                        height: 14 * widget.heightFactor,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: primaryColor,
                                        ),
                                      ),
                                    )
                                  : null,
                            ),
                          ),
                          SizedBox(width: 20 * widget.widthFactor),
                          Expanded(
                            child: widget.isEditing
                                ? TextField(
                                    controller: _optionControllers[index],
                                    style: GoogleFonts.poppins(
                                      fontSize: 20 * widget.widthFactor,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey,
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    maxLines: null,
                                  )
                                : GestureDetector(
                                    onTap: widget.toggleEditingMode,
                                    child: Text(
                                      widget.options[index]["desc"] ?? "",
                                      style: GoogleFonts.poppins(
                                        fontSize: 20 * widget.widthFactor,
                                        fontWeight: FontWeight.w400,
                                        color: selectedOptionIndex == index ? primaryColor : Colors.grey,
                                      ),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              SizedBox(height: 100 * widget.heightFactor),
              Text(
                "Correct Answer",
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 24 * widget.widthFactor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Divider(
                color: Colors.black,
                thickness: 1.5,
                height: 20 * widget.heightFactor,
              ),
              widget.isEditing
                  ? TextField(
                      controller: _correctAnswerController,
                      style: GoogleFonts.poppins(
                        fontSize: 24 * widget.widthFactor,
                        fontWeight: FontWeight.w500,
                        color: success,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    )
                  : Text(
                      widget.correctAnswer,
                      style: GoogleFonts.poppins(
                        color: success,
                        fontSize: 24 * widget.widthFactor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
              SizedBox(height: 20 * widget.heightFactor),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Explanation: ",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 18 * widget.widthFactor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: widget.isEditing
                        ? TextField(
                            controller: _explanationController,
                            style: GoogleFonts.poppins(
                              fontSize: 18 * widget.widthFactor,
                              fontWeight: FontWeight.w500,
                              color: primaryText,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                            maxLines: null,
                          )
                        : Text(
                            widget.explanation,
                            style: GoogleFonts.poppins(
                              color: primaryText,
                              fontSize: 18 * widget.widthFactor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
