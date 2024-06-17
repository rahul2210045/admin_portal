import 'package:flutter/material.dart';
import 'package:admin_portal/constants/constants.dart';
import 'package:admin_portal/widgets/custom_container.dart';
import 'package:admin_portal/widgets/graph.dart';
import 'package:google_fonts/google_fonts.dart';

import 'leadertabel.dart'; // Assuming your graph widget is correctly imported

class Leaderboard extends StatefulWidget {
  const Leaderboard({Key? key}) : super(key: key);

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  // Example data for graphs
  final List<String> staticsLabels = [
    '90 or more\nmarks',
    '80 to 90\nmarks',
    '60 to 80\nmarks',
    '40 to 60\nmarks',
    'less than 40\nmarks'
  ];
  final List<double> staticsData = [200, 250, 100, 150, 50];

  final List<String> studentTypesLabels = [
    'Day Scholar\nBoys',
    'Hosteller\nBoys',
    'Day Scholar\nGirls',
    'Hosteller\nGirls'
  ];
  final List<double> studentTypesData = [180, 25, 120, 170];

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
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomRoundedContainer(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Statics",
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 35 * widthFactor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 10 * heightFactor),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: EdgeInsets.only(right: 20 * widthFactor),
                                child: Text(
                                  "Total Marks: 100",
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 12 * widthFactor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 25 * heightFactor),
                            Container(
                              height: heightFactor * 420,
                              width: widthFactor * 450,
                              child: Graph(
                                xLabels: staticsLabels,
                                yData: staticsData,
                              ),
                            ),
                          ],
                        ),
                        height: heightFactor * 650,
                        width: widthFactor * 500,
                        padding: EdgeInsets.fromLTRB(
                          20 * widthFactor,
                          30 * widthFactor,
                          20 * widthFactor,
                          40 * widthFactor,
                        ),
                        margin: EdgeInsets.only(top: 20 * heightFactor),
                        borderRadiusRadius: 5,
                        color: Colors.white,
                      ),
                      SizedBox(height: 20 * heightFactor),
                      CustomRoundedContainer(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Student Types",
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 35 * widthFactor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 60 * heightFactor),
                            Container(
                              height: heightFactor * 420,
                              width: widthFactor * 450,
                              child: Graph(
                                xLabels: studentTypesLabels,
                                yData: studentTypesData,
                              ),
                            ),
                          ],
                        ),
                        height: heightFactor * 650,
                        width: widthFactor * 500,
                        padding: EdgeInsets.fromLTRB(
                          20 * widthFactor,
                          30 * widthFactor,
                          20 * widthFactor,
                          40 * widthFactor,
                        ),
                        margin: EdgeInsets.only(top: 20 * heightFactor),
                        borderRadiusRadius: 5,
                        color: Colors.white,
                      ),
                      SizedBox(height: 20 * heightFactor),

                    ],
                  ),
                  CustomRoundedContainer(
                    child: LeaderTabel(),
                    height: heightFactor * 1340,
                    width: widthFactor * 870,
                    padding: EdgeInsets.all(10 * widthFactor),
                    margin: EdgeInsets.all(20 * widthFactor),
                    color: Color.fromARGB(255, 255, 255, 255),
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
