import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<QuizComponent> htmlQuestions = [
   const QuizComponent(
      question: 'What is the full form of HTML?',
      options: ['Option A', 'Option B', 'Option C', 'Option D'],
      correctAnswer: 'Option A',
      explanation: 'HTML stands for HyperText Markup Language.',
    ),
  ];
  List<QuizComponent> sqlQuestions = [
     const QuizComponent(
      question: 'What is SQL used for?',
      options: ['Option A', 'Option B', 'Option C', 'Option D'],
      correctAnswer: 'Option B',
      explanation: 'SQL is used for managing data in a relational database.',
    ),
  ];
  List<QuizComponent> cssQuestions = [
    const QuizComponent(
      question: 'What is CSS?',
      options: ['Option A', 'Option B', 'Option C', 'Option D'],
      correctAnswer: 'Option C',
      explanation: 'CSS stands for Cascading Style Sheets.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {}); // Update the UI when tab changes
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _addQuestion(String category, QuizComponent question) {
    setState(() {
      if (category == 'HTML') {
        htmlQuestions.add(question);
      } else if (category == 'SQL') {
        sqlQuestions.add(question);
      } else if (category == 'CSS') {
        cssQuestions.add(question);
      }
    });
  }

  void _showAddQuestionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        String selectedCategory = 'HTML';
        String question = '';
        String optionA = '';
        String optionB = '';
        String optionC = '';
        String optionD = '';
        String correctAnswer = '';
        String explanation = '';

        return AlertDialog(
          title:  const Text('Add New Question'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                DropdownButtonFormField<String>(
                  value: selectedCategory,
                  onChanged: (value) {
                    selectedCategory = value!;
                  },
                  items: ['HTML', 'SQL', 'CSS']
                      .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(category),
                          ))
                      .toList(),
                ),
                TextField(
                  onChanged: (value) => question = value,
                  decoration: const InputDecoration(labelText: 'Question'),
                ),
                TextField(
                  onChanged: (value) => optionA = value,
                  decoration: const InputDecoration(labelText: 'Option A'),
                ),
                TextField(
                  onChanged: (value) => optionB = value,
                  decoration: const InputDecoration(labelText: 'Option B'),
                ),
                TextField(
                  onChanged: (value) => optionC = value,
                  decoration: const InputDecoration(labelText: 'Option C'),
                ),
                TextField(
                  onChanged: (value) => optionD = value,
                  decoration: const InputDecoration(labelText: 'Option D'),
                ),
                TextField(
                  onChanged: (value) => correctAnswer = value,
                  decoration: const InputDecoration(labelText: 'Correct Answer'),
                ),
                TextField(
                  onChanged: (value) => explanation = value,
                  decoration: const InputDecoration(labelText: 'Explanation'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _addQuestion(
                  selectedCategory,
                  QuizComponent(
                    question: question,
                    options: [optionA, optionB, optionC, optionD],
                    correctAnswer: correctAnswer,
                    explanation: explanation,
                  ),
                );
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text('Questions'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _tabController.index == 0
                      ? Colors.blue
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  'HTML',
                  style: TextStyle(
                    color:
                        _tabController.index == 0 ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Tab(
              child: Container(
                padding:  const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _tabController.index == 1
                      ? Colors.blue
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  'SQL',
                  style: TextStyle(
                    color:
                        _tabController.index == 1 ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Tab(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _tabController.index == 2
                      ? Colors.blue
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  'CSS',
                  style: TextStyle(
                    color:
                        _tabController.index == 2 ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Tab(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _tabController.index == 3
                      ? Colors.blue
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  'Add+',
                  style: TextStyle(
                    color:
                        _tabController.index == 3 ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.blue, // Background color of selected tab indicator
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ListView(children: htmlQuestions),
                ListView(children: sqlQuestions),
                ListView(children: cssQuestions),
               const  Center(
                  child: Text('Add your question here'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: _showAddQuestionDialog,
              child: const Text('Add Question'),
            ),
          ),
        ],
      ),
    );
  }
}

class QuizComponent extends StatefulWidget {
  final String question;
  final List<String> options;
  final String correctAnswer;
  final String explanation;

  const QuizComponent({
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
  });

  @override
  _QuizComponentState createState() => _QuizComponentState();
}

class _QuizComponentState extends State<QuizComponent> {
  String? _selectedOption;
  final TextEditingController _explanationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedOption = widget.correctAnswer;
    _explanationController.text = widget.explanation;
  }

  @override
  void dispose() {
    _explanationController.dispose();
    super.dispose();
  }

  void _handleOptionTap(String option) {
    setState(() {
      _selectedOption = option;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.question,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
         const  SizedBox(height: 20),
          ...widget.options.map((option) {
            return GestureDetector(
              onTap: () => _handleOptionTap(option),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Radio<String>(
                      value: option,
                      groupValue: _selectedOption,
                      onChanged: (value) {
                        _handleOptionTap(value!);
                      },
                    ),
                 const    SizedBox(width: 10),
                    Text(option),
                  ],
                ),
              ),
            );
          }).toList(),
         const  SizedBox(height: 20),
         const  Text(
            'Selected Correct Answer:',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            _selectedOption ?? 'None',
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Explanation:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextField(
            controller: _explanationController,
            maxLines: 3,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Write explanation here...',
            ),
          ),
         const  SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // Save the selected option and explanation
              print('Selected Correct Answer: $_selectedOption');
              print('Explanation: ${_explanationController.text}');
            },
            child:  const Text('Save'),
          ),
        ],
      ),
    );
  }
}
