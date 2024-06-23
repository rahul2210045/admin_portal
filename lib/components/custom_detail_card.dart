import 'package:admin_portal/Widgets/Screensize.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


Widget customRankCard(
  name,
  studentNo,
  rank,
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
              studentNo,
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
          ],
        ),
      ));
}
