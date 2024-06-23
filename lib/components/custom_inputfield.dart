import 'package:admin_portal/Widgets/Custom_Container.dart';
import 'package:admin_portal/Widgets/Screensize.dart';
import 'package:admin_portal/components/custom_candidate_detail_card.dart';
import 'package:admin_portal/components/custom_detail_card.dart';
import 'package:admin_portal/components/custom_inputfieldcard.dart';
import 'package:admin_portal/constants/constants.dart';
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
                  Container(
                    height: 35,
                    width: widthFactor(context) * 330,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [],
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
