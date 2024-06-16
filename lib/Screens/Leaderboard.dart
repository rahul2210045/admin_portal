import 'package:admin_portal/Screens/loader.dart';
import 'package:admin_portal/Widgets/Custom_Container.dart';
import 'package:admin_portal/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Leaderboard extends StatefulWidget {
  const Leaderboard({super.key});

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor1,
      body: LayoutBuilder(
        builder: (context, constraints) {
          double heightFactor = constraints.maxHeight / 1024;
          double widthFactor = constraints.maxWidth / 1440;

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(15 * widthFactor),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      CustomRoundedContainer(
                        child: SingleChildScrollView(
                            child: CircularProgressIndicatorWidget()),
                        height: heightFactor * 450,
                        width: widthFactor * 450,
                        padding: EdgeInsets.all(10 * widthFactor),
                        margin: EdgeInsets.only(top: 20 * heightFactor),
                        color: Colors.white,
                      ),
                      CustomRoundedContainer(
                        child: Text("hjgfegfyuegf"),
                        height: heightFactor * 450,
                        width: widthFactor * 450,
                        padding: EdgeInsets.all(10 * widthFactor),
                        margin: EdgeInsets.only(top: 20 * heightFactor),
                        color: Colors.white,
                      ),
                    ],
                  ),
                  SizedBox(
                      width: 10 *
                          widthFactor), // Add this line to adjust the space between the columns
                  Expanded(
                    child: CustomRoundedContainer(
                      child: Text("hjgfegfyuegf"),
                      height: heightFactor * 920,
                      width: widthFactor * 650,
                      padding: EdgeInsets.all(10 * widthFactor),
                      margin: EdgeInsets.all(20 * widthFactor),
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CircularProgressIndicatorWidget extends StatelessWidget {
  final int totalStudents = 500;
  final int studentsTakenExam = 350;
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
              radius: 120.0,
              lineWidth: 20.0,
              percent: takenExamPercentage,
              center: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    totalStudents.toString(),
                    style: const TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
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
              top: 20,
              left: 20,
              child: Text(
                studentsNotTakenExam.toString(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
            Positioned(
              bottom: 20,
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
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
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
