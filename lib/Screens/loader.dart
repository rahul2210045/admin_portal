import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Circular Progress Indicator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Progress Indicator'),
        ),
        body: Center(
          child: CircularProgressIndicatorWidget(),
        ),
      ),
    );
  }
}

class CircularProgressIndicatorWidget extends StatelessWidget {
  final int totalStudents = 500;
  final int studentsTakenExam = 344;
  final int studentsNotTakenExam = 150;

  @override
  Widget build(BuildContext context) {
    double takenExamPercentage = studentsTakenExam / totalStudents;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            CircularPercentIndicator(
              radius: 160.0,
              lineWidth: 38.0,
              percent: takenExamPercentage,
              center: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    totalStudents.toString(),
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Total Student",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              progressColor: Colors.blue,
              backgroundColor: Colors.blue.shade100,
              circularStrokeCap: CircularStrokeCap.round,
            ),
            Positioned(
              top: 40,
              left: 25,
              child: Text(
                studentsNotTakenExam.toString(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade600,
                ),
              ),
            ),
            Positioned(
              bottom: 44,
              right: 20,
              child: Text(
                studentsTakenExam.toString(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[100],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.fromLTRB(60, 20, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Indicator(
                color: Colors.blue,
                text: "Student Taken Exam",
                percentage: takenExamPercentage * 100,
              ),
              SizedBox(width: 20),
              Indicator(
                color: Colors.blue[100]!,
                text: "Student Not Taken Exam",
                percentage: (1 - takenExamPercentage) * 100,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final double percentage;

  const Indicator({
    Key? key,
    required this.color,
    required this.text,
    required this.percentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          color: color,
        ),
        SizedBox(width: 5),
        Text(
          "$text ${percentage.toStringAsFixed(0)}%",
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
