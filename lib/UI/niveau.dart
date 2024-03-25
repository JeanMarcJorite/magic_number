// ignore_for_file: prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:magic_number/UI/home.dart';
import 'package:magic_number/models/random_number.dart';
import 'package:magic_number/UI/victoire.dart';
import 'package:magic_number/UI/perdu.dart';
class Niveau extends StatefulWidget {
  final int level;

  Niveau({super.key, required this.level});

  @override
  _NiveauState createState() => _NiveauState();
}

class _NiveauState extends State<Niveau> {
  final _formKey = GlobalKey<FormState>();
  late RandomNumber randomNumber;
  late int nbChercher;
  String message = '';

  @override
  void initState() {
    super.initState();
    randomNumber = RandomNumber(level: widget.level);
  }

  void submitNbChercher() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        message = randomNumber.compare(nbChercher);
        randomNumber.coup();
        if (randomNumber.nbCoupsRestants > 0 && randomNumber.findNumber == nbChercher) {
          navigationVictoire();
        } else
        if (randomNumber.isGameOver) {
          message = 'Perdu! Le nombre magique était ${randomNumber.findNumber}';
          navigationPerdu();
        }
      });
    }
  }

  void navigationPerdu(){
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

  @override
  Widget build(BuildContext context) {
    print(randomNumber.findNumber);
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
              Image.asset('assets/img/jafarGame.png',
                width: 300, height: 200),
                Text(
                'Nombre d\'essais restants: ${randomNumber.nbCoupsRestants}',
                style: GoogleFonts.getFont('Jomhuria', fontSize: 40),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Entrez un nombre',
                  labelStyle: GoogleFonts.getFont('Jomhuria', fontSize: 40),
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
    );
  }
}
