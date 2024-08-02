import 'package:admin_portal/Widgets/Screensize.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget customDetailCard(
  name,
  studentNo,
  // rank,
  BuildContext context,
) {
  return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 100.0,
            spreadRadius: 0.0,
            offset: Offset(1.0, 1.0),
          )
        ],
      ),
      width: widthFactor(context) * 310,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   rank,
            //   style: TextStyle(color: Colors.black, fontSize: 16),
            // ),
            Text(
              "Student Name: $name",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "Student NO: $studentNo",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  ),
            ),
          ],
        ),
      ));
}
