import 'package:flutter/material.dart';

void main() {
  runApp(const MagicNumber());
}

class MagicNumber extends StatelessWidget {
  const MagicNumber({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFCEE4F2),
      ),
      body: Center(
        child: Text(
          'Magic Number',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      
    );
  }
}
