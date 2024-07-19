import 'package:flutter/material.dart';

class feedback_button extends StatefulWidget {
  final String text;
  final double buttonHeight;
  final double buttonWidth;
  final double fontSize;
  void Function()? onTap;
  feedback_button(
      {super.key,
      required this.text,
      required this.buttonHeight,
      required this.buttonWidth,
      this.onTap,
      required this.fontSize});

  @override
  State<feedback_button> createState() => _feedback_buttonState();
}

class _feedback_buttonState extends State<feedback_button> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.buttonHeight,
      width: widget.buttonWidth,
      child: ElevatedButton(
        onPressed: widget.onTap,
        child: Text(widget.text),
        style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(primaryColor),
            foregroundColor: WidgetStatePropertyAll(Colors.white),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5)))),
      ),
    );
  }
}
