import 'package:admin_portal/Widgets/Screensize.dart';
import 'package:admin_portal/components/custom_button.dart';
import 'package:admin_portal/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:toastification/toastification.dart';

class customInputField extends StatefulWidget {
  customInputField({super.key});

  @override
  State<customInputField> createState() => _customInputFieldState();
}

class _customInputFieldState extends State<customInputField> {
  TextEditingController _name = TextEditingController();
  TextEditingController _studentNo = TextEditingController();
  TextEditingController _branch = TextEditingController();
  TextEditingController _mobileNo = TextEditingController();
  TextEditingController _email = TextEditingController();
  

  final _formKey = GlobalKey<FormState>();
  String _residency = 'Day Scholar';
  String _section = 'Male';
  bool _isLoading = false;

  void _validateForm() {
    if (_formKey.currentState!.validate()) {
      print('Form is valid');
      addStudent();
      print('Proceeding to add student');
    } else {
      print('Form is invalid');
    }
  }

  Future<void> addStudent() async {
    setState(() {
      _isLoading = true;
    });
    var url =
        Uri.parse('https://cine-admin-xar9.onrender.com/admin/addStudent');
    var request = http.Request('POST', url);
    final headers = {
      'Content-Type': 'application/json',
      "Cookie": "accessToken=${PreferencesManager().token} "
      // "Cookie":
      // "accessToken=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE3MTk3ODMxNTUsImV4cCI6MTcxOTc5MDM1NSwiYXVkIjoiNjY3NmExNzIyOGQzOTQwZWQwMTgxNDdhIiwiaXNzIjoiY2luZV9jc2kifQ.jAxTxE8hkkXr3ddYmq2OcUVHaucEIIyZOgkoxTvYCU4",
    };

    final body = jsonEncode({
      "name": _name.text,
      "studentNumber": _studentNo.text,
      "branch": 'CSE',
      "gender": _section,
      "residency": _residency,
      "email": _email.text,
      "phone": _mobileNo.text,
    });

    request.headers.addAll({
      'Content-Type': 'application/json',
    });
    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Student added successfully')),
        );
        print("Student added successfully");
        _resetInputFields();
      } else {
        _showErrorDialog(
            'Invalid studdent information or Student is already present.');
        print(response.reasonPhrase);
      }
    } catch (e) {
      print('Error: $e');
      _showErrorDialog('unexpected error occured. Please try again later.');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

   void _resetInputFields() {
    _name.clear();
    _studentNo.clear();
    _branch.clear();
    _mobileNo.clear();
    _email.clear();
    setState(() {
      _residency = 'Day Scholar';
      _section = 'Male';
    });
  }

  void _showErrorDialog(String message) {
    toastification.show(
      context: context,
      type: ToastificationType.success,
      style: ToastificationStyle.flatColored,
      autoCloseDuration: const Duration(seconds: 5),
      title: Text(message),
      alignment: Alignment.topRight,
      direction: TextDirection.ltr,
      animationDuration: const Duration(milliseconds: 300),
      icon: const Icon(Icons.check),
      primaryColor: Colors.green,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          color: Color(0x07000000),
          blurRadius: 16,
          offset: Offset(0, 16),
          spreadRadius: 0,
        )
      ],
      showProgressBar: true,
      closeButtonShowType: CloseButtonShowType.onHover,
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
      applyBlurEffect: true,
      callbacks: ToastificationCallbacks(
        onTap: (toastItem) => print('Toast ${toastItem.id} tapped'),
        onCloseButtonTap: (toastItem) =>
            print('Toast ${toastItem.id} close button tapped'),
        onAutoCompleteCompleted: (toastItem) =>
            print('Toast ${toastItem.id} auto complete completed'),
        onDismissed: (toastItem) => print('Toast ${toastItem.id} dismissed'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SingleChildScrollView(
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
                              "Student No",
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
                              ['Male', 'Female', 'others'],
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
                              "Choose your residency",
                              [
                                'Choose your residency',
                                'Day Scholar',
                                'Hostel'
                              ], // Add placeholder item here
                              _residency,
                              context,
                              (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value == 'Choose your residency') {
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
                            // customDropdownFieldCard(
                            //   "Residency",
                            //   "Select Residency",
                            //   ['Day Scholar', 'Hostel'],
                            //   _residency,
                            //   context,
                            //   (value) {
                            //     if (value == null || value.isEmpty) {
                            //       return 'Please select a residency option';
                            //     }
                            //     return null;
                            //   },
                            //   (value) {
                            //     setState(() {
                            //       _residency = value!;
                            //     });
                            //   },
                            // ),
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
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icons.arrow_back_ios_new_rounded),
                              CustomButton(
                                widthFactor: widthFactor(context),
                                heightFactor: heightFactor(context),
                                text: "Register",
                                onPressed: _validateForm,
                              )
                            ],
                          ),
                        ),
                        // ),
                      ],
                    ),
                  )),
            ),
            if (_isLoading)
              Center(
                child: CircularProgressIndicator(),
              ),
          ],
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
