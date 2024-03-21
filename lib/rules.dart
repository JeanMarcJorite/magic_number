import 'package:flutter/material.dart';
import 'package:magic_number/button.dart';
import 'package:magic_number/page_jouer.dart';
import 'package:magic_number/page_score.dart';
import 'package:google_fonts/google_fonts.dart';

class DialogExample extends StatelessWidget {
  const DialogExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('showDialog Sample')),
      body: Center(
        child: OutlinedButton(
          onPressed: () => _dialogBuilder(context),
          child: const Text('Règles'),
        ),
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Règles du MAGIC NUMBER'),
          content: const Text(
            'A dialog is a type of modal window that\n'
            'appears in front of app content to\n'
            'provide critical information, or prompt\n'
            'for a decision to be made.',
          ),
          actions: <Widget>[
            
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Accepter'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}