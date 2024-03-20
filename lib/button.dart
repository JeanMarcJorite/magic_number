import 'package:flutter/material.dart';

class ButtonSelect extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final Color buttonColor;
  final Color textColor;

  const ButtonSelect({
    super.key,
    required this.text,
    required this.onPressed,
    this.buttonColor = const Color(0xFF1B2F48),
    this.textColor = const Color(0xFFF5F5F5),
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
        style: TextStyle(color: textColor),
      ),
    );
  }
}
