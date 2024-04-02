// ignore_for_file: prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:magic_number/UI/home.dart';
import 'package:magic_number/models/random_number.dart';
import 'package:magic_number/UI/victoire.dart';
import 'package:magic_number/UI/perdu.dart';
import 'package:magic_number/models/user.dart';
import 'package:magic_number/viewmodel/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:magic_number/UI/page_score.dart';

class Niveau extends StatefulWidget {
  final int level;
  final String playerName;

  Niveau({super.key, required this.level, required this.playerName});

  @override
  _NiveauState createState() => _NiveauState();
}

class _NiveauState extends State<Niveau> {
  final _formKey = GlobalKey<FormState>();
  late RandomNumber randomNumber;
  late int nbChercher;
  String message = '';
  int currentIndex = 0;
  
  get pageController => null;

  @override
  void initState() {
    super.initState();
    randomNumber = RandomNumber(level: widget.level);
  }

  updateScore(int scoreUser) async {
    UserViewModel userViewModel =
        Provider.of<UserViewModel>(context, listen: false);
    final user = User(name: widget.playerName, score: scoreUser);
    await userViewModel.updateScoreUser(user, user.score);
  }

  void submitNbChercher() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        message = randomNumber.compare(nbChercher);
        randomNumber.coup();
        if (randomNumber.nbCoupsRestants > 0 &&
            randomNumber.findNumber == nbChercher) {
          updateScore(randomNumber.nbCoupsRestants);

          navigationVictoire();
        } else if (randomNumber.isGameOver) {
          message = 'Perdu! Le nombre magique était ${randomNumber.findNumber}';
          navigationPerdu();
        }
      });
    }
  }

  void navigationPerdu() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const PerdrePage(),
      ),
      (Route<dynamic> route) => false,
    );
  }

  void navigationVictoire() {
    if (randomNumber.nbCoupsRestants > 0) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const VictoirePage(),
        ),
        (Route<dynamic> route) => false,
      );
    }
  }



  Text textNiveau() {
    if (widget.level == 1) {
      return Text('Le nombre magique est compris entre 1 et 20.', style: GoogleFonts.getFont('Jomhuria', fontSize: 30));
    } else if (widget.level == 2) {
      return Text('Le nombre magique est compris entre 1 et 50', style: GoogleFonts.getFont('Jomhuria', fontSize: 30));
    } else {
      return Text('Le nombre magique est compris entre 1 et 100', style: GoogleFonts.getFont('Jomhuria', fontSize: 30));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Niveau ${widget.level}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Image.asset('assets/img/jafarGame.png', width: 300, height: 200),
              Text(
                'Nombre d\'essais restants: ${randomNumber.nbCoupsRestants}',
                style: GoogleFonts.getFont('Jomhuria', fontSize: 30),
              ),
              textNiveau(),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Entrez un nombre',
                  labelStyle: GoogleFonts.getFont('Jomhuria', fontSize: 30),
                  border: const OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un nombre';
                  }
                  return null;
                },
                onSaved: (value) {
                  nbChercher = int.parse(value!);
                },
              ),
              ElevatedButton(
                onPressed: submitNbChercher,
                child: const Text('TESTER'),
              ),
              Text(message),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Score',
            ),
          ],
          onTap: (value) => setState(() {
                currentIndex = value;
                if (currentIndex == 0) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) =>  const MyHomePage()),
                    (Route<dynamic> route) => false,
                  );
                } else {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const Page_Score()),
                    (Route<dynamic> route) => true,
                  );
                }
              })
        ),
    );
  }
}
