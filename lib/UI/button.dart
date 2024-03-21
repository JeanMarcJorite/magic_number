import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonSelect extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final Color buttonColor;
  final Color textColor;
  final String textStyle;

  const ButtonSelect({
    super.key,
    required this.text,
    required this.onPressed,
    this.buttonColor = const Color(0xFF1B2F48),
    this.textColor = const Color(0xFFF5F5F5),
    this.textStyle = "Jomhuria",
  });


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
      ),
      child: Text(
        text,
        style: GoogleFonts.getFont(textStyle,
                fontSize: 35, color: textColor),
      ),
    );
  }
}
