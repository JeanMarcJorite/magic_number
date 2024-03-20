import 'package:flutter/material.dart';
import 'package:magic_number/button.dart';
import 'package:magic_number/page_jouer.dart';
import 'package:magic_number/page_score.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:magic_number/rules.dart';

void main() {
  runApp(const MagicNumber());
}

class MagicNumber extends StatelessWidget {
  const MagicNumber({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Magic Number',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(background: const Color(0xFFCEE4F2)),
      ),
      home: const MyHomePage(title: 'Magic Number'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  void navigateToPage1() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Page_Jouer()));
  }

  void navigateToPage2() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Page_Score()));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: const Color(0xFFCEE4F2),

      ),

       body: Column(
        children: [
          Center(
            child: Text(
              'Magic Number',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          ButtonSelect(
            text: 'Go to Page 1',
            onPressed: navigateToPage1,
          ),
          ButtonSelect(
            text: 'Go to Page 2',
            onPressed: navigateToPage2,
          ),
          ButtonSelect(
            text: 'Règles',
            onPressed: () => dialogBuilder(context),
          ),

        ],
      ),
    );
  }
}

Future<void> dialogBuilder(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Règles du jeu', style: GoogleFonts.getFont('Jomhuria', fontSize: 40)),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Thème et Contexte:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Dans cette version de l\'application inspirée par l\'univers de Jafar, les joueurs sont invités à découvrir le mystère du Nombre Magique de Jafar. Avec trois niveaux de difficulté, chacun offrant une expérience unique, les joueurs sont plongés dans un monde magique où leur logique et leur intuition sont mises à l\'épreuve.',
              ),
              SizedBox(height: 10),
              Text(
                'Règles du Jeu:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                '1. Niveau Facile: "Les Sables du Désert"\n'
                '- Le nombre magique est compris entre 1 et 20.\n'
                '- Les joueurs ont un maximum de 10 tentatives pour deviner le nombre magique.\n'
                '\n'
                '2. Niveau Moyen: "La Lampe Enchantée"\n'
                '- Le nombre magique est compris entre 1 et 50.\n'
                '- Les joueurs ont un maximum de 15 tentatives pour deviner le nombre magique.\n'
                '\n'
                '3. Niveau Difficile: "Les Mystères de la Caverne aux Merveilles"\n'
                '- Le nombre magique est compris entre 1 et 100.\n'
                '- Les joueurs ont un maximum de 20 tentatives pour deviner le nombre magique.',
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('JOUER'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}


