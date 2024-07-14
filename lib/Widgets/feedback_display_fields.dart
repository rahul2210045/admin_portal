import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class display_fields extends StatefulWidget {
  final String fieldLabel;
  final String content;
  final double boxHeight;
  final double boxWidth;
  display_fields(
      {super.key,
      required this.fieldLabel,
      required this.content,
      required this.boxHeight,
      required this.boxWidth});

  @override
  State<display_fields> createState() => _display_fieldsState();
}

class _display_fieldsState extends State<display_fields> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        widget.fieldLabel,
        style: GoogleFonts.poppins(),
      ),
      SizedBox(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.black),
          ),
          child: Center(
              child: SingleChildScrollView(
            child: Text(
              widget.content,
              style: GoogleFonts.poppins(color: Color(0xff808080),fontWeight: FontWeight.w400),
            ),
          )),
        ),
        height: widget.boxHeight,
        width: widget.boxWidth,
      )
    ]);
  }
}
