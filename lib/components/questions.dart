// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

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
  bool _isAnswerSelected = false; // Track if an answer is selected

  @override
  void initState() {
    super.initState();
    _selectedOption = widget.correctAnswer;
    _explanationController.text = widget.explanation;
    if (_selectedOption != null) {
      _isAnswerSelected = true; // Set to true if a default answer is provided
    }
  }

  @override
  void dispose() {
    _explanationController.dispose();
    super.dispose();
  }

  void _handleOptionTap(String option) {
    setState(() {
      _selectedOption = option;
      _isAnswerSelected = true; // Mark as selected when an option is tapped
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
          const SizedBox(height: 20),
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
                    const SizedBox(width: 10),
                    Text(option),
                  ],
                ),
              ),
            );
          }).toList(),
          const SizedBox(height: 40),
          Text(
            'Correct Answer:',
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 20,
              color: _isAnswerSelected ? Colors.black : Colors.black,
            ),
          ),
          const Divider(
            color: Colors.black,
          ),
          Text(
            _selectedOption ?? 'None',
            style: TextStyle(
              fontSize: 18,
              color: _isAnswerSelected ? Colors.green : Colors.black,
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
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // Save the selected option and explanation

              print('Selected Correct Answer: $_selectedOption');
              print('Explanation: ${_explanationController.text}');
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
