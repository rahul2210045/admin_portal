import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:admin_portal/constants/constants.dart';

Widget customRankCard(
  name,
  studentNo,
  rank,
  BuildContext context,
) {
  final screenHeight = MediaQuery.of(context).size.height;
  final screenWidth = MediaQuery.of(context).size.width;
  return Container(
      // margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),

      // height: screenHeight * 0.21,
      width: screenWidth * 0.49,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              rank,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            Text(
              name,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            Text(
              studentNo,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ],
        ),
      ));
}
