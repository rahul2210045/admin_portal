import 'package:flutter/material.dart';

class QuizComponent extends StatelessWidget {
  final String question;
  final List<String> options;
  final String correctAnswer;
  final String explanation;

  QuizComponent({
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Question-1',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              question,
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 20),
            ...options.map((option) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    Radio(
                      value: option,
                      groupValue: correctAnswer,
                      onChanged: (value) {},
                    ),
                    Text(option),
                  ],
                ),
              );
            }).toList(),
            SizedBox(height: 20),
            Divider(),
            Text(
              'Correct Answer',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(correctAnswer),
            SizedBox(height: 10),
            Text(
              'Explanation: $explanation',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
