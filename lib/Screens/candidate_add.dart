import 'package:admin_portal/Screens/loader.dart';
import 'package:admin_portal/Widgets/Custom_Container.dart';
import 'package:admin_portal/Widgets/Graph.dart';
import 'package:admin_portal/components/custom_inputfield.dart';
import 'package:admin_portal/components/registered_candidate_card.dart';
import 'package:admin_portal/constants/constants.dart';
import 'package:admin_portal/screens/leadertabel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class candidateAdd extends StatefulWidget {
  const candidateAdd({super.key});

  @override
  State<candidateAdd> createState() => _candidateAddState();
}

class _candidateAddState extends State<candidateAdd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor1,
      body: LayoutBuilder(
        builder: (context, constraints) {
          double heightFactor = constraints.maxHeight / 1024;
          double widthFactor = constraints.maxWidth / 1440;

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(15 * widthFactor),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Expanded(
                  // child:
                  CustomRoundedContainer(
                    child: customInputField(),
                    height: heightFactor * 920,
                    width: widthFactor * 850,
                    padding: EdgeInsets.all(10 * widthFactor),
                    margin: EdgeInsets.all(20 * widthFactor),
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  // ),
                  // Expanded(
                  // child:
                  CustomRoundedContainer(
                    child: registeredCandidate(),
                    height: heightFactor * 920,
                    width: widthFactor * 450,
                    padding: EdgeInsets.all(10 * widthFactor),
                    margin: EdgeInsets.all(20 * widthFactor),
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  // ),
                  // SizedBox(width: 10 * widthFactor), // Add this line to adjust the space between the columns
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
