import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/constants.dart';
import '../Widgets/Custom_Container.dart'; // Assuming you have CustomRoundedContainer widget here
import '../Widgets/questions_sidebar.dart'; // Assuming you have QuestionsSidebar widget here

class QuestionsDownload extends StatelessWidget {
  final List<String> savedQuestions;

  const QuestionsDownload({Key? key, required this.savedQuestions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double heightFactor = MediaQuery.of(context).size.height / 1024;
    double widthFactor = MediaQuery.of(context).size.width / 1440;

    return Scaffold(
      backgroundColor: backgroundColor1,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Container(
              padding: EdgeInsets.all(10),
              width: widthFactor * 1200,
              height: heightFactor * 858,
              color: backgroundColor,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: List.generate(savedQuestions.length, (index) {
                          return Column(
                            children: [
                              QuestionCard(
                                questionNumber: index + 1,
                                questionText: savedQuestions[index],
                              ),
                              SizedBox(height: 16.0 * heightFactor),
                            ],
                          );
                        }),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0 * heightFactor),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                        widthFactor: widthFactor,
                        heightFactor: heightFactor,
                        text: "Back to Edit",
                        icon: Icons.arrow_back, // Specify the back arrow icon
                        onPressed: () {
                          Navigator.pop(context); // Navigate back to the previous screen
                        },
                      ),
                      CustomButton(
                        widthFactor: widthFactor,
                        heightFactor: heightFactor,
                        text: "Download",
                        onPressed: () {
                          // Handle download action
                          _downloadQuestions(savedQuestions);
                        },
                      ),
                      CustomButton(
                        widthFactor: widthFactor,
                        heightFactor: heightFactor,
                        text: "Save",
                        onPressed: () {
                          // Handle save action
                          _saveQuestions(savedQuestions);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _downloadQuestions(List<String> questions) {
    // Implement download logic here
    // For example, you can download as a file or send to an API
    // For demonstration, printing questions to console
    print('Downloading questions: $questions');
  }

  void _saveQuestions(List<String> questions) {
    // Implement save logic here
    // For example, save to local storage or send to an API
    // For demonstration, printing questions to console
    print('Saving questions: $questions');
  }
}

class QuestionCard extends StatelessWidget {
  final int questionNumber;
  final String questionText;

  const QuestionCard({required this.questionNumber, required this.questionText});

  @override
  Widget build(BuildContext context) {
    double widthFactor = MediaQuery.of(context).size.width / 1440;

    return Container(
      width: 1142 * widthFactor,
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(16.0 * widthFactor),
          child: Text(
            'Question $questionNumber\n$questionText',
            style: TextStyle(fontSize: 20.0 * widthFactor),
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final double widthFactor;
  final double heightFactor;
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;

  const CustomButton({
    required this.widthFactor,
    required this.heightFactor,
    required this.text,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widthFactor * 200,
      height: heightFactor * 60,
      child: ElevatedButton(
        onPressed: onPressed,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Icon(
                icon,
                size: widthFactor * 18,
                color: Colors.white,
              ),
            SizedBox(width: 10 * widthFactor),
            Text(
              text,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: widthFactor * 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

