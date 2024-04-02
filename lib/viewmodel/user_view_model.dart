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

  Future<void> updateScoreUser(User user, int score) async {
    user.score = score;
    await database.rawUpdate(
      'UPDATE user SET score = ? WHERE name = ?',
      [score, user.name],
    );
    notifyListeners();
    refreshUsers();
  }

  Future<void> deleteUser(User user) async {
    await database.delete('user', where: 'name = ?', whereArgs: [user.name]);
    notifyListeners();
    refreshUsers();
  }

  Future<void> deleteAllUsers() async {
    await database.delete('user');
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
