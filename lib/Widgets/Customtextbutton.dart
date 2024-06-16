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
          backgroundColor: isSelected
              ? MaterialStateProperty.all(Color.fromRGBO(84, 108, 255, 1))
              : null,
          foregroundColor: MaterialStateProperty.all(isSelected
              ? Color.fromARGB(255, 255, 255, 255)
              : Theme.of(context).textTheme.labelLarge!.color),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              side: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10.0),
              
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              isSelected ? selectedImagePath : imagePath,
              height: 40,
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
