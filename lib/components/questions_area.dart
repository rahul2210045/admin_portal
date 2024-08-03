import 'dart:convert';
import 'package:admin_portal/constants/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionArea extends StatefulWidget {
  final String quesId;
  final String subject;
  final String questionNumber;
  final String question;
  final List<Map<String, dynamic>> options;
  final String correctAnswer;
  final String explanation;
  final double heightFactor;
  final double widthFactor;
  final bool isEditing;
  final VoidCallback toggleEditingMode;
  final Function(String question, List<Map<String, dynamic>> options,
      String correctAnswer, String explanation) updateQuestionDetails;

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

  bool _isQuestionValid = true;
  List<bool> _areOptionsValid = [];
  bool _isCorrectAnswerValid = true;

  @override
  void initState() {
    super.initState();
    _questionController = TextEditingController(text: widget.question);
    _optionControllers = List.generate(
      widget.options.length,
      (index) =>
          TextEditingController(text: widget.options[index]['desc'] as String),
    );
    _correctAnswerController =
        TextEditingController(text: widget.correctAnswer);
    _explanationController = TextEditingController(text: widget.explanation);

    _areOptionsValid = List.generate(widget.options.length, (_) => true);
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
          _optionControllers[i].text = widget.options[i]['desc'] as String;
        } else {
          _optionControllers.add(
              TextEditingController(text: widget.options[i]['desc'] as String));
        }
      }
      _areOptionsValid = List.generate(widget.options.length, (_) => true);
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
    final updatedQuestion = _questionController.text.trim();
    final updatedOptions = _optionControllers
        .map((controller) => {
              'desc': controller.text.trim(),
              'id': widget.options[_optionControllers.indexOf(controller)]
                  ['id'],
            })
        .toList();
    final updatedCorrectAnswer = _correctAnswerController.text.trim();
    final updatedExplanation = _explanationController.text.trim();

    setState(() {
      _isQuestionValid = updatedQuestion.isNotEmpty;
      _areOptionsValid = updatedOptions
          .map((option) => option['desc'].isNotEmpty as bool)
          .toList();
      _isCorrectAnswerValid = updatedCorrectAnswer.isNotEmpty &&
          (updatedCorrectAnswer == '1' ||
              updatedCorrectAnswer == '2' ||
              updatedCorrectAnswer == '3' ||
              updatedCorrectAnswer == '4');
    });

    if (_isQuestionValid &&
        _areOptionsValid.every((valid) => valid) &&
        _isCorrectAnswerValid) {
      final response = await http.patch(
        Uri.parse('https://cine-admin-xar9.onrender.com/admin/updateQuestion'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "quesId": widget.quesId,
          "question": updatedQuestion,
          "options": updatedOptions,
          "subject": widget.subject,
          "answer": updatedCorrectAnswer,
          "explanation": updatedExplanation,
        }),
      );

      if (response.statusCode == 200) {
        widget.updateQuestionDetails(
          updatedQuestion,
          updatedOptions,
          updatedCorrectAnswer,
          updatedExplanation,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Updated question successfully."),
            backgroundColor: Colors.grey,
          ),
        );
      } else {
        print('Failed to update question: ${response.statusCode}');
        print('Response: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to update question."),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please fill all required fields correctly."),
          backgroundColor: Colors.red,
        ),
      );
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextField(
                                controller: _questionController,
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 30 * widget.widthFactor,
                                  fontWeight: FontWeight.w400,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                                maxLines: null,
                              ),
                              if (!_isQuestionValid)
                                Text(
                                  "Please enter a question",
                                  style: TextStyle(color: Colors.red),
                                ),
                            ],
                          ),
                        )
                      : Flexible(
                          child: Text(
                            widget.question,
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 30 * widget.widthFactor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                  GestureDetector(
                    onTap: widget.isEditing
                        ? _handleTickIconPressed
                        : widget.toggleEditingMode,
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
                      padding: EdgeInsets.symmetric(
                          vertical: 12 * widget.heightFactor),
                      child: Row(
                        children: [
                          Container(
                            width: 28 * widget.widthFactor,
                            height: 28 * widget.heightFactor,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: widget.correctAnswer ==
                                        widget.options[index]['id']
                                    ? primaryColor
                                    : Colors.black,
                                width: 2,
                              ),
                            ),
                            child: widget.correctAnswer ==
                                    widget.options[index]['id']
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
                          SizedBox(width: 20 * widget.widthFactor),
                          Expanded(
                            child: widget.isEditing
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextField(
                                        controller: _optionControllers[index],
                                        style: GoogleFonts.poppins(
                                          fontSize: 20 * widget.widthFactor,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                        maxLines: null,
                                      ),
                                      if (!_areOptionsValid[index])
                                        Text(
                                          "Please enter an option",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                    ],
                                  )
                                : Text(
                                    widget.options[index]['desc'] as String,
                                    style: GoogleFonts.poppins(
                                      fontSize: 20 * widget.widthFactor,
                                      fontWeight: FontWeight.w400,
                                      color: widget.correctAnswer ==
                                              widget.options[index]['id']
                                          ? primaryColor
                                          : Colors.black,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              SizedBox(height: 20 * widget.heightFactor),
              Text(
                "Correct Answer",
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 20 * widget.widthFactor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Divider(
                color: Colors.black,
                thickness: 1,
                height: 20 * widget.heightFactor,
              ),
              widget.isEditing
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: _correctAnswerController,
                          style: GoogleFonts.poppins(
                            color: success,
                            fontSize: 20 * widget.widthFactor,
                            fontWeight: FontWeight.w400,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          maxLines: null,
                        ),
                        if (!_isCorrectAnswerValid)
                          Text(
                            "Please enter correct option id",
                            style: TextStyle(color: Colors.red),
                          ),
                      ],
                    )
                  : Text(
                      widget.correctAnswer,
                      style: GoogleFonts.poppins(
                        color: success,
                        fontSize: 20 * widget.widthFactor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
              SizedBox(height: 50 * widget.heightFactor),
              Text(
                "Explanation",
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 20 * widget.widthFactor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Divider(
                color: Colors.black,
                thickness: 1,
                height: 20 * widget.heightFactor,
              ),
              widget.isEditing
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: _explanationController,
                          style: GoogleFonts.poppins(
                            color: primaryText,
                            fontSize: 20 * widget.widthFactor,
                            fontWeight: FontWeight.w400,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          maxLines: null,
                        ),
                      ],
                    )
                  : Text(
                      widget.explanation,
                      style: GoogleFonts.poppins(
                        color: primaryText,
                        fontSize: 20 * widget.widthFactor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
