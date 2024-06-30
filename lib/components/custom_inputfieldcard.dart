// import 'package:admin_portal/Widgets/Screensize.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:admin_portal/constants/constants.dart';

// Widget customInputFieldCard(
//   String name1,
//   String h1,
//   TextEditingController controller1,
//   BuildContext context,
//   GlobalKey<FormState> formKey,
//   // Add a GlobalKey for the form
//   String? Function(String?) validator,
// ) {
//   return Container(
//     width: widthFactor(context) * 300,
//     child: Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Form(
//         // Wrap the widget in a Form
//         key: formKey,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               name1,
//               style: TextStyle(color: Colors.black, fontSize: 16),
//             ),
//             SizedBox(height: 10),
//             Container(
//               height: 35,
//               width: widthFactor(context) * 250,
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: Colors.white,
//                     ),
//                     height: 40,
//                     width: widthFactor(context) * 250,
//                     child: TextFormField(
//                       controller: controller1,
//                       style: TextStyle(color: Colors.black),
//                       decoration: InputDecoration(
//                         contentPadding:
//                             const EdgeInsets.symmetric(horizontal: 20),
//                         hintText: h1,
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(
//                             color: Colors.black,
//                           ),
//                           borderRadius: BorderRadius.circular(4),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(
//                             color: Colors.black,
//                           ),
//                           borderRadius: BorderRadius.circular(4),
//                         ),
//                         errorBorder: OutlineInputBorder(
//                           borderSide: BorderSide(
//                             color: Colors.black,
//                           ),
//                           borderRadius: BorderRadius.circular(4),
//                         ),
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide(
//                             color: Colors.black,
//                           ),
//                           borderRadius: BorderRadius.circular(4),
//                         ),
//                       ),
//                       validator: validator,

//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),

//       ),
//     ),
//   );
// }

import 'package:admin_portal/Widgets/Screensize.dart';
import 'package:flutter/material.dart';

Widget customInputFieldCard(
  String label,
  String hint,
  TextEditingController controller,
  BuildContext context,
  GlobalKey<FormState> formKey,
  String? Function(String?) validator,
) {
  return Container(
    width: widthFactor(context) * 300, // Adjust width as needed
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: controller,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                hintText: hint,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              validator: validator,
            ),
          ],
        ),
      ),
    ),
  );
}
