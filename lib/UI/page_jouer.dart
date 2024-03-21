// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:magic_number/UI/button.dart';
import 'package:magic_number/UI/game.dart';

class Page_Jouer extends StatefulWidget {
  const Page_Jouer({super.key});

  @override
  State<Page_Jouer> createState() => Page_JouerState();
}

class Page_JouerState extends State<Page_Jouer> {
  final TextEditingController _numberController = TextEditingController();

  void navigateToPage3() {
    String value = _numberController.text;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => GamePlay(
          playerName: value,
        ),
      ),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFCEE4F2),
      ),
      body: Center(
        child: ListView(
          // Utilisez ListView au lieu de Column
          children: [
            Text(
              'MAGIC NUMBER',
              style: GoogleFonts.getFont('Jomhuria', fontSize: 65),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: _numberController,
                decoration: const InputDecoration(
                  labelText: 'Entrez votre prénom',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ButtonSelect(
              text: 'Valider',
              onPressed: navigateToPage3,
            ),
          ],
        ),
      ),
    );
  }
}
