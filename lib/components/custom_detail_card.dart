import 'package:admin_portal/Widgets/Screensize.dart';
import 'package:flutter/material.dart';


Widget customRankCard(
  name,
  studentNo,
  rank,
  score,
  branch,
  gender,
  residency,
  BuildContext context,
) {
  return Container(
      width: widthFactor(context) * 680,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              rank,
              style:const  TextStyle(color: Colors.black, fontSize: 16),
            ),
            Text(
              name,
              style:const  TextStyle(color: Colors.black, fontSize: 16),
            ),
            Text(
              score,
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
              Text(
              branch,
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
             Text(
              studentNo,
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
             Text(
              gender,
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
             Text(
              residency,
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
          ],
        ),
      ));
}
