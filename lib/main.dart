import 'package:flutter/material.dart';
import 'package:magic_number/UI/home.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:magic_number/viewmodel/user_view_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = openDatabase(
    join(await getDatabasesPath(), 'user_database.db'),
    onCreate: (db, version) async {
      return await db.execute(
        'CREATE TABLE user(id INTEGER PRIMARY KEY, name TEXT, score INTEGER, niveau INTEGER)',
      );
    },
    version: 1,
  );

  final db = await database;

  runApp(MagicNumber(db));
}

class MagicNumber extends StatelessWidget {
  final Database database;
  const MagicNumber(this.database, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            UserViewModel userViewModel = UserViewModel(database);
            userViewModel.refreshUsers();
            return userViewModel;
          },
        ),
        Provider<Database>.value(value: database),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Magic Number',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(background: const Color(0xFFCEE4F2)),
        ),
        home: const MyHomePage(),
      ),
    );
  }
}
