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

  Future<void> updateScore(String name, int score) async {
    print('Updating score for user: $name');

    final List<Map<String, dynamic>> allUsers = await database.query('user');
    print('All users: $allUsers');

    final List<Map<String, dynamic>> maps =
        await database.query('user', where: 'name = ?', whereArgs: [name]);
    if (maps.isNotEmpty) {
      final user = User.fromMap(maps.first);
      user.score = score;
      await database
          .update('user', user.toMap(), where: 'name = ?', whereArgs: [name]);
      print('User updated: $user');
      notifyListeners();
      refreshUsers();
    } else {
      print('User not found');
    }
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
