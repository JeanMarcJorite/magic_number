import 'package:flutter/material.dart';
import 'package:magic_number/UI/button.dart';
import 'package:magic_number/UI/page_jouer.dart';
import 'package:magic_number/UI/page_score.dart';
import 'package:google_fonts/google_fonts.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void navigateToPage1() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Page_Jouer()));
  }

  void navigateToPage2() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Page_Score()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFCEE4F2),
      ),
      body: SingleChildScrollView(
        // Solution 3
        child: Column(
          children: [
            Image.asset('assets/img/logo.png',
                width: 450, height: 300, fit: BoxFit.cover),
            Center(
              child: Text(
                'MAGIC NUMBER',
                style: GoogleFonts.getFont('Jomhuria',
                    fontSize: 65, color: const Color(0xFF1B2F48)),
              ),
            ),
            ButtonSelect(
              text: 'JOUER',
              onPressed: navigateToPage1,
            ),
            ButtonSelect(
              text: 'SCORES',
              onPressed: navigateToPage2,
            ),
          ],
        ),
      ),
    );
  }
}
