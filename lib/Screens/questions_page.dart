import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Widgets/Custom_Container.dart';
import '../Widgets/questions_sidebar.dart';
import '../components/questions_area.dart';
import '../constants/constants.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({Key? key}) : super(key: key);

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  bool isEditing = false;
  int selectedIndex = 0;
  int selectedQuestionIndex = 0;
  int editingQuestionIndex = -1; // Track the index of the question being edited

  List<String> currentQuestions = [];
  List<List<String>> currentOptions = [];
  List<String> currentCorrectAnswers = [];
  List<String> currentExplanations = [];
  List<String> currentQuestionIds = [];

  bool isLoading = true;
  bool isError = false;
  bool isAddingTab = false;

  late http.Client client;

  List<String> tabs = ["Java", "ADD+"];
  Map<String, List<dynamic>> subjectData = {};
  Map<String, List<String>> allQuestions = {};
  Map<String, List<List<String>>> allOptions = {};
  Map<String, List<String>> allCorrectAnswers = {};
  Map<String, List<String>> allExplanations = {};

  @override
  void initState() {
    super.initState();
    client = http.Client();
    fetchData(tab: tabs[selectedIndex]);
  }

  @override
  void dispose() {
    client.close();
    super.dispose();
  }

  Future<void> saveQuestionIds(List<String> questionIds) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('questionIds', questionIds);
    // print('Question IDs saved: $questionIds'); // Print the saved question IDs
  }

  Future<List<String>> getQuestionIds() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> questionIds = prefs.getStringList('questionIds') ?? [];
    // // print(
    //     'Stored question IDs: $questionIds'); // Print the retrieved question IDs
    return questionIds;
  }

  Future<void> addNewSubject(String newSubject) async {
    setState(() {
      tabs.insert(tabs.length - 1, newSubject);
      allQuestions[newSubject] = [];
      allOptions[newSubject] = [];
      allCorrectAnswers[newSubject] = [];
      allExplanations[newSubject] = [];
      selectedIndex = tabs.indexOf(newSubject);
      selectedQuestionIndex = 0;
      isLoading = false;
      isError = false;
    });
  }


  Future<void> fetchData({required String tab}) async {
    final apiUrl = 'https://cine-admin-xar9.onrender.com/admin/questions';

    try {
      final response = await client.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData[tab] != null) {
          parseData(jsonData, tab);
          tabs = jsonData.keys.where((key) => key != 'ADD+').toList();
          tabs.add('ADD+'); // Add the "ADD+" option at the end
          subjectData = Map.from(jsonData);
          isLoading = false;
          print('RESPONSE IS $tabs');
        } else if (tab != "ADD+") {
          // Tab not found in API response and is not the ADD+ tab
          setState(() {
            allQuestions[tab] = [];
            allOptions[tab] = [];
            allCorrectAnswers[tab] = [];
            allExplanations[tab] = [];
            updateCurrentState(tab);
          });
        } else {
          setErrorState();
        }
      } else {
        setErrorState();
      }
    } catch (e) {
      debugPrint('Exception while fetching questions: $e');
      setErrorState();
    }
  }

  void deleteQuestion(int index) {
    if (index >= 0 && index < currentQuestionIds.length) {
      print('Question ID: ${currentQuestionIds[index]}');
    }
    ;
    client = http.Client();
    fetchData(tab: tabs[selectedIndex]);
    // setState(() {
    //   String category = tabs[selectedIndex];
    //   if (index >= 0 && index < currentQuestions.length) {
    //     currentQuestions.removeAt(index);
    //     currentOptions.removeAt(index);
    //     currentCorrectAnswers.removeAt(index);
    //     currentExplanations.removeAt(index);
    //     adjustSelectedQuestionIndex(index);

    //     // Update the global maps
    //     allQuestions[category] = List.from(currentQuestions);
    //     allOptions[category] = List.from(currentOptions);
    //     allCorrectAnswers[category] = List.from(currentCorrectAnswers);
    //     allExplanations[category] = List.from(currentExplanations);

    //     // Check if there are no questions left
    //     if (currentQuestions.isEmpty) {
    //       selectedQuestionIndex = 0;
    //     } else if (selectedQuestionIndex >= currentQuestions.length) {
    //       selectedQuestionIndex = currentQuestions.length - 1;
    //     }
    //   }
    // });
  }

  void parseData(Map<String, dynamic> jsonData, String tab) {
    if (jsonData[tab] != null) {
      List<String> questions = [];
      List<List<String>> options = [];
      List<String> correctAnswers = [];
      List<String> explanations = [];
      List<String> questionIds = [];

      for (var item in jsonData[tab]) {
        questions.add(item['question'].toString());
        List<String> parsedOptions = [];

        for (var option in item['options']) {
          String desc = option['desc'].toString();
          parsedOptions.add(desc); // Add only the 'desc' to the list
          // print('Option: id=${option['id']}, desc=$desc'); // Print option details
        }
        options.add(parsedOptions);
        correctAnswers.add(item['answer'].toString());
        explanations.add('');

        if (item.containsKey('_id')) {
          questionIds
              .add(item['_id'].toString()); // Add question ID to the list
        } else {
          questionIds.add('null');
          // print('_id missing for item: $item');
        }
      }

      saveQuestionIds(questionIds).then((_) {
        getQuestionIds().then((savedIds) {
          // print('Question IDs saved: $savedIds');
        });
      });

      setState(() {
        allQuestions[tab] = questions;
        allOptions[tab] = options; // Store options as List<List<String>>
        allCorrectAnswers[tab] = correctAnswers;
        allExplanations[tab] = explanations;

        if (tab == tabs[selectedIndex]) {
          updateCurrentState(tab);
        }
      });
    } else {
      setErrorState();
    }
  }

  void updateCurrentState(String tab) {
    setState(() {
      currentQuestions = allQuestions[tab] ?? [];
      currentOptions = allOptions[tab] ?? [];
      currentCorrectAnswers = allCorrectAnswers[tab] ?? [];
      currentExplanations = allExplanations[tab] ?? [];
      isLoading = false;
      isError = false;
    });
  }


  void setErrorState() {
    setState(() {
      isError = true;
      isLoading = false;
    });
  }

  void updateQuestionIndex(int index) {
    setState(() {
      selectedQuestionIndex = index;
    });
  }

  void adjustSelectedQuestionIndex(int index) {
    if (selectedQuestionIndex == index) {
      selectedQuestionIndex = 0;
    } else if (selectedQuestionIndex > index) {
      selectedQuestionIndex--;
    }
  }

  void saveQuestions(List<String> updatedQuestions) {
    setState(() {
      currentQuestions = List.from(updatedQuestions);
    });
  }

  Future<void> addNewQuestion(String question, List<String> options,
      String correctAnswer, String description, String questionId) async {
    setState(() {
      currentQuestions.add(question);
      currentOptions.add(options);
      currentCorrectAnswers.add(correctAnswer);
      currentExplanations.add(description);
      selectedQuestionIndex = currentQuestions.length - 1;
    });

    // Get the current tab (subject)
    String subject = tabs[selectedIndex];

    // Make API call to add question
    //   final apiUrl = 'http://localhost:3000/admin/addQuestion';
    //   final response = await http.post(
    //     Uri.parse(apiUrl),
    //     headers: {
    //       'Content-Type': 'application/json',
    //     },
    //     body: json.encode({
    //       'subject': subject,
    //       'question': question,
    //       'options': options,
    //       'correctAnswer': correctAnswer,
    //       'description': description,
    //       'questionId': questionId,
    //     }),
    //   );
    //
    //   if (response.statusCode == 201) {
    //     // Successfully added question
    //   } else {
    //     // Handle error
    //     debugPrint('Failed to add question: ${response.body}');
    //   }
  }

  void navigateToDownloadPage() {
    // Implement navigation logic
  }

  void handleTabChange(int index) {
    if (index >= 0 && index < tabs.length) {
      if (tabs[index] == "ADD+") {
        showAddTabDialog();
      } else {
        setState(() {
          selectedIndex = index;
          selectedQuestionIndex = 0;
          isLoading = true;
        });
        fetchData(tab: tabs[index]);
      }
    }
  }

  void showAddTabDialog() {
    TextEditingController tabNameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add New Tab"),
          content: TextField(
            controller: tabNameController,
            decoration: InputDecoration(hintText: "Enter tab name"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                String newTabName = tabNameController.text.trim();
                if (newTabName.isNotEmpty && !tabs.contains(newTabName)) {
                  addNewTab(newTabName);
                  Navigator.of(context).pop();
                } else {
                  // Optionally show an error message if the tab already exists
                }
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

  Future<void> addNewTab(String tabName) async {
    setState(() {
      isAddingTab = true; // Show the loader
    });

    await addNewSubject(tabName);
    await fetchData(tab: tabName); // Fetch data for the new tab

    setState(() {
      isAddingTab = false; // Hide the loader
    });
  }



  void toggleEditingMode(int index) {
    setState(() {
      // Toggle the editing mode for the selected question
      editingQuestionIndex = editingQuestionIndex == index ? 0 : index;
    });
  }

  void updateQuestionDetails(
      String newQuestion,
      List<dynamic> options, // Change the parameter type to List<dynamic>
      String newCorrectAnswer,
      String newExplanation,
      ) {
    setState(() {
      // Update the details of the selected question
      currentQuestions[selectedQuestionIndex] = newQuestion;

      // Convert options to List<String> explicitly
      currentOptions[selectedQuestionIndex] = options.map((option) {
        if (option is String) {
          return option; // If option is already String, return as is
        } else if (option is Map<String, dynamic> && option.containsKey('desc')) {
          return option['desc'] as String; // Extract 'desc' if available
        } else {
          return option.toString(); // Fallback to string representation
        }
      }).toList();

      currentCorrectAnswers[selectedQuestionIndex] = newCorrectAnswer;
      currentExplanations[selectedQuestionIndex] = newExplanation;

      // Exit editing mode after updating
      editingQuestionIndex = -1;
    });
  }


  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (isError) {
      return Center(child: Text('Failed to load questions.'));
    } else {
      return _buildQuestionPage();
    }
  }

  Widget _buildQuestionPage() {
    double heightFactor = MediaQuery.of(context).size.height / 1024;
    double widthFactor = MediaQuery.of(context).size.width / 1440;

    return Stack(
      children: [Scaffold(
        backgroundColor: backgroundColor1,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10 * widthFactor),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: CustomRoundedContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildTabBar(heightFactor, widthFactor),
                        // buildQuestionArea(heightFactor, widthFactor),
                        FutureBuilder<Widget>(
                          future: buildQuestionArea(heightFactor, widthFactor),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(child: Text('Error: ${snapshot.error}'));
                            } else {
                              return snapshot.data ?? Container(); // Return the widget or a default container
                            }
                          },
                        ),
                        //   ],
                        // ),
                      ],
                    ),
                    height: heightFactor * 1200,
                    width: widthFactor * 735,
                    padding: EdgeInsets.fromLTRB(
                      20 * widthFactor,
                      30 * heightFactor,
                      20 * widthFactor,
                      40 * heightFactor,
                    ),
                    margin: EdgeInsets.only(top: 20 * heightFactor),
                    color: backgroundColor,
                  ),
                ),
                SizedBox(width: 20 * widthFactor),
                buildRightSidebar(heightFactor, widthFactor),
              ],
            ),
          ),
        ),
      ),
        if (isAddingTab)
          Container(
            color: Colors.black26, // Semi-transparent background
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }

  Widget buildTabBar(double heightFactor, double widthFactor) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10 * heightFactor),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int index = 0; index < tabs.length; index++)
              SizedBox(
                width: widthFactor * 130,
                height: heightFactor * 51,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: ElevatedButton(
                    onPressed: () {
                      handleTabChange(index);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      index == selectedIndex ? primaryColor : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(
                      tabs[index],
                      style: GoogleFonts.poppins(
                        fontSize: widthFactor * 14,
                        fontWeight: FontWeight.w500,
                        color:
                        index == selectedIndex ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // void handleTabChange(int index) {
  //   if (index >= 0 && index < tabs.length) {
  //     if (tabs[index] == "ADD+") {
  //       showAddTabDialog();
  //     } else {
  //       setState(() {
  //         selectedIndex = index;
  //         selectedQuestionIndex = 0;
  //         isLoading = true;
  //       });
  //       fetchData(tab: tabs[index]);
  //     }
  //   }
  // }

  Future<Widget> buildQuestionArea(double heightFactor, double widthFactor) async {
    String questionId = '';
    if (selectedIndex >= 0 && selectedIndex < tabs.length && tabs[selectedIndex] != "ADD+") {
      if (selectedQuestionIndex >= 0 && selectedQuestionIndex < currentQuestions.length) {
        List<Map<String, dynamic>> optionsWithId = [];

        // Prepare options with 'id' for QuestionArea widget
        for (int i = 0; i < currentOptions[selectedQuestionIndex].length; i++) {
          optionsWithId.add({
            'id': (i + 1).toString(), // Assuming id starts from 1
            'desc': currentOptions[selectedQuestionIndex][i],
          });
        }

        List<String> savedIds = await getQuestionIds();
        if (selectedIndex < savedIds.length) {
          questionId = savedIds[selectedIndex];
          // deleteQuestion(questionId,
          //     _loadQuestions); // Call deleteQuestion with question ID and refresh function
          // widget.onDeleteQuestion(selectedIndex);
        } else {
          print('No question ID found for index $selectedIndex');
        }

        // print('Options passed to QuestionArea: $optionsWithId');

        return QuestionArea(
          quesId: questionId,
          subject: tabs[selectedIndex],
          questionNumber: "Question-${selectedQuestionIndex + 1}",
          question: currentQuestions[selectedQuestionIndex],
          options: optionsWithId,
          correctAnswer: currentCorrectAnswers.length > selectedQuestionIndex ? currentCorrectAnswers[selectedQuestionIndex] : '',
          explanation: currentExplanations.length > selectedQuestionIndex ? currentExplanations[selectedQuestionIndex] : '',
          heightFactor: heightFactor,
          widthFactor: widthFactor,
          isEditing: editingQuestionIndex == selectedQuestionIndex,
          toggleEditingMode: () => toggleEditingMode(selectedQuestionIndex),
          updateQuestionDetails: updateQuestionDetails, // Pass the callback
        );
      } else {
        // Handle case when selectedQuestionIndex is out of bounds
        return Container(
          alignment: Alignment.center,
          child: Text('No question selected.'),
        );
      }
    } else {
      // Handle case when selectedIndex is out of bounds or tab is "ADD+"
      return Container();
    }
  }


  Widget buildRightSidebar(double heightFactor, double widthFactor) {
    return CustomRoundedContainer(
      child: QuestionsSidebar(
          questions: currentQuestions,
          onQuestionSelected: updateQuestionIndex,
          onDeleteQuestion: deleteQuestion,
          onSaveQuestions: saveQuestions,
          onAddNewQuestion: addNewQuestion,
          subject: tabs[selectedIndex]),
      height: heightFactor * 1200,
      width: widthFactor * 450,
      padding: EdgeInsets.fromLTRB(
        20 * widthFactor,
        30 * heightFactor,
        20 * widthFactor,
        40 * heightFactor,
      ),
      margin: EdgeInsets.only(top: 20 * heightFactor),
      color: backgroundColor,
    );
  }
}