import 'package:admin_portal/Widgets/custom_studentFeedback_listCard.dart';
import 'package:admin_portal/Widgets/feedback_display_fields.dart';
import 'package:admin_portal/Widgets/feedbackpage_button.dart';
import 'package:admin_portal/Widgets/ques_feedback.dart';
import 'package:admin_portal/constants/constants.dart';
import 'package:admin_portal/repository/Feedback_addQues_Repository.dart';
import 'package:admin_portal/repository/feedbackRepository.dart';
import 'package:admin_portal/repository/feedback_details_repository.dart';
import 'package:admin_portal/repository/models/feedbackModel.dart';
import 'package:admin_portal/repository/models/feedback_details_model.dart';
import 'package:flutter/material.dart';
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
  late Future<List<FeedbackDetails>> futureFeedbacks;
  FeedbackDetails? selectedFeedback;
  TextEditingController _searchController = TextEditingController();
   List<FeedbackDetails> filteredFeedbacks = [];

  @override
  void initState() {
    super.initState();
    final repository = FeedbackDetailsRepository(
        baseUrl: 'https://cine-admin-xar9.onrender.com/admin/feedback');
    futureFeedbacks = repository.getFeedbacks();
    futureFeedbacks.then((feedbacks) {
      setState(() {
         filteredFeedbacks = feedbacks;
        selectedFeedback = feedbacks.isNotEmpty ? feedbacks[0] : null;
      });
    });
    // Attach listener to search controller
    _searchController.addListener(_onSearchTextChanged);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchTextChanged() {
    setState(() {
      _filterFeedbacks(_searchController.text);
      // Trigger a rebuild with the updated search text
    });
  }


  void _filterFeedbacks(String query) {
    futureFeedbacks.then((feedbacks) {
      setState(() {
        if (query.isEmpty) {
          filteredFeedbacks = feedbacks;
        } else {
          filteredFeedbacks = feedbacks
              .where((feedback) => feedback.student!.name!
                  .toLowerCase()
                  .contains(query.toLowerCase()))
              .toList();
        }
        if (!filteredFeedbacks.contains(selectedFeedback)) {
          selectedFeedback = filteredFeedbacks.isNotEmpty
              ? filteredFeedbacks[0]
              : null;
        }
      });
    });
  }


  void _selectFeedback(int index) {
    setState(() {
      selectedFeedback = filteredFeedbacks[index];
    });
    
  }

  @override
  Widget build(BuildContext context) {
    if (isEditing == true) {
      return _buildFeedbackEditingPage();
    }
    return _buildFeedbackPage();
  }

  Widget _buildFeedbackEditingPage() {
    TextEditingController _addQuestioncontroller = TextEditingController();
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final repository =
        addFeedbackRepository(baseUrl: 'https://cine-admin-xar9.onrender.com');
    return Scaffold(
      backgroundColor: backgroundColor1,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: backgroundColor,
          ),
          height: screenHeight * 0.80,
          width: screenWidth * 0.82,
          child: Column(
            children: [
              FutureBuilder<List<feedbackModel>>(
                future: feedbackRepository.fetchFeedbackQuestions(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                        height: screenHeight * 0.65,
                        child: Center(child: CircularProgressIndicator()));
                  } else if (snapshot.hasError) {
                    // print(snapshot.error);
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                        child: Text('No feedback questions available'));
                  } else {
                    final questions = snapshot.data!;
                    return Expanded(
                      child: ListView.builder(
                        itemCount: questions.length,
                        itemBuilder: (context, index) {
                          final question = questions[index];
                          return ques_feedback(
                            sequence: (index + 1).toString(),
                            question: question.question ?? 'No Question',
                            
                            onTap: () {
                              
                              print('Question id is'+question.quesId.toString());
                            },
                          );
                        },
                      ),
                    );
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    feedback_button(
                      buttonHeight: screenHeight * 0.06,
                      fontSize: screenWidth * 0.01,
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
                      fontSize: screenWidth * 0.01,
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
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8),
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        feedback_button(
                                          text: "Cancel",
                                          buttonHeight: screenHeight * 0.06,
                                          fontSize: screenWidth * 0.01,
                                          buttonWidth: screenWidth * 0.084,
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        feedback_button(
                                          text: "Add",
                                          buttonHeight: screenHeight * 0.06,
                                          fontSize: screenWidth * 0.01,
                                          buttonWidth: screenWidth * 0.084,
                                          onTap: () async {
                                            AddFeedback feedback =
                                                await repository
                                                    .addFeedbackQuestion(
                                                        _addQuestioncontroller
                                                            .text);
                                            _addQuestioncontroller.clear();
                                            Navigator.of(context).pop();
                                            setState(() {});
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
                  ],
                ),
              ),
            ],
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
                      display_fields(
                          fieldLabel: "Name",
                          content: selectedFeedback?.student?.name ?? "",
                          boxHeight: screenHeight * 0.06,
                          boxWidth: screenWidth * 0.17),
                      display_fields(
                          fieldLabel: "Student No",
                          content:
                              selectedFeedback?.student?.studentNumber ?? "",
                          boxHeight: screenHeight * 0.06,
                          boxWidth: screenWidth * 0.17),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      display_fields(
                          fieldLabel: "Branch",
                          content: selectedFeedback?.student?.branch ?? "",
                          boxHeight: screenHeight * 0.06,
                          boxWidth: screenWidth * 0.17),
                      display_fields(
                          fieldLabel: "Mobile No",
                          content: selectedFeedback?.student?.phone ?? "",
                          boxHeight: screenHeight * 0.06,
                          boxWidth: screenWidth * 0.17),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      display_fields(
                          fieldLabel: "Email",
                          content: selectedFeedback?.student?.email ?? "",
                          boxHeight: screenHeight * 0.06,
                          boxWidth: screenWidth * 0.17),
                      SizedBox(width: screenWidth * 0.17),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      display_fields(
                          fieldLabel: "Feedback",
                          content: selectedFeedback?.response
                                  ?.map((r) => '${r.question}: ${r.ans}')
                                  .join('\n') ??
                              "",
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
                          fontSize: screenWidth * 0.01,
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
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: screenHeight * 0.06,
                        width: screenWidth * 0.25,
                        child: TextField(
                          controller: _searchController,
                          onChanged: (value) {
                            setState(() {}); // Trigger rebuild on text change
                          },
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.search),
                            hintText: "Search Candidate",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  FutureBuilder<List<FeedbackDetails>>(
                    future: futureFeedbacks,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                            height: screenHeight * 0.615,
                            width: screenWidth * 0.25,
                            child: Center(child: CircularProgressIndicator()));
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No feedback found'));
                      }

                      // Filter feedbacks based on search text
                      List<FeedbackDetails> feedbacks = filteredFeedbacks;

                      return SizedBox(
                        height: screenHeight * 0.615,
                        width: screenWidth * 0.25,
                        child: ListView.builder(
                          itemCount: feedbacks.length,
                          itemBuilder: (context, index) {
                            final feedback = feedbacks[index];
                            return feedback_card(
                              studentname: feedback.student?.name ?? 'Unknown',
                              studenNo:
                                  feedback.student?.studentNumber ?? 'Unknown',
                              isSelected: feedback == selectedFeedback,
                              onTap: () {
                                print('Tapped on feedback card: $index');
                                _selectFeedback(index);
                              },
                            );
                          },
                        ),
                      );
                    },
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