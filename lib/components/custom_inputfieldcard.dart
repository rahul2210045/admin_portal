
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
