import 'package:admin_portal/constants/constants.dart';
import 'package:flutter/material.dart';

import 'que_screen.dart';
// import 'quiz_screen.dart'; // Make sure the import path is correct

class Candidate extends StatefulWidget {
  const Candidate({super.key});

  @override
  State<Candidate> createState() => _CandidateState();
}

class _CandidateState extends State<Candidate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor1,
       body: Container(color: backgroundColor1,),
    );
  }
}
