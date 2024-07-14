import 'package:admin_portal/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class feedback_card extends StatelessWidget {
  final String studentname;
  final String studenNo;
  final bool isSelected;
  final VoidCallback onTap;

  feedback_card({
    required this.studentname,
    required this.studenNo,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? primaryColor : Colors.white,
        ),
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.symmetric(vertical: 4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Student Name : " + studentname,
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: isSelected ? Colors.white : Colors.black),
            ),
            Text("Student no : " + studenNo,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: isSelected ? Colors.white : Colors.black)),
          ],
        ),
      ),
    );
  }
}
