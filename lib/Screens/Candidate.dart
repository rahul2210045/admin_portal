import 'package:admin_portal/Screens/loader.dart';
import 'package:admin_portal/Widgets/Custom_Container.dart';
import 'package:admin_portal/Widgets/Graph.dart';
import 'package:admin_portal/Widgets/custom_studentFeedback_listCard.dart';
import 'package:admin_portal/Widgets/student_detail_card.dart';
import 'package:admin_portal/components/custom_candidate_detail_card.dart';
import 'package:admin_portal/components/custom_inputfield.dart';
import 'package:admin_portal/components/registered_candidate_card.dart';
import 'package:admin_portal/constants/constants.dart';
import 'package:admin_portal/models/get_student_data_model.dart';
import 'package:admin_portal/repository/get_student_repository.dart';
import 'package:admin_portal/screens/candidate_add.dart';
import 'package:admin_portal/screens/leadertabel.dart';
import 'package:admin_portal/screens/register.dart';
import 'package:admin_portal/screens/registered_candidates.dart';
import 'package:admin_portal/screens/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class candidate extends StatefulWidget {
  const candidate({super.key});

  @override
  State<candidate> createState() => _candidateState();
}

class _candidateState extends State<candidate> {
  String selectedCategory = 'Day Scholar Boys';
  late Future<List<GetStudentDataModel>> futureStudents;
  final StudentRepository studentRepository = StudentRepository();
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureStudents = studentRepository.fetchStudents();
  }

  void updateStudentList() {
    setState(() {
      futureStudents = studentRepository.fetchStudents();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
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
                  Flexible(
                    child: CustomRoundedContainer(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                  color: primaryColor,
                                ),
                                width: widthFactor * 860,
                                height: 45,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "  Registered Candidate's",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 10),
                                child: Container(
                                  width: widthFactor * 860,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade500,
                                        blurRadius: 10.0,
                                        spreadRadius: 0.5,
                                        offset: Offset(1.0, 1.0),
                                      )
                                    ],
                                    color: Colors.white,
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Student Name",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "Student No.",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "Branch",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    FutureBuilder<List<GetStudentDataModel>>(
                                      future: futureStudents,
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Center(
                                              child:
                                                  CircularProgressIndicator());
                                        } else if (snapshot.hasError) {
                                          return Center(
                                              child: Text(
                                                  'Error: ${snapshot.error}'));
                                        } else if (!snapshot.hasData ||
                                            snapshot.data!.isEmpty) {
                                          return Center(
                                              child: Text('No students found'));
                                        } else {
                                          String residency;
                                          String gender;
                                          switch (selectedCategory) {
                                            case 'Hosteller Boys':
                                              residency = 'Hostel';
                                              gender = 'Male';
                                              break;
                                            case 'Day Scholar Boys':
                                              residency = 'Day Scholar';
                                              gender = 'Male';
                                              break;
                                            case 'Hosteller Girls':
                                              residency = 'Hostel';
                                              gender = 'Female';
                                              break;
                                            case 'Day Scholar Girls':
                                              residency = 'Day Scholar';
                                              gender = 'Female';
                                              break;
                                            default:
                                              residency = '';
                                              gender = '';
                                          }

                                          List<GetStudentDataModel>
                                              filteredStudents =
                                              snapshot.data!.where((student) {
                                            if (searchController
                                                .text.isNotEmpty) {
                                              return student.studentNumber!
                                                  .contains(
                                                      searchController.text);
                                            }
                                            return student.residency ==
                                                    residency &&
                                                student.gender == gender;
                                          }).toList();

                                          if (filteredStudents.isEmpty) {
                                            return Center(
                                                child:
                                                    Text('No students found'));
                                          }

                                          return ListView.builder(
                                            shrinkWrap: true,
                                            primary: false,
                                            itemCount: filteredStudents.length,
                                            itemBuilder: (context, index) {
                                              final student =
                                                  filteredStudents[index];
                                              return student_detail_card(
                                                studentname: "${student.name}",
                                                studenNo:
                                                    "${student.studentNumber}",
                                              );
                                            },
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      height: heightFactor * 1360,
                      width: widthFactor * 870,
                      padding: EdgeInsets.all(10 * heightFactor),
                      margin: EdgeInsets.all(20 * heightFactor),
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: backgroundColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: Column(
                          children: [
                            Container(
                              height: screenHeight * 0.75,
                              width: screenWidth * 0.28,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 16.0),
                                    child: TextField(
                                      controller: searchController,
                                      decoration: InputDecoration(
                                        hintText: 'Search Student Number',
                                        prefixIcon: Icon(Icons.search),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: screenHeight * 0.48,
                                    width: screenWidth * 0.28,
                                    child: ListView(
                                      children: [
                                        _buildCategoryItem('Hosteller Boys'),
                                        _buildCategoryItem('Day Scholar Boys'),
                                        _buildCategoryItem('Day Scholar Girls'),
                                        _buildCategoryItem('Hosteller Girls'),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 16.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        _buildBottomButton2('Add+'),
                                        _buildBottomButton('Search'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      width: screenWidth * 0.28,
                      height: screenHeight * 0.82,
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

  Widget _buildCategoryItem(String category) {
    bool isSelected = selectedCategory == category;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = category;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF546CFF) : Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.grey,
            width: 1.0,
          ),
        ),
        child: Text(
          category,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomButton(String text) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF546CFF),
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onPressed: () {
        updateStudentList();
      },
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
    );
  }

  Widget _buildBottomButton2(String text) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF546CFF),
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => candidateAdd()),
        );
      },
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
    );
  }
}
