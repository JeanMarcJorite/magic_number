import 'package:flutter/material.dart';

class Page_Score extends StatelessWidget {
  

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 2'),
      ),
      body: const Center(
        child: Text(
          'Page 1',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

