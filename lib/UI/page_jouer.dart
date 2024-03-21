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

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFCEE4F2),
      ),
      body: Center(
        child: ListView(
          children: [
            Text(
              'MAGIC NUMBER',
              style: GoogleFonts.getFont('Jomhuria', fontSize: 65),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: TextFormField(
                  controller: _numberController,
                  decoration: const InputDecoration(
                    labelText: "Entrez nom d'utilisateur",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Veuillez remplir le champ';
                    }
                    return null;
                  },
                ),
              ),
            ),
            ButtonSelect(
              text: 'Valider',
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  navigateToPage3();
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Erreur',  style: GoogleFonts.getFont('Jomhuria', fontSize: 40)),
                        content: const Text('Veuillez remplir le champ'),
                        actions: [
                          TextButton(
                            child: const Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
