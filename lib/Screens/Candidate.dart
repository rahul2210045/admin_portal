import 'package:admin_portal/constants/constants.dart';
import 'package:flutter/material.dart';

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