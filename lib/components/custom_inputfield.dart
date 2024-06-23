import 'package:admin_portal/Widgets/Custom_Container.dart';
import 'package:admin_portal/Widgets/Screensize.dart';
import 'package:admin_portal/components/custom_button.dart';
import 'package:admin_portal/components/custom_candidate_detail_card.dart';
import 'package:admin_portal/components/custom_detail_card.dart';
import 'package:admin_portal/components/custom_inputfieldcard.dart';
import 'package:admin_portal/constants/constants.dart';
import 'package:admin_portal/screens/Candidate.dart';
import 'package:flutter/material.dart';

class customInputField extends StatelessWidget {
  const customInputField({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customInputFieldCard("Name", "Studnet No", '', context),
                  SizedBox(
                    height: 10,
                  ),
                  customInputFieldCard("Section", "Branch", '', context),
                  SizedBox(
                    height: 10,
                  ),
                  customInputFieldCard("Mobile No", "Email", '', context),
                  SizedBox(
                    height: 100,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomButton(
                            widthFactor: widthFactor(context),
                            heightFactor: heightFactor(context),
                            text: "back",
                            onPressed: (){},
                            icon: Icons.arrow_back_ios_new_rounded),
                        CustomButton(
                            widthFactor: widthFactor(context),
                            heightFactor: heightFactor(context),
                            text: "Register",
                            onPressed: () {})
                      ],
                    ),
                  ),
                  // ),
                ],
              )),
        ),
      ),
    );
  }
}
