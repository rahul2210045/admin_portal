  import 'package:admin_portal/Widgets/Custom_Container.dart';
  import 'package:admin_portal/Widgets/Graph.dart'; // Import your Graph widget
  import 'package:admin_portal/constants/constants.dart';
  import 'package:flutter/material.dart';
  import 'package:google_fonts/google_fonts.dart';

  class Leaderboard extends StatefulWidget {
    const Leaderboard({Key? key}) : super(key: key);

    @override
    State<Leaderboard> createState() => _LeaderboardState();
  }

  class _LeaderboardState extends State<Leaderboard> {
    // Example data for graphs
    final List<String> staticsLabels = ['90 or more\nmarks', '80 to 90\nmarks', '60 to 80\nmarks', '40 to 60\nmarks', 'less than 40\nmarks'];
    final List<double> staticsData = [200, 250, 100, 150,50];

    final List<String> studentTypesLabels = ['Day Scholar\nBoys', 'Hosteller\nBoys', 'Day Scholar\nGirls', 'Hosteller\nGirls'];
    final List<double> studentTypesData = [180, 25, 120, 90];

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
                              SizedBox(height: 0.1 * heightFactor),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "Total Marks:100",
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 12 * widthFactor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(height: 25 * heightFactor),
                              Expanded(
                                child: Graph(
                                  xLabels: staticsLabels,
                                  yData: staticsData,
                                ),
                              ),
                            ],
                          ),
                          height: heightFactor * 520,
                          width: widthFactor * 450,
                          padding: EdgeInsets.fromLTRB(
                              20 * widthFactor, 30 * widthFactor, 20 * widthFactor, 40 * widthFactor),
                          margin: EdgeInsets.only(top: 20 * heightFactor),
                          borderRadiusRadius: 5,
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
                                child: Graph(
                                  xLabels: studentTypesLabels,
                                  yData: studentTypesData,
                                ),
                              ),
                            ],
                          ),
                          height: heightFactor * 520,
                          width: widthFactor * 450,
                          padding: EdgeInsets.fromLTRB(
                              20 * widthFactor, 30 * widthFactor, 20 * widthFactor, 40 * widthFactor),
                          margin: EdgeInsets.only(top: 20 * heightFactor),
                          borderRadiusRadius: 5,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    SizedBox(width: 10 * widthFactor), // Adjust the space between the columns
                    Expanded(
                      child: CustomRoundedContainer(
                        child: Text("Placeholder for other content"),
                        height: heightFactor * 920,
                        width: widthFactor * 650,
                        padding: EdgeInsets.all(10 * widthFactor),
                        margin: EdgeInsets.all(20 * widthFactor),
                        color: Colors.white,
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
