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

  Future<void> updateScoreUser(User user) async {
    await database.rawUpdate(
      'UPDATE user SET score = ? WHERE id = ?',
      [user.score, user.id],
    );
    print('score updated : ${user.id} ${user.score}');
    notifyListeners();
    refreshUsers();
  }

  Future<void> verifId(User user) async {
    final List<Map<String, Object?>> userMaps = await database.query('user');
    for (int i = 0; i < userMaps.length; i++) {
      if (userMaps[i]['id'] == user.id) {
        await updateScoreUser(user);
        return;
      }
    }
    await insertUser(user);
  }

  Future<int> selectMaxId() async {
    final List<Map<String, dynamic>> userMaps = await database.query('user');
    int maxId = 0;
    for (int i = 0; i < userMaps.length; i++) {
      if (userMaps[i]['id'] > maxId) {
        maxId = userMaps[i]['id'] as int;
      }
    }
    return maxId;
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
        id: userMaps[i]['id'] as int,
        name: userMaps[i]['name'] as String,
        score: userMaps[i]['score'] as int,
        niveau: userMaps[i]['niveau'] as int,
      );
    });
  }
}
