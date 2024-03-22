import 'package:flutter/material.dart';
import 'package:magic_number/models/user.dart';
import 'package:sqflite/sqflite.dart';

class UserViewModel extends ChangeNotifier {
  late List<User> liste;
  final Database database;

  UserViewModel(this.database) {
    liste = [];
  }

  Future<void> insertUser(User user) async {
    await database.insert(
      'user',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    notifyListeners();
    refreshUsers();
  }

  void refreshUsers() {
    liste = [];
    users().then((List<User> usersInBD) {
      for (User user in usersInBD) {
        liste.add(user);
      }
    });
    notifyListeners();
  }

  Future<List<User>> users() async {
    final List<Map<String, Object?>> userMaps = await database.query('user');
    return List.generate(userMaps.length, (i) {
      return User(
        name: userMaps[i]['name'] as String,
        score: userMaps[i]['score'] as int,
      );
    });

    }
  }

