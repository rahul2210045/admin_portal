// import 'dart:js';

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

class customInputField extends StatefulWidget {
  customInputField({super.key});

  @override
  State<customInputField> createState() => _customInputFieldState();
}

class _customInputFieldState extends State<customInputField> {
  TextEditingController _name = TextEditingController();

  TextEditingController _studentNo = TextEditingController();

  // TextEditingController _section = TextEditingController();

  TextEditingController _branch = TextEditingController();

  TextEditingController _mobileNo = TextEditingController();

  TextEditingController _email = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String _residency = 'Day Scholar';
  String _section = 'Male';

  // final _formKey2 = GlobalKey<FormState>();

  // final _formKey3 = GlobalKey<FormState>();

  // final _formKey4 = GlobalKey<FormState>();

  // final _formKey5 = GlobalKey<FormState>();

  // final _formKey6 = GlobalKey<FormState>();

  void _validateForm() {
    // setState(() {});
    // bool isValid = true;
    if (!_formKey.currentState!.validate())
    // if (!_formKey2.currentState!.validate()) isValid = false;
    // if (!_formKey3.currentState!.validate()) isValid = false;
    // if (!_formKey4.currentState!.validate()) isValid = false;
    // if (!_formKey5.currentState!.validate()) isValid = false;
    // if (!_formKey6.currentState!.validate()) isValid = false;

    {
      addStudent();
    }
  }

  Future<void> addStudent() async {
    var url =
        Uri.parse('https://cine-admin-xar9.onrender.com/admin/addStudent');
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
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        customInputFieldCard(
                          "Name",
                          "Enter Name",
                          _name,
                          context,
                          // _formKey,
                          (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a name';
                            } else if (value.length < 3) {
                              return 'Enter a valid name';
                            } else if (!RegExp(r'^[a-zA-Z\s]+$')
                                .hasMatch(value)) {
                              return 'Enter a valid name';
                            }
                            return null;
                          },
                        ),
                        customInputFieldCard(
                          "Studnet No",
                          "Enter Student No",
                          _studentNo,
                          context,
                          // _formKey2,
                          (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a student number';
                            } else if (!RegExp(r'^23\d{5,6}$')
                                .hasMatch(value)) {
                              return 'Enter a valid student number';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        customDropdownFieldCard(
                          "Gender",
                          "Select your gender",
                          ['Male', 'Female', 'LGBTQ+'],
                          _section,
                          context,
                          // _formKey3,
                          (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a section';
                            }
                            return null;
                          },
                          (value) {
                            setState(() {
                              _section = value!;
                            });
                          },
                        ),
                        customDropdownFieldCard(
                          "Residency",
                          "Select Residency",
                          ['Day Scholar', 'Hostel'],
                          _residency,
                          context,
                          (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a residency option';
                            }
                            return null;
                          },
                          (value) {
                            setState(() {
                              _residency = value!;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        customInputFieldCard(
                          "Mobile No",
                          "Enter Mobile No",
                          _mobileNo,
                          context,
                          // _formKey5,
                          (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a mobile number';
                            } else if (value.length != 10) {
                              return 'Please enter a valid mobile number';
                            }
                            return null;
                          },
                        ),
                        customInputFieldCard(
                          "Email",
                          "Enter College Email",
                          _email,
                          context,
                          // _formKey6,
                          (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an email';
                            } else if (!RegExp(
                                    r'^[a-zA-Z0-9._%+-]+@akgec\.ac\.in$')
                                .hasMatch(value)) {
                              return 'Please enter a valid college email ending with @akgec.ac.in';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
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
                              onPressed: () {},
                              icon: Icons.arrow_back_ios_new_rounded),
                          CustomButton(
                            widthFactor: widthFactor(context),
                            heightFactor: heightFactor(context),
                            text: "Register",
                            onPressed: _validateForm,
                            // icon: Icons.add,
                            // addStudent();
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => Candidate()),
                            // );
                          )
                        ],
                      ),
                    ),
                    // ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}

Widget customInputFieldCard(
  String label,
  String hint,
  TextEditingController controller,
  BuildContext context,
  String? Function(String?) validator,
) {
  return Container(
    width: widthFactor(context) * 300,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
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
  );
}

// class CustomButton extends StatelessWidget {
//   final double widthFactor;
//   final double heightFactor;
//   final String text;
//   final VoidCallback onPressed;
//   final IconData icon;

//   CustomButton({
//     required this.widthFactor,
//     required this.heightFactor,
//     required this.text,
//     required this.onPressed,
//     required this.icon,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton.icon(
//       icon: Icon(icon),
//       label: Text(text),
//       onPressed: onPressed,
//     );
//   }
// }

Widget customDropdownFieldCard(
  String label,
  String hint,
  List<String> options,
  String selectedValue,
  BuildContext context,
  String? Function(String?) validator,
  void Function(String?) onChanged,
) {
  return Container(
    width: widthFactor(context) * 300,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          SizedBox(height: 10),
          DropdownButtonFormField<String>(
            value: selectedValue,
            onChanged: onChanged,
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
            items: options.map((String option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text(option),
              );
            }).toList(),
          ),
        ],
      ),
    ),
  );
}
