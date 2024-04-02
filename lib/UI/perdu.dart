import 'package:flutter/material.dart';
import 'package:magic_number/UI/home.dart';


class PerdrePage extends StatefulWidget {
  const PerdrePage({super.key});

  @override
  State<PerdrePage> createState() => _PerdrePage();
}

class _PerdrePage extends State<PerdrePage> {
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
              image: AssetImage('assets/img/perdu.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}