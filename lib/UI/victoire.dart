import 'package:flutter/material.dart';
import 'package:magic_number/UI/home.dart';


class VictoirePage extends StatefulWidget {
  const VictoirePage({super.key});

  @override
  State<VictoirePage> createState() => _VictoirePage();
}

class _VictoirePage extends State<VictoirePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          // Navigate to the home page
        Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const MyHomePage(),
        ),
        (Route<dynamic> route) => false,
      );
        },
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/img/victoire.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}