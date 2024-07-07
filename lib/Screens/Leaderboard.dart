import 'dart:convert';
import 'package:admin_portal/Widgets/Graph.dart';
import 'package:admin_portal/constants/constants.dart';
import 'package:admin_portal/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'leadertabel.dart'; // Assuming your graph widget is correctly imported

class Leaderboard extends StatefulWidget {
  const Leaderboard({Key? key}) : super(key: key);

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  final List<String> staticsLabels = [
    '90 or more\nmarks',
    '80 to 90\nmarks',
    '60 to 80\nmarks',
    '40 to 60\nmarks',
    'less than 40\nmarks'
  ];
  final List<double> staticsData = [200, 250, 100, 150, 50];

  List<String> studentTypesLabels = [
    'Day Scholar\nBoys',
    'Hosteller\nBoys',
    'Day Scholar\nGirls',
    'Hosteller\nGirls'
  ];
  List<double> studentTypesData = [0, 0, 0, 0];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchStudentTypesData();
  }

  Future<void> fetchStudentTypesData() async {
    final url = Uri.parse('https://cine-admin-xar9.onrender.com/admin/getStudentTypes');
    print('Fetching student types data from $url');
    try {
      final response = await http.get(url);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Decoded data: $data');
        setState(() {
          studentTypesData = [
            data['boysDayScholar'].toDouble(),
            data['boysHostel'].toDouble(),
            data['girlsDayScholar'].toDouble(),
            data['girlsHostel'].toDouble(),
          ];
          isLoading = false;
          print('Updated studentTypesData: $studentTypesData');
        });
      } else {
        // Handle the error
        print('Failed to load data. Status code: ${response.statusCode}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      // Handle the error
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Building Leaderboard widget');
    return Scaffold(
      backgroundColor: backgroundColor1,
      body: LayoutBuilder(
        builder: (context, constraints) {
          double heightFactor = constraints.maxHeight / 1024;
          double widthFactor = constraints.maxWidth / 1440;

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10 * widthFactor),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                                    fontSize: 14 * widthFactor,
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
                        height: heightFactor * 660,
                        width: widthFactor * 500,
                        padding: EdgeInsets.fromLTRB(
                          20 * widthFactor,
                          30 * heightFactor,
                          20 * widthFactor,
                          40 * heightFactor,
                        ),
                        margin: EdgeInsets.only(top: 20 * heightFactor),
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
                              child: isLoading
                                  ? Center(child: CircularProgressIndicator())
                                  : Graph(
                                xLabels: studentTypesLabels,
                                yData: studentTypesData,
                              ),
                            ),
                          ],
                        ),
                        height: heightFactor * 660,
                        width: widthFactor * 500,
                        padding: EdgeInsets.fromLTRB(
                          20 * widthFactor,
                          30 * heightFactor,
                          20 * widthFactor,
                          40 * heightFactor,
                        ),
                        margin: EdgeInsets.only(top: 20 * heightFactor),
                        color: Colors.white,
                      ),
                      SizedBox(height: 20 * heightFactor),
                    ],
                  ),
                  SizedBox(width: 20 * widthFactor),
                  Flexible(
                    child: CustomRoundedContainer(
                      child: LeaderTabel(),
                      height: heightFactor * 1360,
                      width: widthFactor * 870,
                      padding: EdgeInsets.all(10 * heightFactor),
                      margin: EdgeInsets.all(20 * heightFactor),
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
