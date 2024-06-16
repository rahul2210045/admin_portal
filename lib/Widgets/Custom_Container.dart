import 'package:admin_portal/Widgets/Screensize.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//CustomHeadingText class for styling heading text
class CustomRoundedContainer extends StatelessWidget {
  final Widget child;
  final double height;
  final double width;
  final double borderRadiusRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  CustomRoundedContainer({
    required this.child,
    required this.height,
    required this.width,
    this.borderRadiusRadius = 10,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadiusRadius),
        color: Colors.white,
      ),
      child: child,
    );
  }
}
//CustomHeadingText class for styling heading text

class CustomHeadingText extends StatelessWidget {
  final String text;

  CustomHeadingText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.inter(
          textStyle: TextStyle(
              fontSize: 32 * widthFactor(context) * heightFactor(context),
              // color: col,
              fontWeight: FontWeight.w700),
        ));
  }
}
