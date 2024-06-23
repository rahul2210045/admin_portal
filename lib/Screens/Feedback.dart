import 'package:admin_portal/Screens/feedback_ques.dart';
import 'package:admin_portal/Widgets/Screensize.dart';
import 'package:admin_portal/Widgets/custom_studentFeedback_listCard.dart';
import 'package:admin_portal/Widgets/feedback_display_fields.dart';
import 'package:admin_portal/Widgets/feedbackpage_button.dart';
import 'package:admin_portal/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class feedback_page extends StatefulWidget {
  const feedback_page({super.key});

  @override
  State<feedback_page> createState() => _feedback_pageState();
}

class _feedback_pageState extends State<feedback_page> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backgroundColor1,
      body: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.025,
                horizontal: screenWidth * 0.006),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: backgroundColor,
              ),
              width: screenWidth * 0.54,
              height: screenHeight * 0.82,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // first display field
                      display_fields(
                          fieldLabel: "Name",
                          content: "Anshika Singh",
                          boxHeight: screenHeight * 0.06,
                          boxWidth: screenWidth * 0.17),

                      // second display field
                      display_fields(
                          fieldLabel: "Student No",
                          content: "2210187",
                          boxHeight: screenHeight * 0.06,
                          boxWidth: screenWidth * 0.17),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //first box
                      display_fields(
                          fieldLabel: "Branch",
                          content: "CSE",
                          boxHeight: screenHeight * 0.06,
                          boxWidth: screenWidth * 0.17),

                      //second box
                      display_fields(
                          fieldLabel: "Mobile No",
                          content: "9898989898",
                          boxHeight: screenHeight * 0.06,
                          boxWidth: screenWidth * 0.17),
                    ],
                  ),

                  //second box
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      display_fields(
                          fieldLabel: "Email",
                          content: "anshika@gmail.com",
                          boxHeight: screenHeight * 0.06,
                          boxWidth: screenWidth * 0.17),
                      SizedBox(width: screenWidth * 0.17),
                    ],
                  ),
                  //second box

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      display_fields(
                          fieldLabel: "Feedback",
                          content: "",
                          boxHeight: screenHeight * 0.2,
                          boxWidth: screenWidth * 0.41),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.01),
                        child: feedback_button(
                          text: "Edit feedback questions",
                          buttonHeight: screenHeight * 0.06,
                          buttonWidth: screenWidth * 0.2,
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>edit_ques()));
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.025,
                horizontal: screenWidth * 0.006),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: backgroundColor,
              ),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      color: primaryColor,
                    ),
                    child: Center(
                        child: Text(
                      "Feedback",
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontSize: 20),
                    )),
                    height: screenHeight * 0.08,
                    width: screenWidth * 0.28,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //search box inserted
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Colors.grey.shade600,
                          ),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade100,
                              blurRadius: 100.0,
                              offset: Offset(1.0, 1.0),
                            )
                          ],
                        ),
                        height: screenHeight * 0.06,
                        width: screenWidth * 0.25,
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            suffix: const Icon(
                              Icons.search_rounded,
                              color: Colors.black,
                            ),
                            labelText: "Search something here...",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: dividerColor,
                                ),
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                      ),
                    ],
                  ), //search box done

                  SizedBox(
                    width: screenWidth * 0.25,
                    child: SingleChildScrollView(
                      child: Column(children: [
                        feedback_card(
                            studentname: "Ashirwad", studenNo: "2210647"),
                        feedback_card(
                            studentname: "Ashirwad", studenNo: "2210647"),
                        feedback_card(
                            studentname: "Ashirwad", studenNo: "2210647"),
                      ]),
                    ),
                  ),
                ],
              ),
              width: screenWidth * 0.28,
              height: screenHeight * 0.82,
            ),
          ),
        ],
      ),
    );
  }
}
