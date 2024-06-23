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
  int selectedOptionIndex = -1; // Track the index of the selected option

  @override
  Widget build(BuildContext context) {
    return Padding(
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
          Text(
            widget.question,
            style: GoogleFonts.poppins(
              color: primaryText,
              fontSize: 30 * widget.widthFactor,
              fontWeight: FontWeight.w400,
            ),
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
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedOptionIndex = index; // Update selected index on tap
                          });
                        },
                        child: Container(
                          width: 28 * widget.widthFactor, // Adjust radio button size
                          height: 28 * widget.heightFactor,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: selectedOptionIndex == index ? primaryColor : Colors.blue, // Adjust border color based on selection
                              width: 2,
                            ),
                          ),
                          child: selectedOptionIndex == index
                              ? Center(
                            child: Container(
                              width: 18 * widget.widthFactor, // Adjust selected indicator size
                              height: 18 * widget.heightFactor,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: primaryColor, // Selected indicator color
                              ),
                            ),
                          )
                              : null,
                        ),
                      ),
                      SizedBox(width: 20 * widget.widthFactor),
                      Text(
                        widget.options[index],
                        style: GoogleFonts.poppins(
                          fontSize: 20 * widget.widthFactor,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey, // Grey text color
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          SizedBox(height: 150 * widget.heightFactor),

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
          Text(
            widget.correctAnswer,
            style: GoogleFonts.poppins(
              color: success,
              fontSize: 24 * widget.widthFactor,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 20 * widget.heightFactor),
          Text(
            "Explanation: ${widget.explanation}",
            style: GoogleFonts.poppins(
              color: Colors.blue, // Blue text color for explanation
              fontSize: 18 * widget.widthFactor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
