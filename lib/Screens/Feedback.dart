import 'package:admin_portal/Widgets/custom_studentFeedback_listCard.dart';
import 'package:admin_portal/Widgets/feedback_display_fields.dart';
import 'package:admin_portal/Widgets/feedbackpage_button.dart';
import 'package:admin_portal/Widgets/ques_feedback.dart';
import 'package:admin_portal/constants/constants.dart';
import 'package:admin_portal/repository/Feedback_addQues_Repository.dart';
import 'package:admin_portal/repository/feedbackRepository.dart';
import 'package:admin_portal/repository/models/feedbackModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class feedback_page extends StatefulWidget {
  const feedback_page({super.key});

  @override
  State<feedback_page> createState() => _feedback_pageState();
}

bool isEditing = false;
final FeedbackRepository feedbackRepository =
    FeedbackRepository(baseUrl: "https://cine-admin-xar9.onrender.com");

class _feedback_pageState extends State<feedback_page> {
  @override
  Widget build(BuildContext context) {
    if (isEditing == true) {
      return _buildFeedbackEditingPage();
    }
    return _buildFeedbackPage();
  }

  Widget _buildFeedbackEditingPage() {
    TextEditingController _addQuestioncontroller = TextEditingController();
    TextEditingController _addQuestionIDcontroller = TextEditingController();
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final repository =
        addFeedbackRepository(baseUrl: 'https://cine-admin-xar9.onrender.com');
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey[200],
          ),
          height: screenHeight * 0.80,
          width: screenWidth * 0.82,
          child: FutureBuilder<List<feedbackModel>>(
            future: feedbackRepository.fetchFeedbackQuestions(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                print(snapshot.error);
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No feedback questions available'));
              } else {
                final questions = snapshot.data!;
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: questions.length,
                        itemBuilder: (context, index) {
                          final question = questions[index];
                          return ques_feedback(
                            sequence: (index + 1).toString(),
                            question: question.question ?? 'No Question',
                          );
                        },
                      ),
                    ),
                    
                  

                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          feedback_button(
                            buttonHeight: screenHeight * 0.06,
                            buttonWidth: screenWidth * 0.15,
                            text: "Back to feedback",
                            onTap: () {
                              setState(() {
                                isEditing = false;
                              });
                            },
                          ),
                          SizedBox(
                            width: screenWidth * 0.15,
                          ),
                          feedback_button(
                            text: "Add +",
                            buttonHeight: screenHeight * 0.06,
                            buttonWidth: screenWidth * 0.1,
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.grey[200],
                                    content: SizedBox(
                                      height: screenHeight * 0.4,
                                      width: screenWidth * 0.4,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        mainAxisSize: MainAxisSize
                                            .min, 
                                        children: [
                                          Padding(
                                            padding:EdgeInsets.symmetric(vertical:8),
                                            child: TextField(
                                              controller: _addQuestioncontroller,
                                              decoration: InputDecoration(
                                                hintText: " Question",
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(8)),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:EdgeInsets.symmetric(vertical:8),
                                            child: TextField(
                                              keyboardType: TextInputType
                                                  .number, 
                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .digitsOnly // Accepts only digits
                                              ],
                                              controller:
                                                  _addQuestionIDcontroller,
                                              decoration: InputDecoration(
                                                hintText: " Question ID ",
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(8)),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              feedback_button(
                                                text: "Cancel",
                                                buttonHeight: screenHeight * 0.05,
                                                buttonWidth: screenWidth * 0.074,
                                                onTap: () {
                                                  Navigator.of(context)
                                                      .pop(); 
                                                },
                                              ),
                                              feedback_button(
                                                text: "Add",
                                                buttonHeight: screenHeight * 0.05,
                                                buttonWidth: screenWidth * 0.07,
                                                onTap: () async {
                                                  AddFeedback feedback =
                                                      await repository
                                                          .addFeedbackQuestion(
                                                              _addQuestioncontroller
                                                                  .text,
                                                              _addQuestionIDcontroller
                                                                  .text);
                                                  _addQuestioncontroller.clear();
                                                  _addQuestionIDcontroller
                                                      .clear();
                                                  Navigator.of(context)
                                                      .pop(); 
                                                      setState(() {
                                                  
                                                      });
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    title: Text(
                                      "Add Question",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                          feedback_button(
                              text: "Save",
                              buttonHeight: screenHeight * 0.06,
                              buttonWidth: screenWidth * 0.1),
                        ],
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildFeedbackPage() {
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
                            setState(() {
                              isEditing = true;
                            });
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
