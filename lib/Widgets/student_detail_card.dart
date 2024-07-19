// import 'package:admin_portal/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class student_detail_card extends StatefulWidget {
  final String studentname;
  final String studenNo;
  const student_detail_card(
      {super.key, required this.studentname, required this.studenNo});

  @override
  State<student_detail_card> createState() => _student_detail_cardState();
}

class _student_detail_cardState extends State<student_detail_card> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 
        
        8.0),
        // margin: EdgeInsets.symmetric(vertical: 4.0),
        // padding: EdgeInsets.symmetric(vertical: 4),
        child: Material(
          // borderRadius: BorderRadius.circular(12),
          // elevation: 2,
          shadowColor: Colors.blueGrey.shade200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Student Name : " + widget.studentname,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  // color: isSelected ? Colors.white : Colors.black),
                ),

                // ListTile(
                // title: Text("Student Name:"+widget.studentname,style: GoogleFonts.poppins(fontSize:12 ),),
                // subtitle: Text("Student no"+widget.studenNo,style: GoogleFonts.poppins(fontSize:9 )),
                // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),),
                // tileColor: Colors.white,
                // enabled: true,
                // // minTileHeight:20,

                // ),
              ),
              Text("Student no : " + widget.studenNo,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    // color: isSelected ? Colors.white : Colors.black)
                  )),
            ],
          ),
        ));
  }
}
