import 'package:flutter/material.dart';
import 'package:magic_number/button.dart';
import 'package:magic_number/page_jouer.dart';
import 'package:magic_number/page_score.dart';
import 'package:google_fonts/google_fonts.dart';

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
        ],
      ),
    );
  }
}