// ignore_for_file: file_names

import 'dart:math';

class RandomNumber {
  late int _findNumber;
  late int _nbCoupsRestants;

  RandomNumber({required int level}) {
    if (level == 1) {
      _nbCoupsRestants = 10;
      _findNumber = Random().nextInt(20) + 1;
    } else if (level == 2) {
      _nbCoupsRestants = 15;
      _findNumber = Random().nextInt(50) + 1;
    } else {
      _nbCoupsRestants = 20;
      _findNumber = Random().nextInt(100) + 1;
    }
  }

  String compare(int number) {
    if (number < findNumber) {
      return 'Votre nombre est inférieur au mien';
    } else {
      return 'Votre nombre est supérieur au mien';
    }
  }

  bool get isGameOver => nbCoupsRestants <= 0;

  int get nbCoupsRestants => _nbCoupsRestants;

  int get findNumber => _findNumber;

  void coup(){
    _nbCoupsRestants--;
  }

  @override
  String toString() {
    return 'RandomNumber{findNumber: $findNumber, nbCoups: $nbCoupsRestants}';
  }
}
