import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:magic_number/UI/button.dart';
import 'package:magic_number/UI/home.dart';
import 'package:magic_number/UI/niveau.dart';


class GamePlay extends StatelessWidget {
  final String playerName;

  const GamePlay({required this.playerName, super.key});

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFCEE4F2),
        centerTitle: true,
        title: GestureDetector(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const MyHomePage()),
                (Route<dynamic> route) => false,
              );
            },
            child: Image.asset('assets/img/logo.png',
                width: 70, height: 60, fit: BoxFit.cover)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(
              'Bienvenue, $playerName',
              style: GoogleFonts.getFont('Jomhuria', fontSize: 60),
            ),
            Text(
              'Choisisez un niveau',
              style: GoogleFonts.getFont('Jomhuria', fontSize: 50),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ButtonSelect(
                text: 'FACILE',
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Niveau(level: 1, playerName: playerName)));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ButtonSelect(
                text: 'MOYEN',
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  Niveau(level:  2, playerName: playerName)));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ButtonSelect(
                text: 'DIFFICILE',
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Niveau(level: 3, playerName: playerName)));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
