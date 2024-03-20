import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class Page_Jouer extends StatelessWidget {
  

  
  @override
  Widget build(BuildContext context) {
    TextEditingController _numberController = TextEditingController();
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
