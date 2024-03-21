import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:magic_number/UI/button.dart';
import 'package:magic_number/UI/home.dart';
import 'package:magic_number/models/user.dart';
import 'package:magic_number/viewmodel/user_view_model.dart';
import 'package:provider/provider.dart';

class GamePlay extends StatelessWidget {
  final String playerName;

  const GamePlay({required this.playerName, super.key});

  @override
  Widget build(BuildContext context) {
    UserViewModel userViewModel =
        Provider.of<UserViewModel>(context, listen: false);
    userViewModel.insertUser(User(name: playerName, score: 0));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFCEE4F2),
        centerTitle: true ,
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
              'IN GAME',
              style: GoogleFonts.getFont('Jomhuria', fontSize: 65),
            ),
          ],
        ),
      ),
    );
  }
}
