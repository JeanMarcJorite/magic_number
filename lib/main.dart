import 'package:flutter/material.dart';
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
  TextEditingController _numberController = TextEditingController();

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFCEE4F2),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'MAGIC NUMBER',
              style: GoogleFonts.getFont('Jomhuria', fontSize: 65),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: _numberController,
                decoration: const InputDecoration(
                  labelText: 'Entrez votre prénom',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
        
      ),
      
    );
  }
}
