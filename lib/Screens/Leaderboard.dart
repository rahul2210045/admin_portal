import 'package:admin_portal/Screens/loader.dart';
import 'package:admin_portal/Widgets/Custom_Container.dart';
import 'package:admin_portal/Widgets/Graph.dart';
import 'package:admin_portal/constants/constants.dart';
import 'package:admin_portal/screens/leadertabel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
                            child: Container(
                                child: CircularProgressIndicatorWidget())),
                        height: heightFactor * 450,
                        width: widthFactor * 450,
                        padding: EdgeInsets.all(10 * widthFactor),
                        margin: EdgeInsets.only(top: 20 * heightFactor),
                        color: Colors.white,
                      ),
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
                            Expanded(
                              child: Graph(),
                            ),
                          ],
                        ),
                        height: heightFactor * 520,
                        width: widthFactor * 450,
                        padding: EdgeInsets.fromLTRB(
                            20 * widthFactor,
                            30 * widthFactor,
                            20 * widthFactor,
                            40 * widthFactor),
                        margin: EdgeInsets.only(top: 20 * heightFactor),
                        borderRadiusRadius: 5,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  // SizedBox(width: 10 * widthFactor), // Add this line to adjust the space between the columns
                  Expanded(
                    child: CustomRoundedContainer(
                      child: LeaderTabel(),
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
