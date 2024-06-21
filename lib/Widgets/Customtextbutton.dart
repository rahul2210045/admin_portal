import 'package:admin_portal/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;
  final String imagePath;
  final String selectedImagePath;

  const CustomTextButton({
    Key? key,
    required this.text,
    required this.isSelected,
    required this.onPressed,
    required this.imagePath,
    required this.selectedImagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.all(10.0)),
          foregroundColor: MaterialStateProperty.all(
            isSelected
                ? Colors.white // Text color when selected
                : primaryColor, // Default text color
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return primaryColor.withOpacity(0.5); // Apply opacity when pressed
              } else if (isSelected) {
                return primaryColor; // Change to primaryColor when selected
              }
              return null; // No background color when not selected or pressed
            },
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              isSelected ? selectedImagePath : imagePath,
              // height: 40,
              scale: 1,
            ),
            Text(
              text,
              style: GoogleFonts.poppins(),
            ),
          ],
        ),
      ),
    );
  }
}
