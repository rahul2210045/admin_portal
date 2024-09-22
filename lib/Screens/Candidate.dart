import 'package:admin_portal/Widgets/Custom_Container.dart';
import 'package:admin_portal/Widgets/student_details_card_new.dart';
import 'package:admin_portal/components/custom_button.dart';
import 'package:admin_portal/constants/constants.dart';
import 'package:admin_portal/models/get_student_data_model.dart';
import 'package:admin_portal/repository/get_student_repository.dart';
import 'package:admin_portal/repository/search_repository.dart';
import 'package:admin_portal/repository/search_student_num_repo.dart';
import 'package:admin_portal/screens/candidate_add.dart';
import 'package:flutter/material.dart';
import 'package:admin_portal/Widgets/Screensize.dart';
import 'dart:async';

class candidate extends StatefulWidget {
  const candidate({super.key});

  @override
  State<candidate> createState() => _candidateState();
}

class _candidateState extends State<candidate> {
  String selectedCategory = 'Day Scholar Boys';
  late Future<List<GetStudentDataModel>> futureStudents;
  final StudentRepository studentRepository = StudentRepository();
  final StudentSearchRepository studentSearchRepository = StudentSearchRepository();
  final StudentNoSearchRepository studentNoSearchRepository = StudentNoSearchRepository();
  final TextEditingController searchController = TextEditingController();
  int currentPage = 1;
  bool hasMorePages = true;
  Timer? _debounce;
  @override
  void initState() {
    super.initState();
    futureStudents = studentRepository.fetchStudents(currentPage);
    searchController.addListener(_onSearchChanged);
  }
   @override
  void dispose() {
    _debounce?.cancel(); // Cancel the timer if active
    searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
  if (_debounce?.isActive ?? false) _debounce?.cancel();

  _debounce = Timer(const Duration(seconds: 2), () {
    final searchText = searchController.text;

    if (searchText.isNotEmpty) {
      if (RegExp(r'^[0-9]').hasMatch(searchText)) {
        // If search starts with a number, call studentNoSearchRepository
        setState(() {
          futureStudents = studentNoSearchRepository.fetchStudents(searchText);
        });
      } else {
        // If search starts with a character, call studentSearchRepository
        setState(() {
          futureStudents = studentSearchRepository.fetchStudents(searchText);
        });
      }
    } else {
      _fetchStudents(); // Fetch all students if search is cleared
    }
  });
}

  //  void _onSearchChanged() {
  //   if (_debounce?.isActive ?? false) _debounce?.cancel();

  //   _debounce = Timer(const Duration(seconds: 2), () {
  //     if (searchController.text.isNotEmpty) {
  //       setState(() {
  //         futureStudents = studentSearchRepository.fetchStudents(searchController.text);
  //       });
  //     } else {
  //       _fetchStudents(); // Fetch all students if search is cleared
  //     }
  //   });
  // }
 void _fetchStudents() {
    setState(() {
      futureStudents = studentRepository.fetchStudents(currentPage);
    });
  }
  void updateStudentList() {
    setState(() {
      futureStudents = studentRepository.fetchStudents(currentPage);
    });
  }
   void _prevPage() {
    if (currentPage > 1) {
      setState(() {
        currentPage--;
        _fetchStudents();
      });
    }
  }
   
    void _nextPage() async {
    // Check if the next page has data to decide whether to increment the page
    List<GetStudentDataModel> nextStudents =
        await studentRepository.fetchStudents(currentPage + 1);

    if (nextStudents.isNotEmpty) {
      currentPage++;
      _fetchStudents();
    }
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
                                        horizontal: 22.0, vertical: 7),
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
                                          List<GetStudentDataModel> filteredStudents = snapshot.data!;
                                          if (searchController.text.isEmpty) {
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
                                          // Apply filter based on selected category for student API
                                            filteredStudents = snapshot.data!.where((student) {
                                              return student.residency == residency &&
                                                  student.gender == gender;
                                            }).toList();
                                          }

                                          if (filteredStudents.isEmpty) {
                                            return Center(child: Text('No students found'));
                                          }
                                //           List<GetStudentDataModel>
                                //               filteredStudents =
                                //               snapshot.data!.where((student) {
                                //             if (searchController
                                //                 .text.isNotEmpty) {
                                //               return student.studentNumber!
                                //                   .contains(
                                //                       searchController.text);
                                //             }
                                //             return student.residency ==
                                //                     residency &&
                                //                 student.gender == gender;
                                //           }).toList();
                                //              print("Filtered Students: ${filteredStudents.length}");
                                // print("Filtered Data: ${filteredStudents.map((e) => e.name).toList()}");
                                //           if (filteredStudents.isEmpty) {
                                //             return Center(
                                //                 child:
                                //                     Text('No students found'));
                                //           }

                                          return ListView.builder(
                                            shrinkWrap: true,
                                            primary: false,
                                            itemCount: filteredStudents.length,
                                            itemBuilder: (context, index) {
                                              final student =
                                                  filteredStudents[index];
                                              return StudentDetailCardNew(
                                                studentName: "${student.name}",
                                                studentNo:
                                                    "${student.studentNumber}",
                                                branch: "${student.branch}",
                                              );
                                              // student_detail_card(
                                              //   studentname: "${student.name}",
                                              //   studenNo:
                                              //       "${student.studentNumber}",
                                              // );
                                            },
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomButton(
                                  widthFactor: widthFactor,
                                  heightFactor: heightFactor,
                                  text: "Prev",
                                  onPressed: _prevPage,
                                  icon: Icons.arrow_back_ios_new_rounded),
                              CustomButton(
                                widthFactor: widthFactor,
                                heightFactor: heightFactor,
                                text: "Next",
                                onPressed: _nextPage,
                              )
                            ],
                          ),
                        ),
                            ],
                          ),
                        ),
                      ),
                      height: heightFactor * 950,
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 30.0),
                                    child: SizedBox(
                                      height: heightFactor * 80,
                                      child: TextField(
                                        controller: searchController,
                                        decoration: InputDecoration(
                                          hintText: 'Search Student Number',
                                          hintStyle: TextStyle(
                                              color: Colors.grey.shade400,
                                              fontSize: 14),
                                          suffixIcon: Icon(
                                            Icons.search,
                                            size: 30,
                                            color: Colors.black,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
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
                                          MainAxisAlignment.center,
                                      children: [
                                        _buildBottomButton2('Add+'),
                                        // _buildBottomButton('Search'),
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Container(
          // height: 45,
          // margin: const EdgeInsets.only(bottom: 8.0),
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          decoration: BoxDecoration(
            color: isSelected ? Color(0xFF546CFF) : Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: isSelected ? Colors.transparent : Colors.grey.shade400,
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
          // '/candidateAdd',
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
