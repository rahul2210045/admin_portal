import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/constants.dart';

class QuestionArea extends StatefulWidget {
  final String questionNumber;
  final String question;
  final List<String> options;
  final String correctAnswer;
  final String explanation;
  final double heightFactor;
  final double widthFactor;

  const QuestionArea({
    Key? key,
    required this.questionNumber,
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
    required this.heightFactor,
    required this.widthFactor,
  }) : super(key: key);

  @override
  _QuestionAreaState createState() => _QuestionAreaState();
}

class _QuestionAreaState extends State<QuestionArea> {
  bool isEditing = false;
  late TextEditingController _questionController;
  late List<TextEditingController> _optionControllers;
  late TextEditingController _correctAnswerController;
  late TextEditingController _explanationController;

  @override
  void initState() {
    super.initState();
    _questionController = TextEditingController(text: widget.question);
    _optionControllers = List.generate(
      widget.options.length,
          (index) => TextEditingController(text: widget.options[index]),
    );
    _correctAnswerController = TextEditingController(text: widget.correctAnswer);
    _explanationController = TextEditingController(text: widget.explanation);
  }

  @override
  void dispose() {
    _questionController.dispose();
    _optionControllers.forEach((controller) => controller.dispose());
    _correctAnswerController.dispose();
    _explanationController.dispose();
    super.dispose();
  }

  void toggleEditingMode() {
    setState(() {
      isEditing = !isEditing;
    });
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
                  isEditing
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
                    onTap: toggleEditingMode,
                    child: Icon(Icons.edit),
                  ),
                ],
              ),
              SizedBox(height: 20 * widget.heightFactor),

              // Divider between question and options
              Divider(
                color: Colors.black,
                thickness: 1,
                height: 20 * widget.heightFactor,
              ),

              SizedBox(height: 20 * widget.heightFactor),

              // Options
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (int index = 0; index < widget.options.length; index++)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 25 * widget.heightFactor),
                      child: isEditing
                          ? Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _optionControllers[index],
                              style: GoogleFonts.poppins(
                                fontSize: 20 * widget.widthFactor,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      )
                          : Row(
                        children: [
                          Text(
                            widget.options[index],
                            style: GoogleFonts.poppins(
                              fontSize: 20 * widget.widthFactor,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),

              SizedBox(height: 100 * widget.heightFactor),

              // Correct Answer and Explanation
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
              isEditing
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
                    child: isEditing
                        ? TextField(
                      controller: _explanationController,
                      style: GoogleFonts.poppins(
                        fontSize: 18 * widget.widthFactor,
                        fontWeight: FontWeight.w500,
                        color: primaryColor,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      maxLines: null,
                    )
                        : Text(
                      widget.explanation,
                      style: GoogleFonts.poppins(
                        color: primaryColor,
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
