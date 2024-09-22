// // import 'package:admin_portal/constants/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class student_detail_card_new extends StatefulWidget {
//   final String studentname;
//   final String studenNo;
//   final String branch;
//   const student_detail_card_new(
//       {super.key,
//       required this.studentname,
//       required this.studenNo,
//       required this.branch});

//   @override
//   State<student_detail_card_new> createState() =>
//       _student_detail_card_newState();
// }

// class _student_detail_card_newState extends State<student_detail_card_new> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 4),
//       child: Material(
//           // borderRadius: BorderRadius.circular(12),
//           // elevation: 2,
//           // shadowColor: Colors.blueGrey,
//           child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 5.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               widget.studentname,
//               style: GoogleFonts.poppins(
//                   fontSize: 14, fontWeight: FontWeight.w500),
//             ),
//             Text(
//               widget.studenNo,
//               style: GoogleFonts.poppins(
//                   fontSize: 14, fontWeight: FontWeight.w500),
//             ),
//             Text(
//               widget.branch,
//               style: GoogleFonts.poppins(
//                   fontSize: 14, fontWeight: FontWeight.w500),
//             ),
//           ],
//         ),
//       )
//           // ListTile(
//           //   title: Text(
//           //     "Student Name:" + widget.studentname,
//           //     style: GoogleFonts.poppins(fontSize: 12),
//           //   ),
//           //   subtitle: Text("Student no" + widget.studenNo,
//           //       style: GoogleFonts.poppins(fontSize: 9)),
//           //   shape: RoundedRectangleBorder(
//           //     borderRadius: BorderRadius.circular(12),
//           //   ),
//           //   tileColor: Colors.white,
//           //   enabled: true,
//           //   // minTileHeight:20,
//           // ),
//           ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StudentDetailCardNew extends StatefulWidget {
  final String studentName;
  final String studentNo;
  final String branch;

  const StudentDetailCardNew({
    Key? key,
    required this.studentName,
    required this.studentNo,
    required this.branch,
  }) : super(key: key);

  @override
  State<StudentDetailCardNew> createState() => _StudentDetailCardNewState();
}

class _StudentDetailCardNewState extends State<StudentDetailCardNew> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Material(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  widget.studentName,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    widget.studentNo,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    widget.branch,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
