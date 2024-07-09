// import 'package:flutter/material.dart';

// import '../constants/constants.dart';

// class QuizScreen extends StatefulWidget {
//   @override
//   _QuizScreenState createState() => _QuizScreenState();
// }

// class _QuizScreenState extends State<QuizScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   int _selectedQuestionIndex = 0;

//   final List<Map<String, dynamic>> _htmlQuestions = List.generate(
//     9,
//     (index) => {
//       'question': 'HTML Question ${index + 1}',
//       'options': ['Option A', 'Option B', 'Option C', 'Option D'],
//       'correctAnswer': 'Option A',
//       'explanation': 'Explanation for HTML Question ${index + 1}',
//     },
//   );

//   final List<Map<String, dynamic>> _sqlQuestions = List.generate(
//     9,
//     (index) => {
//       'question': 'SQL Question ${index + 1}',
//       'options': ['Option A', 'Option B', 'Option C', 'Option D'],
//       'correctAnswer': 'Option B',
//       'explanation': 'Explanation for SQL Question ${index + 1}',
//     },
//   );

//   final List<Map<String, dynamic>> _cssQuestions = List.generate(
//     9,
//     (index) => {
//       'question': 'CSS Question ${index + 1}',
//       'options': ['Option A', 'Option B', 'Option C', 'Option D'],
//       'correctAnswer': 'Option C',
//       'explanation': 'Explanation for CSS Question ${index + 1}',
//     },
//   );

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 4, vsync: this);
//     _tabController.addListener(() {
//       setState(() {
//         _selectedQuestionIndex = 0;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   void _selectQuestion(int index) {
//     setState(() {
//       _selectedQuestionIndex = index;
//     });
//   }

//   Future<void> _createNewQuestion() async {
//     final newQuestionData = await showDialog<Map<String, dynamic>>(
//       context: context,
//       builder: (BuildContext context) {
//         final TextEditingController questionController =
//             TextEditingController();
//         final TextEditingController optionAController = TextEditingController();
//         final TextEditingController optionBController = TextEditingController();
//         final TextEditingController optionCController = TextEditingController();
//         final TextEditingController optionDController = TextEditingController();
//         final TextEditingController explanationController =
//             TextEditingController();
//         String? correctAnswer;
//         String? selectedCategory;

//         return StatefulBuilder(
//           builder: (context, setState) {
//             return AlertDialog(
//               title: Text('Add New Question'),
//               content: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     TextField(
//                       controller: questionController,
//                       decoration: InputDecoration(labelText: 'Question'),
//                     ),
//                     TextField(
//                       controller: optionAController,
//                       decoration: InputDecoration(labelText: 'Option A'),
//                     ),
//                     TextField(
//                       controller: optionBController,
//                       decoration: InputDecoration(labelText: 'Option B'),
//                     ),
//                     TextField(
//                       controller: optionCController,
//                       decoration: InputDecoration(labelText: 'Option C'),
//                     ),
//                     TextField(
//                       controller: optionDController,
//                       decoration: InputDecoration(labelText: 'Option D'),
//                     ),
//                     TextField(
//                       controller: explanationController,
//                       decoration: InputDecoration(labelText: 'Explanation'),
//                     ),
//                     DropdownButton<String>(
//                       hint: Text('Select Correct Answer'),
//                       value: correctAnswer,
//                       onChanged: (String? newValue) {
//                         setState(() {
//                           correctAnswer = newValue;
//                         });
//                       },
//                       items: <String>[
//                         'Option A',
//                         'Option B',
//                         'Option C',
//                         'Option D'
//                       ].map<DropdownMenuItem<String>>((String value) {
//                         return DropdownMenuItem<String>(
//                           value: value,
//                           child: Text(value),
//                         );
//                       }).toList(),
//                     ),
//                     DropdownButton<String>(
//                       hint: Text('Select Category'),
//                       value: selectedCategory,
//                       onChanged: (String? newValue) {
//                         setState(() {
//                           selectedCategory = newValue;
//                         });
//                       },
//                       items: <String>['HTML', 'SQL', 'CSS']
//                           .map<DropdownMenuItem<String>>((String value) {
//                         return DropdownMenuItem<String>(
//                           value: value,
//                           child: Text(value),
//                         );
//                       }).toList(),
//                     ),
//                   ],
//                 ),
//               ),
//               actions: <Widget>[
//                 ElevatedButton(
//                   child: Text('Cancel'),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                 ),
//                 ElevatedButton(
//                   child: Text('Add'),
//                   onPressed: () {
//                     Navigator.of(context).pop({
//                       'question': questionController.text,
//                       'options': [
//                         optionAController.text,
//                         optionBController.text,
//                         optionCController.text,
//                         optionDController.text,
//                       ],
//                       'correctAnswer': correctAnswer,
//                       'explanation': explanationController.text,
//                       'category': selectedCategory,
//                     });
//                   },
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );

//     if (newQuestionData != null) {
//       setState(() {
//         if (newQuestionData['category'] == 'HTML') {
//           _htmlQuestions.add(newQuestionData);
//         } else if (newQuestionData['category'] == 'SQL') {
//           _sqlQuestions.add(newQuestionData);
//         } else if (newQuestionData['category'] == 'CSS') {
//           _cssQuestions.add(newQuestionData);
//         }
//       });
//     }
//   }

//   void _addNewQuestion() {
//     _createNewQuestion();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Questions'),
//         bottom: TabBar(
//           controller: _tabController,
//           tabs: [
//             Tab(
//               child: Container(
//                 padding: EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   color: _tabController.index == 0
//                       ? primaryColor
//                       : Colors.transparent,
//                   borderRadius: BorderRadius.circular(5),
//                 ),
//                 child: Text(
//                   'HTML',
//                   style: TextStyle(
//                     color:
//                         _tabController.index == 0 ? Colors.white : Colors.black,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//             Tab(
//               child: Container(
//                 padding: EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   color: _tabController.index == 1
//                       ? primaryColor
//                       : Colors.transparent,
//                   borderRadius: BorderRadius.circular(5),
//                 ),
//                 child: Text(
//                   'SQL',
//                   style: TextStyle(
//                     color:
//                         _tabController.index == 1 ? Colors.white : Colors.black,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//             Tab(
//               child: Container(
//                 padding: EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   color: _tabController.index == 2
//                       ? primaryColor
//                       : Colors.transparent,
//                   borderRadius: BorderRadius.circular(5),
//                 ),
//                 child: Text(
//                   'CSS',
//                   style: TextStyle(
//                     color:
//                         _tabController.index == 2 ? Colors.white : Colors.black,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//             Tab(
//               child: Container(
//                 padding: EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   color: _tabController.index == 3
//                       ? primaryColor
//                       : Colors.transparent,
//                   borderRadius: BorderRadius.circular(5),
//                 ),
//                 child: Text(
//                   'Add+',
//                   style: TextStyle(
//                     color:
//                         _tabController.index == 3 ? Colors.white : Colors.black,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//           indicator: BoxDecoration(
//             borderRadius: BorderRadius.circular(5),
//             color: primaryColor,
//           ),
//         ),
//       ),
//       body: Row(
//         children: [
//           Expanded(
//             flex: 2,
//             child: TabBarView(
//               controller: _tabController,
//               children: [
//                 _buildQuestionsTab(_htmlQuestions),
//                 _buildQuestionsTab(_sqlQuestions),
//                 _buildQuestionsTab(_cssQuestions),
//                 _buildAddQuestionTab(),
//               ],
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: _buildQuestionSelector(),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildQuestionsTab(List<Map<String, dynamic>> questions) {
//     if (questions.isEmpty) {
//       return Center(
//         child: Text('No questions available.'),
//       );
//     }
//     final question = questions[_selectedQuestionIndex];
//     return QuizComponent(
//       question: question['question'],
//       options: List<String>.from(question['options']),
//       correctAnswer: question['correctAnswer'],
//       explanation: question['explanation'],
//     );
//   }

//   Widget _buildAddQuestionTab() {
//     return Center(
//       child: ElevatedButton(
//         onPressed: _addNewQuestion,
//         child: Text('Add a new question'),
//       ),
//     );
//   }

//   Widget _buildQuestionSelector() {
//     List<Map<String, dynamic>> currentQuestions;
//     switch (_tabController.index) {
//       case 0:
//         currentQuestions = _htmlQuestions;
//         break;
//       case 1:
//         currentQuestions = _sqlQuestions;
//         break;
//       case 2:
//         currentQuestions = _cssQuestions;
//         break;
//       default:
//         currentQuestions = [];
//         break;
//     }

//     List<Widget> questionButtons =
//         List.generate(currentQuestions.length, (index) {
//       return ElevatedButton(
//         onPressed: () => _selectQuestion(index),
//         style: ElevatedButton.styleFrom(
//           backgroundColor:
//               index == _selectedQuestionIndex ? Colors.blue : Colors.grey,
//           shape: CircleBorder(),
//           padding: EdgeInsets.all(20),
//         ),
//         child: Text(
//           '${index + 1}',
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       );
//     });

//     questionButtons.add(
//       ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.blueAccent,
//           shape: CircleBorder(),
//         ),
//         onPressed: _addNewQuestion,
//         child: Icon(
//           Icons.add,
//           color: Colors.white,
//           size: 24,
//         ),
//       ),
//     );

//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: questionButtons,
//     );
//   }
// }

// class QuizComponent extends StatefulWidget {
//   final String question;
//   final List<String> options;
//   final String correctAnswer;
//   final String explanation;

//   const QuizComponent({
//     Key? key,
//     required this.question,
//     required this.options,
//     required this.correctAnswer,
//     required this.explanation,
//   }) : super(key: key);

//   @override
//   _QuizComponentState createState() => _QuizComponentState();
// }

// class _QuizComponentState extends State<QuizComponent> {
//   String? _selectedOption;
//   final TextEditingController _explanationController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _selectedOption = widget.correctAnswer;
//     _explanationController.text = widget.explanation;
//   }

//   @override
//   void dispose() {
//     _explanationController.dispose();
//     super.dispose();
//   }

//   void _handleOptionTap(String option) {
//     setState(() {
//       _selectedOption = option;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             widget.question,
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 20),
//           ...widget.options.map((option) {
//             return GestureDetector(
//               onTap: () => _handleOptionTap(option),
//               child: Container(
//                 padding: EdgeInsets.symmetric(vertical: 10),
//                 child: Row(
//                   children: [
//                     Radio<String>(
//                       value: option,
//                       groupValue: _selectedOption,
//                       onChanged: (value) {
//                         _handleOptionTap(value!);
//                       },
//                     ),
//                     SizedBox(width: 10),
//                     Text(option),
//                   ],
//                 ),
//               ),
//             );
//           }).toList(),
//           SizedBox(height: 20),
//           Text(
//             'Selected Correct Answer:',
//             style: TextStyle(
//               color: Colors.black,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           Text(
//             _selectedOption ?? 'None',
//             style: TextStyle(
//               color: Colors.black,
//             ),
//           ),
//           SizedBox(height: 20),
//           Text(
//             'Explanation:',
//             style: TextStyle(
//               color: Colors.black,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           TextField(
//             controller: _explanationController,
//             maxLines: 3,
//             decoration: InputDecoration(
//               hintText: 'Explanation',
//               border: OutlineInputBorder(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

