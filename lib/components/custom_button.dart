import 'package:admin_portal/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final double widthFactor;
  final double heightFactor;
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;

  const CustomButton({
    required this.widthFactor,
    required this.heightFactor,
    required this.text,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widthFactor * 200,
      height: heightFactor * 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 20 * widthFactor,
            vertical: 10 * heightFactor,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Icon(
                icon,
                size: widthFactor * 18,
                color: Colors.white,
              ),
            SizedBox(width: 10 * widthFactor),
            Text(
              text,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: widthFactor * 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
