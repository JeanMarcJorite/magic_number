// ignore_for_file: prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:magic_number/UI/home.dart';
import 'package:magic_number/models/random_number.dart';

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
    randomNumber.nbCoupsFait++;
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        message = randomNumber.compare(nbChercher);
        if (randomNumber.isGameOver) {
          message = 'Perdu! Le nombre magique était ${randomNumber.findNumber}';
          navigationHome();
        }
      });
    }
  }

  void navigationHome() {
    if (randomNumber.nbCoupsRestants < 0) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const MyHomePage(),
        ),
        (Route<dynamic> route) => false,
      );
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
              Text(
                'Nombre à trouver: ${randomNumber.findNumber}',
                style: GoogleFonts.getFont('Jomhuria', fontSize: 40),
              ),
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
                child: const Text('Soumettre'),
              ),
              Text(message),
            ],
          ),
        ),
      ),
    );
  }
}
