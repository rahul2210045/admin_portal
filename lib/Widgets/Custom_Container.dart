// import 'package:admin_portal/Widgets/Screensize.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// //CustomHeadingText class for styling heading text
// class CustomRoundedContainer extends StatelessWidget {
//   final Widget child;
//   final double height;
//   final double width;
//   final double borderRadiusRadius;
//   final EdgeInsetsGeometry? padding;
//   final EdgeInsetsGeometry? margin;
//   final Color? color;


//   CustomRoundedContainer({
//     required this.child,
//     required this.height,
//     required this.width,
//     this.borderRadiusRadius = 10,
//     this.padding,
//     this.margin, this.color,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: height,
//       width: width,
//       margin: margin,
//       padding: padding,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(borderRadiusRadius),
//         color: color,
//       ),
//       child: child,
//     );
//   }
// }
// //CustomHeadingText class for styling heading text

// class CustomHeadingText extends StatelessWidget {
//   final String text;

//   CustomHeadingText({required this.text});

//   @override
//   Widget build(BuildContext context) {
//     return Text(text,
//         style: GoogleFonts.inter(
//           textStyle: TextStyle(
//               fontSize: 32 * widthFactor(context) * heightFactor(context),
//               // color: col,
//               fontWeight: FontWeight.w700),
//         ));
//   }
// }
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomRoundedContainer extends StatelessWidget {
  final Widget child;
  final double height;
  final double width;
  final double borderRadiusRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;

  CustomRoundedContainer({
    required this.child,
    required this.height,
    required this.width,
    this.borderRadiusRadius = 10,
    this.padding,
    this.margin,
    this.color,
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
        color: color,
      ),
      child: child,
    );
  }
}

class CustomHeadingText extends StatelessWidget {
  final String text;

  CustomHeadingText({required this.text});

  @override
  Widget build(BuildContext context) {
    double heightFactor = MediaQuery.of(context).size.height / 1024;
    double widthFactor = MediaQuery.of(context).size.width / 1440;

    return Text(
      text,
      style: GoogleFonts.inter(
        textStyle: TextStyle(
          fontSize: 32 * widthFactor * heightFactor,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
