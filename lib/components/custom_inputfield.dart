import 'package:admin_portal/Widgets/Custom_Container.dart';
import 'package:admin_portal/Widgets/Screensize.dart';
import 'package:admin_portal/components/custom_button.dart';
import 'package:admin_portal/components/custom_candidate_detail_card.dart';
import 'package:admin_portal/components/custom_detail_card.dart';
import 'package:admin_portal/components/custom_inputfieldcard.dart';
import 'package:admin_portal/constants/constants.dart';
import 'package:admin_portal/screens/Candidate.dart';
import 'package:flutter/material.dart';
  import 'package:http/http.dart' as http;
import 'dart:convert';

class customInputField extends StatelessWidget {
   customInputField({super.key});
  TextEditingController _name = TextEditingController();
  TextEditingController _studentNo = TextEditingController();
  TextEditingController _section = TextEditingController();
  TextEditingController _branch = TextEditingController();
  TextEditingController _mobileNo = TextEditingController();
  TextEditingController _email = TextEditingController();



Future<void> addStudent() async {
  var url = Uri.parse('https://cine-admin-xar9.onrender.com/admin/addStudent');
  var request = http.Request('POST', url);

  request.body = jsonEncode({
    "name": _name.text,
    "studentNumber": _studentNo.text,
    "branch": _branch.text,
    "gender": 'male',
    "residency": "day scholar",
    "email": _email.text,
    "phone": _mobileNo.text,
  });

  request.headers.addAll({
    'Content-Type': 'application/json',
  });

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}


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
                  customInputFieldCard("Name", "Studnet No", '',_name, _studentNo, context),
                  SizedBox(
                    height: 10,
                  ),
                  customInputFieldCard("Section", "Branch", '',_section, _branch, context),
                  SizedBox(
                    height: 10,
                  ),
                  customInputFieldCard("Mobile No", "Email", '',_mobileNo,_email, context),
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
                            onPressed: () {
                              addStudent();
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context) => Candidate()),
                              // );
                            })
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
