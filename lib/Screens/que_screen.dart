import 'package:flutter/material.dart';
import '../components/questions.dart';
// import 'quiz_component.dart'; // Make sure the import path is correct

class QuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text('Questions'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'HTML'),
              Tab(text: 'SQL'),
              Tab(text: 'CSS'),
              Tab(text: 'Add+'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            QuizComponent(
              question: 'What is the full form of HTML?',
              options: ['Option A', 'Option B', 'Option C', 'Option D'],
              correctAnswer: 'Option A',
              explanation: 'HTML stands for HyperText Markup Language.',
            ),
            QuizComponent(
              question: 'What is SQL used for?',
              options: ['Option A', 'Option B', 'Option C', 'Option D'],
              correctAnswer: 'Option B',
              explanation: 'SQL is used for managing data in a relational database.',
            ),
            QuizComponent(
              question: 'What is CSS?',
              options: ['Option A', 'Option B', 'Option C', 'Option D'],
              correctAnswer: 'Option C',
              explanation: 'CSS stands for Cascading Style Sheets.',
            ),
            QuizComponent(
              question: 'Add your question here',
              options: ['Option A', 'Option B', 'Option C', 'Option D'],
              correctAnswer: 'Option D',
              explanation: 'Add your explanation here.',
            ),
          ],
        ),
      ),
    );
  }
}
